from algorithm import parallelize
from pathlib import Path


fn main():
    var x = SIMD[DType.uint64, 4](0, 0, 0, 0)

    @parameter
    fn f(i: Int) capturing -> None:
        try:
            var s = Path("../data/" + str(i) + ".acgt").read_text()
            x[0] += s.count("A")
            x[1] += s.count("C")
            x[2] += s.count("G")
            x[3] += s.count("T")
        finally:
            pass

    parallelize[f](20_000)
    print(x)
