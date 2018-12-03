use std::fs::File;
use std::io::prelude::*;
use std::string::String;

fn main() {
    let mut freq = 0;

    let mut raw_frequencies = String::new();
    File::open("data/input.txt")
        .expect("Unable to read from input.txt")
        .read_to_string(&mut raw_frequencies)
        .expect("Unable to feed contents to string");

    for raw_freq in raw_frequencies.lines() {
        match &raw_freq[..1] {
            "+" => freq += &raw_freq[1..].parse::<i64>().unwrap(),
            "-" => freq -= &raw_freq[1..].parse::<i64>().unwrap(),
            _ => println!("Parsed unexpected value... ignoring"),
        };
    }

    println!("Resulting Frequency: {}", freq);
}
