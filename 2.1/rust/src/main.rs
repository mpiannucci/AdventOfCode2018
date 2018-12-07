use std::fs::File;
use std::string::String;
use std::io::prelude::*;
use std::collections::HashMap;
use std::char;

fn main() {

    let mut box_ids = String::new();
    File::open("./../input.txt")
        .expect("Unable to read from input.txt")
        .read_to_string(&mut box_ids)
        .expect("Unable to feed contents to string");

    let mut two_letter_count = 0;
    let mut three_letter_count = 0;
    for box_id in box_ids.lines() {
        let mut character_count: HashMap<char, u8> = HashMap::new();
        for character in box_id.trim().chars() {
            let character_counter = character_count.entry(character).or_insert(0);
            *character_counter += 1;
        }

        let mut two_letter_found = false;
        let mut three_letter_found = false;
        for count in character_count.values() {
            if *count == 2 && !two_letter_found {
                two_letter_count += 1;
                two_letter_found = true;
            } else if *count == 3 && !three_letter_found {
                three_letter_count += 1;
                three_letter_found = true;
            }

            if two_letter_found && three_letter_found {
                break;
            }
        }
    }

    println!("Checksum: {}", two_letter_count * three_letter_count);
}
