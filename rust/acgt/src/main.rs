#![deny(clippy::all)]
#![deny(clippy::pedantic)]
#![deny(clippy::nursery)]
#![deny(unsafe_code)]
use rayon::prelude::*;
use std::{
    fs,
    io::{BufReader, Read},
    iter, path,
};

#[derive(Default, Debug)]
struct Acgt(u64, u64, u64, u64);

impl iter::Sum for Acgt {
    fn sum<I: Iterator<Item = Self>>(i: I) -> Self {
        let mut x = Self::default();
        for y in i {
            x.0 += y.0;
            x.1 += y.1;
            x.2 += y.2;
            x.3 += y.3;
        }
        x
    }
}

impl Acgt {
    fn load(p: impl AsRef<path::Path>) -> Self {
        let mut x = Self::default();
        let mut b = BufReader::new(fs::File::open(p).unwrap());
        let mut bs = [0; 512];
        loop {
            match b.read(&mut bs) {
                Ok(n) if n > 0 => {
                    for c in bs.iter().take(n) {
                        match c {
                            b'A' => x.0 += 1,
                            b'C' => x.1 += 1,
                            b'G' => x.2 += 1,
                            b'T' => x.3 += 1,
                            _ => {}
                        }
                    }
                }
                _ => break,
            }
        }
        x
    }
}

fn main() {
    let x: Acgt = (0..20_000)
        .into_par_iter()
        .map(|x| {
            Acgt::load(format!(
                "{}/../../data/{x}.acgt",
                env!("CARGO_MANIFEST_DIR")
            ))
        })
        .sum();
    println!("{x:?}");
}
