module GreekScientificOrthography
using Documenter, DocStringExtensions

using Unicode 

using Orthography
import Orthography: OrthographyTrait
import Orthography: tokentypes 
import Orthography: codepoints 
import Orthography: tokenize

using PolytonicGreek

export GreekSciOrthography, stemortho

export FigureLabelToken
export AstronomicalSymbol
export GreekNumericToken, MilesianIntegerToken, MilesianFractionToken

export codepoints, tokentypes, tokenize

const NUMERIC_TICK = 'ʹ' # unicode x0374
export NUMERIC_TICK



include("types.jl")
include("tokens.jl")
include("ortho.jl")
include("lexical.jl")

end # module GreekSciOrthography
