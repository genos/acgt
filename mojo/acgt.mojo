from std.algorithm import sync_parallelize
from std.pathlib import Path


def main():
    var x = SIMD[DType.uint64, 4](0, 0, 0, 0)

    @parameter
    def f(i: Int) raises capturing -> None:
        try:
            var s = Path("../data/" + String(i) + ".acgt").read_text()
            x[0] += UInt64(s.count("A"))
            x[1] += UInt64(s.count("C"))
            x[2] += UInt64(s.count("G"))
            x[3] += UInt64(s.count("T"))
        finally:
            pass

    sync_parallelize[f](20_000)
    print(x)
