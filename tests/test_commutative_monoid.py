from hypothesis import given, strategies as st
from acgt import ACGT

ints = st.integers(min_value=0, max_value=1 << 62)
acgt = st.builds(ACGT, ints, ints, ints, ints)


@given(acgt, acgt, acgt)
def test_associative(x, y, z):
    assert (x + y) + z == x + (y + z)


@given(acgt)
def test_identity(x):
    assert x + ACGT.empty() == x
    assert ACGT.empty() + x == x


@given(acgt, acgt)
def test_commutative(x, y):
    assert x + y == y + x
