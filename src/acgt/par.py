from collections.abc import Iterable
from pathlib import Path
import ray
from .acgt import ACGT


@ray.remote
def load(p: Path) -> ACGT:
    return ACGT.from_str(p.read_text())


def total(ps: Iterable[Path]) -> dict[str, int]:
    return dict(zip("ACGT", sum(ray.get([load.remote(p) for p in ps]), ACGT.empty())))
