const std = @import("std");
const match = @import("match.zig").match;

pub fn main(init: std.process.Init) !u8 {
    const io = init.io;

    var stdin_buffer: [8192]u8 = undefined;
    var stdin_reader = std.Io.File.stdin().readerStreaming(io, &stdin_buffer);
    const stdin = &stdin_reader.interface;

    // var stdout_buffer: [8192]u8 = undefined;
    // var stdout_writer = std.Io.File.stdout().writer(io, &stdout_buffer);
    // const stdout = &stdout_writer.interface;

    const args = try init.minimal.args.toSlice(init.arena.allocator());
    // std.debug.print("{s}\n", .{args[1]});

    if (!std.mem.eql(u8, args[1], "-e")) {
        std.debug.print("Argument '-e' not found.\n", .{});
        return 1;
    }

    const input = try stdin.takeDelimiter('\n');
    const expr = args[2];

    // here
    const matched = match(input.?, expr);

    if (try matched) {
        return 0;
    } else {
        return 1;
    }
}
