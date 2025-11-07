pub const packages = struct {
    pub const @"../http.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/../http.zig";
        pub const build_zig = @import("../http.zig");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "../metrics.zig" },
            .{ "websocket", "../websocket.zig" },
        };
    };
    pub const @"../metrics.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/../metrics.zig";
        pub const build_zig = @import("../metrics.zig");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"../websocket.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/../websocket.zig";
        pub const build_zig = @import("../websocket.zig");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"../zx" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/../zx";
        pub const build_zig = @import("../zx");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "httpz", "../http.zig" },
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "httpz", "../http.zig" },
    .{ "zx", "../zx" },
};
