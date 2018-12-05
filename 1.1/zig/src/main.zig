const std = @import("std");
const io = std.io;
const fmt = std.fmt;
const os = std.os;
const Buffer = std.Buffer;
const allocator = std.debug.global_allocator;

pub fn main() anyerror!void {
    const inputFilePath = try os.path.join(allocator, "..", "input.txt");
    const rawFreqData = try io.readFileAlloc(allocator, inputFilePath);

    var freq: i64 = 0;

    var lines = std.mem.split(rawFreqData, "\n");
    while (lines.next()) |line| {
        const raw_freq = fmt.trim(line);
        freq += fmt.parseInt(i64, raw_freq, 10) catch 0;
    }

    std.debug.warn("Resulting Frequency: {}\n", freq);
}