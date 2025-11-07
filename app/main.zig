const Metadata = @import("meta.zig");
const std = @import("std");
const zx = @import("zx");

// Check whether a TCP port can be bound
fn isPortAvailable(port: u16) bool {
    const address = std.net.Address.parseIp("0.0.0.0", port) catch return false;
    const socket = std.posix.socket(std.posix.AF.INET, std.posix.SOCK.STREAM, 0) catch return false;
    defer std.posix.close(socket);

    // Enable SO_REUSEADDR to avoid TIME_WAIT issues
    std.posix.setsockopt(socket, std.posix.SOL.SOCKET, std.posix.SO.REUSEADDR, &std.mem.toBytes(@as(c_int, 1))) catch {};
    
    // Try to bind to the target port
    std.posix.bind(socket, &address.any, address.getOsSockLen()) catch |err| switch (err) {
        error.AddressInUse => return false,
        else => return true,
    };

    return true;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Allow overriding via ZX_PORT env var, otherwise use default
    var default_port: u16 = 5882;
    const env_port = std.process.getEnvVarOwned(allocator, "ZX_PORT") catch null;
    if (env_port) |port_str| {
        default_port = std.fmt.parseInt(u16, port_str, 10) catch 5882;
        allocator.free(port_str);
    }

    // Probe sequential ports until one works
    var port = default_port;
    var app: *zx.App = undefined;
    var attempts: u16 = 0;
    const max_attempts: u16 = 20; // Hard stop to avoid infinite loops

    while (attempts < max_attempts) : (attempts += 1) {
        if (!isPortAvailable(port)) {
            std.debug.print("Port {d} already in use, trying the next one...\n", .{port});
            port += 1;
            continue;
        }

        const config = zx.App.Config{
            .server = .{ .port = port, .address = "0.0.0.0" },
            .meta = &Metadata.meta,
        };

        std.debug.print("Attempting to start server on port {d}\n", .{port});
        
        app = zx.App.init(allocator, config) catch |err| {
            std.debug.print("Server init failed: {any}; trying next port...\n", .{err});
            port += 1;
            continue;
        };

        // Initialization succeeded
        break;
    }

    if (attempts >= max_attempts) {
        std.debug.print("Error: unable to start server on any port (tried {d})\n", .{max_attempts});
        return error.CannotStartServer;
    }

    defer app.deinit();

    std.debug.print("{s}\n  - Local: http://localhost:{d}\n", .{ zx.App.info, port });
    try app.start();
}
