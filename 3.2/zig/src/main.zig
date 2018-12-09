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

    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();
    var rectList = std.ArrayList(Rectangle).init(&direct_allocator.allocator);
    defer rectList.deinit();

    var lines = mem.split(rawClaims, "\n");
    while (lines.next()) |line| {
        var rawClaim = mem.dupe(allocator, u8, line) catch unreachable;
        defer allocator.free(rawClaim);

        var rectangle = Rectangle.initFromString(rawClaim);
        try rectList.append(rectangle);
    }

    var uniqueClaimId: u32 = 0;
    var rectIterator = rectList.iterator();
    outer: while (rectIterator.next()) |rect| {
        var isUnique = true;
        var otherRectIterator = rectList.iterator();
        inner: while (otherRectIterator.next()) |otherRect| {
            if (rect.claimId == otherRect.claimId) {
                continue;
            }
            if (rect.doesOverlap(otherRect)) {
                isUnique = false;
                break :inner;
            }
        }

        if (isUnique) {
            uniqueClaimId = rect.claimId;
            break :outer;
        }
    }

    std.debug.warn("Unique Claim ID: {}\n", uniqueClaimId);
}

const Rectangle = struct {
    claimId: u32,
    left: usize,
    top: usize,
    width: usize, 
    height: usize,

    pub fn initFromString(input: [] u8) Rectangle {
        var components = mem.split(input, " ");

        var rectangle = Rectangle {
            .claimId = undefined,
            .left = undefined,
            .top = undefined,
            .width = undefined,
            .height = undefined,
        };

        rectangle.claimId = fmt.parseInt(u32, mem.trimLeft(u8, components.next() orelse "#0", "#"), 10) catch 0;

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

    pub fn doesOverlap(self: Rectangle, other: Rectangle) bool {

        if (self.left > other.left + other.width) {
            return false;
        } else if (self.top > other.top + other.height) {
            return false;
        } else if (other.left > self.left + self.width) {
            return false;
        } else if (other.top > self.top + self.height) {
            return false;
        }

        return true;
    }
};

test "rect parse" {
    var input = "#40 @ 369,895: 11x27";
    var rect = Rectangle.initFromString(input[0..]);

    assert(rect.claimId == 40);
    assert(rect.left == 369);
    assert(rect.top == 895);
    assert(rect.width == 11);
    assert(rect.height == 27);
}




