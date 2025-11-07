pub const packages = struct {
    pub const @"libs/http.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/http.zig";
        pub const build_zig = @import("libs/http.zig");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "libs/http.zig/libs/metrics.zig" },
            .{ "websocket", "libs/http.zig/libs/websocket.zig" },
        };
    };
    pub const @"libs/http.zig/libs/metrics.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/http.zig/libs/metrics.zig";
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"libs/http.zig/libs/websocket.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/http.zig/libs/websocket.zig";
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"libs/metrics.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/metrics.zig";
        pub const build_zig = @import("libs/metrics.zig");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"libs/websocket.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/websocket.zig";
        pub const build_zig = @import("libs/websocket.zig");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"libs/zx" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/zx";
        pub const build_zig = @import("libs/zx");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "httpz", "libs/zx/libs/http.zig" },
        };
    };
    pub const @"libs/zx/libs/http.zig" = struct {
        pub const build_root = "/Users/luke/WebstormProjects/zig-projects/zx-demo/libs/zx/libs/http.zig";
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "httpz", "libs/http.zig" },
    .{ "metrics", "libs/metrics.zig" },
    .{ "websocket", "libs/websocket.zig" },
    .{ "zx", "libs/zx" },
};
