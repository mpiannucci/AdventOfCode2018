use std::fs::File;
use std::string::String;
use std::io::prelude::*;
use std::char;

fn main() {
    let mut box_ids = String::new();
    File::open("./../input.txt")
        .expect("Unable to read from input.txt")
        .read_to_string(&mut box_ids)
        .expect("Unable to feed contents to string");

    let mut common_id: String = String::from("");
    'outer: for box_id in box_ids.lines() {
        for other_box_id in box_ids.lines() {
            let mut diff_count = 0;
            common_id.clear();
            
            for (first, second) in box_id.trim().chars().zip(other_box_id.trim().chars()) {
                if first == second {
                    common_id.push(first);
                } else {
                    diff_count += 1;
                }
            }

            if diff_count == 1 {
                break 'outer;
            }
        }
    }

    println!("Common Box ID: {}", common_id);
}
