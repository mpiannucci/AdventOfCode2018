const std = @import("std");
const mem = std.mem;
const allocator = std.debug.global_allocator;
const os = std.os;
const io = std.io;
const Buffer = std.Buffer;

pub fn main() anyerror!void {
    const inputFilePath = try os.path.join(allocator, "..", "input.txt");
    const rawBoxIds = try io.readFileAlloc(allocator, inputFilePath);

    var commonBoxIdBuffer = Buffer.initNull(allocator);
    defer commonBoxIdBuffer.deinit();

    var boxIdIter = mem.split(rawBoxIds, "\n");
    outer: while (boxIdIter.next()) |boxId| {
        var otherBoxIdIter = mem.split(rawBoxIds, "\n");
        while (otherBoxIdIter.next()) |otherBoxId| {
            try commonBoxIdBuffer.resize(0);
            var diffCount: u8 = 0;
            for (boxId) |char, i| {
                if (boxId[i] != otherBoxId[i]) {
                    diffCount += 1;
                } else {
                    try commonBoxIdBuffer.appendByte(char);
                }
            }
            
            if (diffCount == 1) {
                break :outer;
            }
        }
    }

    std.debug.warn("Common Box ID: {}", commonBoxIdBuffer.toOwnedSlice());
}
