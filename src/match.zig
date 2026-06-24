const std = @import("std");

// i think these get optimized with comptime
const num = "0123456789";
const lower = "abcdefghijklmnopqrstuvwxyz";
const upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const space = " \t\n\r";

// custom error types here. Errors are for control flow.
const MatchError = error{
    NoExpression,
};

// the character classes we recognise; anything else falls through to a literal match
const Class = enum { @"\\d", @"\\D", @"\\w", @"\\W", @"\\s" };

pub fn match(input: []const u8, expr: []const u8) MatchError!bool {
    if (expr.len > 0) {
        const found = if (std.meta.stringToEnum(Class, expr)) |class| switch (class) {
            .@"\\d" => std.mem.indexOfAny(u8, input, num) != null, // if expression is numeric
            .@"\\D" => std.mem.indexOfAny(u8, input, num) == null, // if expression isn't numeric
            .@"\\w" => std.mem.indexOfAny(u8, input, num ++ lower ++ upper) != null, // if expression is alphanumeric
            .@"\\W" => std.mem.indexOfAny(u8, input, num ++ lower ++ upper) == null, // if expression isn't alphanumeric
            .@"\\s" => std.mem.indexOfAny(u8, input, space) != null, // if expression is a space, tab, newline, carriage return
        } else std.mem.indexOf(u8, input, expr) != null; // if exact match
        if (found) std.debug.print("{s}\n", .{input});
        return found;
    } else {
        return MatchError.NoExpression;
    }
}
