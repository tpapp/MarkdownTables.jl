# MarkdownTables.jl

![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![build](https://github.com/tpapp/MarkdownTables.jl/workflows/CI/badge.svg)](https://github.com/tpapp/MarkdownTables.jl/actions?query=workflow%3ACI)
[![codecov](https://codecov.io/github/tpapp/MarkdownTables.jl/branch/master/graph/badge.svg?token=P4us6KCrKg)](https://codecov.io/github/tpapp/MarkdownTables.jl)

Lightweight package to print a table that implements the [Tables.jl interface](https://tables.juliadata.org) in Markdown.

Primarily developed for use in [Literate.jl](https://fredrikekre.github.io/Literate.jl), as

```julia
using MarkdownTables #hide
some_table |> markdown_table()
```

You can directly save the generated ready-to-paste table to your clipboard via:
```julia
some_table |> markdown_table(String) |> clipboard
```

# Alternatives

[PrettyTables.jl](https://ronisbr.github.io/PrettyTables.jl/) is much more general, but is also a heavier dependency.
