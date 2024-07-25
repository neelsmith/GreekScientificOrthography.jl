struct FigureLabelToken <: TokenCategory end

struct AstronomicalSymbol <: TokenCategory end



abstract type GreekNumericToken <: TokenCategory end

struct MilesianIntegerToken <: GreekNumericToken end

struct MilesianFractionToken <: GreekNumericToken end





