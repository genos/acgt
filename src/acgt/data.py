"""Create fake ACGT data."""

from random import choices, randrange, seed as seed

from pyprojroot import here
from rich.progress import track
import typer


cli = typer.Typer()


@cli.command()
def main():
    """Create fake ACGT data."""
    seed(73905591)  # random.org
    for i in track(range(20_000)):
        here(f"data/{i}.acgt").write_text(
            "\n".join(
                "".join(choices("ACGT", k=randrange(10, 100)))
                for _ in range(randrange(100, 1_000))
            )
        )
