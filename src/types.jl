struct FigureLabelToken <: TokenCategory end


abstract type GreekNumericToken <: TokenCategory end

struct MilesianIntegerToken <: GreekNumericToken end

struct MilesianFractionToken <: GreekNumericToken end



