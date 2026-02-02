#![deny(clippy::all)]
#![deny(clippy::pedantic)]
#![deny(clippy::nursery)]
#![deny(unsafe_code)]
#![feature(portable_simd)]
use rayon::prelude::*;
use std::{
    fs,
    io::{BufReader, Read},
    iter, path,
    simd::{Simd, u64x4},
};

#[derive(Default, Debug)]
struct Acgt(u64x4);

impl iter::Sum for Acgt {
    fn sum<I: Iterator<Item = Self>>(i: I) -> Self {
        Self(i.map(|x| x.0).sum())
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
                            b'A' => x.0 += Simd::from_array([1, 0, 0, 0]),
                            b'C' => x.0 += Simd::from_array([0, 1, 0, 0]),
                            b'G' => x.0 += Simd::from_array([0, 0, 1, 0]),
                            b'T' => x.0 += Simd::from_array([0, 0, 0, 1]),
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
