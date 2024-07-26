
"""True if string `s` parses as a figure label.
$(SIGNATURES)
"""
function islabel(s)
    validlabel = true
    for c in s
        if islowercase(c) 
            validlabel = false
        end
        
        if ! (lowercase(c) in alphabet())
            validlabel = false
        end
    end
    validlabel
end

"""True if string is in fraction format in Milesian notation.

$(SIGNATURES)
"""
function isfraction(s)
    s[end] == FRACTION_TICK # unicode x2033
end

"""True if string is in integer format in Milesian notation.

$(SIGNATURES)
"""
function isinteger(s)
    if s == "Μ"  # upper case Mu, unicode x039c
        true

    elseif s[1] == 'Μ' && s[end] == '^'
        true

    elseif s[end] == NUMERIC_TICK  # unicode x0374
        true

    else
        false
    end
end


"""True if s is a single astronomical symbol.
$(SIGNATURES)
"""
function isastro(s)
    contains(astro(), s)
end