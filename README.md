# MarkdownTables.jl

![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![build](https://github.com/tpapp/MarkdownTables.jl/workflows/CI/badge.svg)](https://github.com/tpapp/MarkdownTables.jl/actions?query=workflow%3ACI)
[![codecov.io](http://codecov.io/github/tpapp/MarkdownTables.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/MarkdownTables.jl?branch=master)

Lightweight package to print a table that implements the [Tables.jl interface](https://tables.juliadata.org) in Markdown.

Primarily developed for use in [Literate.jl](https://fredrikekre.github.io/Literate.jl), as

```julia
using MarkdownTables #hide
some_table |> markdown_table
```

# Alternatives

[PrettyTables.jl](https://ronisbr.github.io/PrettyTables.jl/) is much more general, but is also a heavier dependency.
