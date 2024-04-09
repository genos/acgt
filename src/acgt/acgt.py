from collections import Counter
from dataclasses import dataclass


@dataclass
class ACGT:
    A: int
    C: int
    G: int
    T: int

    @classmethod
    def from_str(cls, s: str):
        c = Counter(s)
        return cls(*(c.get(x, 0) for x in "ACGT"))

    def to_str(self) -> str:
        return "".join(x * c for x, c in zip("ACGT", self))

    def __iter__(self):
        return iter((self.A, self.C, self.G, self.T))

    def __add__(self, x):
        return ACGT(self.A + x.A, self.C + x.C, self.G + x.G, self.T + x.T)

    @staticmethod
    def empty():
        return ACGT(0, 0, 0, 0)
