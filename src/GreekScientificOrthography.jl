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

const PRIME = '′' # unicode x2032
export PRIME 

const FRACTION_TICK = '″' # unicode x2033, "double prime"
export FRACTION_TICK

const ONE_HALF = '𐅵' # unicode x10175
export ONE_HALF

const TWO_THIRDS = '𐅷' # unicode x10177
export TWO_THIRDS

const THREE_FOURTHS = '𐅸' # unicode x10178
export THREE_FOURTHS

const EVIL_PRIME = Char(0x2b9) # "modifier letter prime"
const EVIL_DOUBLE_PRIME = Char(0x2ba) #  "modifier letter double prime"


export milesian

include("types.jl")
include("tokens.jl")
include("ortho.jl")
include("lexical.jl")
include("digits.jl")
include("milesian.jl")

end # module GreekSciOrthography
