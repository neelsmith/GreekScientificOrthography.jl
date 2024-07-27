"""Compute numeric value of string in Milesian notation.
$(SIGNATURES)
"""
function milesian(s::AbstractString)
    tkns = tokenize(s, stemortho())
    milesian.(tkns) |> sum
end

"""Compute numeric value of an orthographic tkoen in Milesian notation.
$(SIGNATURES)
"""
function milesian(tkn::OrthographicToken)
    if tokencategory(tkn) isa MilesianFractionToken
        fractionvalue(tkn)

    elseif tokencategory(tkn) isa MilesianIntegerToken

    else
        throw(DomainError("Not a Milesian token: $(tkn)."))
    end
end


function intvalue(tkn::OrthographicToken)
end





function istick(c::Char)
    c in [NUMERIC_TICK, FRACTION_TICK, PRIME]
end

function fractionvalue(tkn::OrthographicToken)
    fractionpieces(tkn) |> sum
end

"""Compute numeric value of a orthographic token in Milesian notation.
$(SIGNATURES)
"""
function fractionpieces(tkn::OrthographicToken)
    @assert tokencategory(tkn) isa MilesianFractionToken
    fractionpieces(tokentext(tkn))
end

function fractionpieces(s::AbstractString)
    @assert(istick(s[end]))

    pieces = []
    for gr in graphemes(s)
        @debug("Eval grapheme $(gr)")
        if gr == "$(ONE_HALF)"
            grval = 1 /2
            push!(pieces, grval)
        elseif gr == "$(TWO_THIRDS)"
            grval = 2 / 3
            push!(pieces, grval)
        elseif gr == "$(THREE_FOURTHS)"
            grval =  3 / 4
            push!(pieces, grval)

        elseif istick(gr[1])
        else
            @debug("Eval char $(gr[1])")
            @assert gr[1] in keys(digitvalues)
            grval = 1 / digitvalues[gr[1]]
            push!(pieces, grval)
        end
    end
    pieces
end

#=
if s == "Μʹ"
    10000
elseif if s ==  "Οʹ"
    0
else
=#