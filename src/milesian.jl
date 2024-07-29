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
        @debug("Its an int: $(tkn)")
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



"""Compute numeric value of a token expressing numbers of myriads.
$(SIGNATURES)
"""
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


"""Compute numeric value of a string expressing an integer value below 1,000.
$(SIGNATURES)
"""
function intdigits(s::AbstractString)
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
    @debug("Int of $(s)")
     if startswith(s, "Μ")
        myriadvalue(s)
     else
        pieces = split(s, ",")
        if length(pieces) == 1 
            @debug("Get intdigits for $(pieces[1])")
            intdigits(pieces[1])
            
        else
            @debug("Here are the pieces: $(pieces)")
            thousands = intdigits(pieces[1]) * 1000
            lowervals = filter(s -> ! istick(s), pieces[2])
            isempty(lowervals) ? thousands : thousands + intdigits(lowervals)
            
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


"""True if `c` is one of the "tick" characters that
Unicode equivalence can botch.
$(SIGNATURES)
"""
function istick(c::Char)
    c in [NUMERIC_TICK, FRACTION_TICK, PRIME, EVIL_PRIME, EVIL_DOUBLE_PRIME]
end


"""Compute numeric value of an orthographic token expressing a fractional value in Milesian notation.
$(SIGNATURES)
"""
function fractionvalue(tkn::OrthographicToken)
    fractionpieces(tkn) |> sum
end

"""Compute numeric value of an orthographic token expressing a fractional value in Milesian notation.
$(SIGNATURES)
"""
function fractionpieces(tkn::OrthographicToken)
    @assert tokencategory(tkn) isa MilesianFractionToken
    fractionpieces(tokentext(tkn))
end

"""Compute numeric value of a string for a single token expressing a fractional value in Milesian notation.
$(SIGNATURES)
"""
function fractionpieces(s::AbstractString)
    if !(istick(s[end]))
        throw(DomainError("String not marked with fraction tick: $(s)"))
    end
    
    if s[1] == ONE_HALF
        1 /2
    
    elseif s[1] == TWO_THIRDS
        2 / 3

    elseif s[1]  == THREE_FOURTHS
        3 / 4
        
    else
        @debug("Get int value of $(s)")
        1 / intvalue(s)        
   
    end
end
