// gcloud command line to retrieve all data from cloudns
// gcloud dns record-sets list --zone=cloudns --format=json > cloudns.json
// gcloud command line to retrieve all data from cloudns
// gcloud dns record-sets list --zone=cloudns --format=json > cloudns.json

use std::collections::HashMap;
use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;
use std::path::Path;

use serde_json;

#[derive(Deserialize)]
struct Record {
    #[serde(rename = "name")]
    name: String,
    #[serde(rename = "type")]
    record_type: String,
    #[serde(rename = "rrdatas")]
    rrdatas: Vec<String>,
    #[serde(rename = "ttl")]
    ttl: u32,
}

fn main() {
    let path = Path::new("cloudns.json");
    let file = File::open(&path).unwrap();
    let reader = BufReader::new(file);
    let records: Vec<Record> = serde_json::from_reader(reader).unwrap();

    let mut map: HashMap<String, Vec<Record>> = HashMap::new();
    for record in records {
        let entry = map.entry(record.name.clone()).or_insert(Vec::new());
        entry.push(record);
    }

    for (name, records) in map {
        println!("{}:", name);
        for record in records {
            println!(
                "  {} {} {}",
                record.record_type,
                record.ttl,
                record.rrdatas.join(" ")
            );
        }
        println!("");
    }
}

The only thing I needed to do was to add the following line to the Cargo.toml file:

serde_json = "1.0"

And then I could use the serde_json::from_reader function to parse the JSON file into a vector of my Record struct.

The output of the above program looks like this:

$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.0 secs
     Running `target/debug/cloudns`
@:
  NS 21600 ns-cloud-c1.googledomains.com.
  NS 21600 ns-cloud-c2.googledomains.com.
  NS 21600 ns-cloud-c3.googledomains.com.
  NS 21600 ns-cloud-c4.googledomains.com.
  SOA 21600 ns-cloud-c1.go