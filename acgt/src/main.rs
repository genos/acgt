#![deny(clippy::all)]
#![warn(clippy::pedantic)]
#![warn(clippy::nursery)]
use rayon::prelude::*;
use std::{
    fmt,
    fs::File,
    io::{BufReader, Read},
    iter::Sum,
    path::Path,
};

#[derive(Default)]
struct Acgt {
    a: u64,
    c: u64,
    g: u64,
    t: u64,
}

impl fmt::Display for Acgt {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        f.write_fmt(format_args!("{} {} {} {}", self.a, self.c, self.g, self.t))
    }
}

impl Sum for Acgt {
    fn sum<I: Iterator<Item = Self>>(i: I) -> Self {
        let mut x = Self::default();
        for y in i {
            x.a += y.a;
            x.c += y.c;
            x.g += y.g;
            x.t += y.t;
        }
        x
    }
}

impl Acgt {
    fn load(p: impl AsRef<Path>) -> Self {
        let mut x = Self::default();
        let mut b = BufReader::new(File::open(p).unwrap());
        let mut bs = [0; 512];
        loop {
            match b.read(&mut bs) {
                Ok(n) if n > 0 => {
                    for c in bs.iter().take(n) {
                        match c {
                            b'A' => x.a += 1,
                            b'C' => x.c += 1,
                            b'G' => x.g += 1,
                            b'T' => x.t += 1,
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
    let x: Acgt = (0..20000)
        .into_par_iter()
        .map(|x| Acgt::load(format!("{}/../data/{x}.acgt", env!("CARGO_MANIFEST_DIR"))))
        .sum();
    println!("{x}");
}
