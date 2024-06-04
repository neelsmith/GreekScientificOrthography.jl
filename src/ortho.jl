"An orthographic system for texts in the pre-Euclidean Attic alphabet."
struct GreekMathOrthography <: PolytonicGreek.GreekOrthography
    codepoints
    tokencategories
end

"""Assign value for OrthographyTrait"""
OrthographyTrait(::Type{GreekMathOrthography}) = IsOrthographicSystem()



"""Implement Orthography's codepoints function.

    $(SIGNATURES)    
    """
function codepoints(ortho::GreekMathOrthography)
    ortho.codepoints
end

"""Implement Orthography's tokentypes function for AtticOrthography.

$(SIGNATURES)    
"""
function tokentypes(ortho::GreekMathOrthography)
    ortho.tokencategories
end


"""
Instantiate a GreekMathOrthography with correct code points and token types.

$(SIGNATURES)
"""
function stemortho()
    cps = alphabetic() * " \t\n" * punctuation()
    ttypes = [
        Orthography.LexicalToken,
        Orthography.PunctuationToken,
        Orthography.UnanalyzedToken
    ]
    GreekMathOrthography(cps, ttypes)
end

"""
Tokenize a string in orthography of HMT Greek MSS.

$(SIGNATURES)  
"""
function tokenize(s::AbstractString, o::GreekMathOrthography)
    wsdelimited = split(s)
    depunctuated = map(s -> splitPunctuation(s), wsdelimited)
    tknstrings = collect(Iterators.flatten(depunctuated))
    tkns = map(t -> tokenforstring(t), tknstrings)
end


"""
Split off any trailing punctuation and return an Array of leading string + trailing punctuation.

$(SIGNATURES)  
"""
function splitPunctuation(s::AbstractString)
    punct = Orthography.collecttail(s, punctuation())
    trimmed = Orthography.trimtail(s, punctuation())
    filter(s -> ! isempty(s), [trimmed, punct])
end


"""Compose a string with all alphabetic characters.

$(SIGNATURES)

Adds character for second grave accent, and for "extra" diaeresis.
"""
function alphabetic()
    string(PolytonicGreek.alphabetic(), "⸌", "+")
end

"""Compose a string with all punctuation characters.

$(SIGNATURES)

Adds character for unit-ending mark.
"""
function punctuation()
    string(PolytonicGreek.punctuation(), "⁑‡¶")
end

"""
Create correct OrthographicToken for a given string in GreekMathOrthography.

$(SIGNATURES)    
"""
function tokenforstring(s::AbstractString)
    normed = Unicode.normalize(s, :NFKC)
    if isAlphabetic(normed)
        OrthographicToken(normed, LexicalToken())
    elseif isPunctuation(normed)
        OrthographicToken(normed, PunctuationToken())
    else
        OrthographicToken(normed, Orthography.UnanalyzedToken())
    end
end







"""
True if all characters in s are alphabetic.

$(SIGNATURES)    
"""
function isAlphabetic(s::AbstractString)
    chlist = split(s,"")
    alphas = alphabetic()
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], alphas))
    end
    tfs = map(c -> occursin(c, alphas), chlist)
    nogood = false in tfs
   
    !nogood
end

"""
True if all characters in s are puncutation.
   
$(SIGNATURES)      
"""
function isPunctuation(s::AbstractString)
    chlist = split(s,"")
    puncts = punctuation()
    tfs = map(c -> occursin(c, puncts), chlist)
    nogood = false in tfs
   
    !nogood
end

"""
Alphabetically sort a list of words in Unicode Greek.

$(SIGNATURES)
"""
function sortWords(words, ortho::GreekMathOrthography)
    sortWords(words, literaryGreek())
    #=
    strippedpairs = map(wd -> ( lowercase(Unicode.normalize(wd, stripmark=true)), wd),words)
	sorted = sort(strippedpairs)
	map(pr -> pr[2], sorted)
    =#
end
