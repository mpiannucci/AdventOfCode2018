use std::fs::File;
use std::io::prelude::*;
use std::string::String;
use std::collections::HashSet;

fn main() {
    let mut freq: i64 = 0;
    let mut found_freqs: HashSet<i64> = HashSet::new();

    let mut raw_frequencies = String::new();
    File::open("./../input.txt")
        .expect("Unable to read from input.txt")
        .read_to_string(&mut raw_frequencies)
        .expect("Unable to feed contents to string");

    let mut iteration_count = 0;
    'repeat: loop {
        println!("Searching... iteration {}", iteration_count);

        'lines: for raw_freq in raw_frequencies.lines() {
            match &raw_freq[..1] {
                "+" => freq += &raw_freq[1..].parse::<i64>().unwrap(),
                "-" => freq -= &raw_freq[1..].parse::<i64>().unwrap(),
                _ => println!("Parsed unexpected value... ignoring"),
            };

            if found_freqs.contains(&freq) {
                println!("Found repeating frequency");
                break 'repeat;
            }

            &found_freqs.insert(freq);
        }

        iteration_count += 1;
    }
    println!("Resulting Frequency: {}", freq);
}
