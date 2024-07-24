
"""True if string `s` parses as a label."""
function islabel(s)
    allcaps = true
    for c in s
        if islowercase(c) || Base.Unicode.category_string(c) == "Punctuation, other" || s[end] == 'ʹ'
            allcaps = false
        end
    end
    allcaps
end

"""True if final character of `s` is numeric marker."""
function isnum(s)
    s[end] == 'ʹ'
end