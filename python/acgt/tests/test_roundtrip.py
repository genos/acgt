from hypothesis import given, strategies as st
from acgt import ACGT


chrs = st.text(["A", "C", "G", "T"], max_size=1 << 20)
ints = st.integers(min_value=0, max_value=1 << 16)
acgt = st.builds(ACGT, ints, ints, ints, ints)


@given(acgt)
def test_roundtrip(x: ACGT):
    assert ACGT.from_str(x.to_str()) == x


@given(chrs)
def test_roundtrip_2(x: str):
    assert "".join(sorted(x)) == ACGT.from_str(x).to_str()
