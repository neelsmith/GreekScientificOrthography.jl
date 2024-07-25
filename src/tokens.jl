
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

"""True if final character of `s` is numeric marker.
$(SIGNATURES)
"""
function isnum(s)
    s[end] == NUMERIC_TICK  # unicode x0374
end


"""True if s is a single astronomical symbol.
$(SIGNATURES)
"""
function isastro(s)
    contains(astro(), s)
end