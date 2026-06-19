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

pub fn match(input: []const u8, expr: []const u8) MatchError!bool {
    if (expr.len > 0) {
        if (std.mem.eql(u8, expr, "\\d")) {
            // if expression is numeric
            const found = std.mem.indexOfAny(u8, input, num) != null;
            if (found) std.debug.print("{s}\n", .{input});
            return found;
        } else if (std.mem.eql(u8, expr, "\\D")) {
            // if expression isn't numeric
            const found = std.mem.indexOfAny(u8, input, num) == null;
            if (found) std.debug.print("{s}\n", .{input});
            return found;
        } else if (std.mem.eql(u8, expr, "\\w")) {
            // if expression is alphanumeric
            const found = std.mem.indexOfAny(u8, input, num ++ lower ++ upper) != null;
            if (found) std.debug.print("{s}\n", .{input});
            return found;
        } else if (std.mem.eql(u8, expr, "\\W")) {
            // if expression isn't alphanumeric
            const found = std.mem.indexOfAny(u8, input, num ++ lower ++ upper) == null;
            if (found) std.debug.print("{s}\n", .{input});
            return found;
        } else if (std.mem.eql(u8, expr, "\\s")) {
            // if expression is a space, tab, newline, carriage return
            const found = std.mem.indexOfAny(u8, input, space) != null;
            if (found) std.debug.print("{s}\n", .{input});
            return found;
        } else {
            // if exact match
            const found = std.mem.indexOf(u8, input, expr) != null;
            if (found) std.debug.print("{s}\n", .{input});
            return found;
        }
    } else {
        return MatchError.NoExpression;
    }
}
