const std = @import("std");
const os = std.os;
const io = std.io;
const mem = std.mem;
const allocator = std.debug.global_allocator;
const fmt = std.fmt;
const assert = std.debug.assert;

pub fn main() anyerror!void {
    const inputFilePath = try os.path.join(allocator, "..", "input.txt");
    const rawClaims = try io.readFileAlloc(allocator, inputFilePath);

    var claimMap = [][1000]u8{[]u8{0} ** 1000} ** 1000;

    var lines = mem.split(rawClaims, "\n");
    while (lines.next()) |line| {
        var rawClaim = mem.dupe(allocator, u8, line) catch unreachable;
        defer allocator.free(rawClaim);

        var rect = Rectangle.initFromString(rawClaim);

        for (claimMap[rect.left..rect.left+rect.width]) |*outerSlice| {
            for (outerSlice[rect.top..rect.top+rect.height]) |*designSlice| {
                designSlice.* += 1;
            }
        }
    }

    var squareInches: i32 = 0;
    for (claimMap) |*outer| {
        for (outer) |*inner| {
            if (inner.* > 1) {
                squareInches += 1;
            }
        }
    }

    std.debug.warn("Common Square Inches: {}", squareInches);
}

const Rectangle = struct {
    claimId: []const u8,
    left: usize,
    top: usize,
    width: usize, 
    height: usize,

    pub fn initFromString(input: [] u8) Rectangle {
        var components = mem.split(input, " ");

        var rectangle = Rectangle {
            .claimId = components.next() orelse "",
            .left = undefined,
            .top = undefined,
            .width = undefined,
            .height = undefined,
        };

        // Skip the @
        _ = components.next();

        var rawCoords = mem.trimRight(u8, components.next() orelse "0,0", ":");

        var coords = mem.split(rawCoords, ",");
        rectangle.left = fmt.parseInt(usize, coords.next() orelse "0", 10) catch 0;
        rectangle.top = fmt.parseInt(usize, coords.next() orelse "0", 10) catch 0;

        const rawDims = fmt.trim(components.next() orelse "0x0");
        var dims = mem.split(rawDims, "x");
        rectangle.width = fmt.parseInt(usize, dims.next() orelse "0", 10) catch 0;
        rectangle.height = fmt.parseInt(usize, dims.next() orelse "0", 10) catch 0;

        return rectangle;
    }
};

test "rect parse" {
    var input = "#40 @ 369,895: 11x27";
    var rect = Rectangle.initFromString(input[0..]);

    assert(mem.eql(u8, rect.claimId, "#40"));
    assert(rect.left == 369);
    assert(rect.top == 895);
    assert(rect.width == 11);
    assert(rect.height == 27);
}