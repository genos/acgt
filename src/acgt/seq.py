from collections.abc import Iterable
from pathlib import Path
from .acgt import ACGT


def load(p: Path) -> ACGT:
    return ACGT.from_str(p.read_text())


def total(ps: Iterable[Path]) -> dict[str, int]:
    return dict(zip("ACGT", sum((load(p) for p in ps), ACGT.empty())))
