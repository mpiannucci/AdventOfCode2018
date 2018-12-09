const std = @import("std");
const os = std.os;
const io = std.io;
const mem = std.mem;
const allocator = std.debug.global_allocator;
const fmt = std.fmt;
const assert = std.debug.assert;
const hash_map = std.hash_map;

pub fn main() anyerror!void {
    const inputFilePath = try os.path.join(allocator, "..", "input.txt");
    const rawGuardSchedules = try io.readFileAlloc(allocator, inputFilePath);

    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();

    const sleep_schedule = []u8{0} ** 60;

    var guardHashMap = hash_map.AutoHashMap(u32, [60]u8).init(&direct_allocator.allocator);

    var rawScheduleIter = mem.split(rawGuardSchedules, "\n");
    while (rawScheduleIter.next()) |rawSchedule| {

    }
}

const TimeStamp = struct {
    year: u32,
    month: u32,
    day: u32,
    hour: u32,
    minute: u32,

    fn initFromString(rawStamp: []u8) TimeStamp {
        return TimeStamp {
            .year = undefined,
            .month = undefined,
            .day = undefined,
            hour = undefined,
            minute = undefined,
        }
    }
}