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
        intvalue(tkn)
    else
        throw(DomainError("Not a Milesian token: $(tkn)."))
    end
end

"""Compute numeric value of a token for a Milesian integer.
$(SIGNATURES)
"""
function intvalue(tkn::OrthographicToken)
    @assert tokencategory(tkn) isa MilesianIntegerToken
    intvalue(tokentext(tkn)) #|> sum
end

function myriadvalue(s::AbstractString)
    myriad = 10000
    parts = split(s, "^")
    if length(parts) == 1
        myriad
    else
        factor = intvalue(parts[2])
        myriad * factor
    end
end

function intdigits(s)
    pieces = []
    for c in s
        if istick(c)
            # ignore
        else
            if ! (c in keys(digitvalues))
                throw(DomainError("Invalid digit: $(c) $(codepoint(c))"))
            else
                push!(pieces, digitvalues[c])
            end
        end
    end
    if length(pieces) > 1
        max = length(pieces) - 1
        for i in 1:max
            if pieces[i] <= pieces[i + 1]
                throw(DomainError("Invalid sequence of numeric digits: $(s)"))
            end
        end
    end
    pieces |> sum
end

"""Compute numeric value of a single string for token a Milesian integer.
$(SIGNATURES)
"""
function intvalue(s::AbstractString)
    @info("Int of $(s)")
     if startswith(s, "Μ")
        myriadvalue(s)
     else
        pieces = split(s, ",")
        if length(pieces) == 1 
            #intdigits(pieces[1])
            @info("Get intdigits for $(pieces[1])")
            intdigits(pieces[1])
            
        else
            thousands = intdigits(pieces[1]) * 1000
            isempty(pieces[2]) ? thousands : thousands + intdigits(pieces[2])
            
        end

     end
end




"""Compute numeric value of a token for a Milesian integer.
$(SIGNATURES)
"""
function intpieces(tkn::OrthographicToken)
    @assert tokencategory(tkn) isa MilesianIntegerToken
    intpieces(tokentext(tkn))
end

function intpieces(s::AbstractString)
end

"""True if `c` is one of the "tick" characters that
Unicode equivalence can botch.
$(SIGNATURES)
"""
function istick(c::Char)
    c in [NUMERIC_TICK, FRACTION_TICK, PRIME, EVIL_PRIME, EVIL_DOUBLE_PRIME]
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