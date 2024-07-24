module GreekScientificOrthography

using Unicode 

using Orthography
import Orthography: OrthographyTrait
import Orthography: tokentypes 
import Orthography: codepoints 
import Orthography: tokenize

using PolytonicGreek
import PolytonicGreek: syllabify
import PolytonicGreek: accentword
import PolytonicGreek: accentultima
import PolytonicGreek: accentpenult
import PolytonicGreek: accentantepenult
import PolytonicGreek: sortWords
import PolytonicGreek: vowels
import PolytonicGreek: consonants
import PolytonicGreek: rmaccents
import PolytonicGreek: countaccents
import PolytonicGreek: augment
import PolytonicGreek: augment_initial
import PolytonicGreek: augment_medial

using Documenter, DocStringExtensions

export GreekMathOrthography, stemortho

export FigureLabelToken
export GreekNumericToken, MilesianIntegerToken, MilesianFractionToken

export codepoints, tokentypes, tokenize

export augment, augment_initial, augment_medial

export stemortho

include("types.jl")
include("ortho.jl")
include("lexical.jl")

end # module GreekMathOrthography
