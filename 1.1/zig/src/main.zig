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

    var byteIndex: usize = 0;
    var freqBuffer = try Buffer.initSize(allocator, 0);
    defer freqBuffer.deinit();
    while (byteIndex < rawFreqData.len) {
        switch (rawFreqData[byteIndex]) {
            '\r' => {
                byteIndex += 1;
            },
            '\n' => {
                freq = freq + (try fmt.parseInt(i64, freqBuffer.toSlice(), 10));
                try freqBuffer.resize(0);
                byteIndex += 1;
            },
            else => {
                try freqBuffer.appendByte(rawFreqData[byteIndex]);
                byteIndex += 1;
            },
        }
    }

    if (freqBuffer.len() > 0) {
        freq = freq + (try fmt.parseInt(i64, freqBuffer.toSlice(), 10));
        try freqBuffer.resize(0);
    }

    std.debug.warn("Resulting Frequency: {}\n", freq);
}