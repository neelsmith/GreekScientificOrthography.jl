"An orthographic system for texts in the pre-Euclidean Attic alphabet."
struct GreekSciOrthography <: PolytonicGreek.GreekOrthography
    codepoints::AbstractString
    tokencategories::Vector{DataType}
end


"""Assign value for OrthographyTrait"""
OrthographyTrait(::Type{GreekSciOrthography}) = IsOrthographicSystem()



"""Implement Orthography's codepoints function.

    $(SIGNATURES)    
    """
function codepoints(ortho::GreekSciOrthography)
    ortho.codepoints
end

"""Implement Orthography's tokentypes function for AtticOrthography.

$(SIGNATURES)    
"""
function tokentypes(ortho::GreekSciOrthography)
    ortho.tokencategories 
end


"""
Instantiate a GreekSciOrthography with correct code points and token types.

$(SIGNATURES)
"""
function stemortho()
    cps = alphabetic() * " \t\n" * punctuation() * numeric() * astro() |> unique |> join
    ttypes = [
        Orthography.LexicalToken,
        Orthography.PunctuationToken,
        Orthography.UnanalyzedToken,
        FigureLabelToken,
        MilesianIntegerToken,
        AstronomicalSymbol
    ]
    GreekSciOrthography(cps, ttypes)
end

"""
Tokenize a string in orthography of HMT Greek MSS.

$(SIGNATURES)  
"""
function tokenize(s::AbstractString, o::GreekSciOrthography)
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

function numeric()
     "′ϛϙϡΜ𐅵𐅷𐅸"
end



function astro()
    planets = "🜚︎☽︎☿♀♂♃♄"
    zodiac = "♈︎♉︎♊︎♋︎♌︎♍︎♎︎♏︎♐︎♑︎♒︎♓︎"

    planets * zodiac

end

"""Compose a string with all alphabetic characters.

$(SIGNATURES)

"""
function alphabetic()
    PolytonicGreek.alphabetic()
end

function alphabet()
    "αβγδεζηθικλμνξοπρστυφχψω"
end

"""Compose a string with all punctuation characters.

$(SIGNATURES)

Adds character for unit-ending mark.
"""
function punctuation()
    PolytonicGreek.punctuation()
end

"""
Create correct OrthographicToken for a given string in GreekSciOrthography.

$(SIGNATURES)    
"""
function tokenforstring(s::AbstractString)
    normed = Unicode.normalize(s, :NFKC)
    @info("tokenize $(normed)")
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
function sortWords(words, ortho::GreekSciOrthography)
    sortWords(words, literaryGreek())
    #=
    strippedpairs = map(wd -> ( lowercase(Unicode.normalize(wd, stripmark=true)), wd),words)
	sorted = sort(strippedpairs)
	map(pr -> pr[2], sorted)
    =#
end
