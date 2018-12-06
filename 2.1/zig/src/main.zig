const std = @import("std");
const mem = std.mem;
const allocator = std.debug.global_allocator;
const os = std.os;
const io = std.io;
const hashMap = std.hash_map;

pub fn main() anyerror!void {
    const inputFilePath = try os.path.join(allocator, "..", "input.txt");
    const rawBoxIds = try io.readFileAlloc(allocator, inputFilePath);

    var twoRepeatCount: i32 = 0;
    var threeRepeatCount: i32 = 0;

    var boxIdIter = std.mem.split(rawBoxIds, "\n");
    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();
    while (boxIdIter.next()) |boxId| {
        var letterCountHash = hashMap.AutoHashMap(u8, u8).init(&direct_allocator.allocator);
        defer letterCountHash.deinit();

        for (boxId) |char| {
            const res = try letterCountHash.getOrPut(char);
            if (res.found_existing) {
                res.kv.value += 1;
            } else {
                res.kv.value = 1;
            }
        }

        var letterCountIterator = letterCountHash.iterator();
        var twoRepeatFound = false;
        var threeRepeatFound = false;
        while (letterCountIterator.next()) |letterCount| {
            if (letterCount.value == 2 and !twoRepeatFound) {
                twoRepeatCount += 1;
                twoRepeatFound = true;
            } else if (letterCount.value == 3 and !threeRepeatFound) {
                threeRepeatCount += 1;
                threeRepeatFound = true;
            }

            if (twoRepeatFound and threeRepeatFound) {
                break;
            }
        }
    }

    std.debug.warn("Checksum: {}", twoRepeatCount * threeRepeatCount);
}
