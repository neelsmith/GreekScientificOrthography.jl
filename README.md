# GreekScientificOrthography.jl


Implementation of an orthographic system for ancient Greek mathematical and scientific texts.


## Quick start


- Validate the orthography of a string:

```julia-repl
julia > using GreekScientificOrthography, Orthography
julia > ortho = stemortho()
julia > archimedes = "ἡ ΓΕ πρὸς ΓΗ μείζονα λόγον ἔχει ἤπερ φοαʹ πρὸς ρνγʹ."
julia > validstring(archimedes, ortho)
true
```


- Tokenize a string:

```julia-repl
julia > tkns = tokenize(archimedes, ortho)
12-element Vector{OrthographicToken}:
 OrthographicToken("ἡ", LexicalToken())
 OrthographicToken("ΓΕ", FigureLabelToken())
 OrthographicToken("πρὸς", LexicalToken())
 OrthographicToken("ΓΗ", FigureLabelToken())
 OrthographicToken("μείζονα", LexicalToken())
 OrthographicToken("λόγον", LexicalToken())
 OrthographicToken("ἔχει", LexicalToken())
 OrthographicToken("ἤπερ", LexicalToken())
 OrthographicToken("φοαʹ", MilesianIntegerToken())
 OrthographicToken("πρὸς", LexicalToken())
 OrthographicToken("ρνγʹ", MilesianIntegerToken())
 OrthographicToken(".", PunctuationToken())
```


## Documentation

See documentation on [quarto pub](https://neelsmith.quarto.pub/greekscientificorthography/)