import Distributed.@distributed

_cs = [codepoint(x) for x in "ACGT"]

function load(i::Int64)
    x = zeros(Int64, 4)
    s =  read(joinpath(@__DIR__, "..", "data", string(i) * ".acgt"))
    for (i, c) in enumerate(_cs)
        x[i] += count(==(c), s)
    end
    x
end

@time x = @distributed ((a, b)->a+b) for i in 0:19_999
    load(i)
end
print(x)
