"""
Lightweight package to print a table that implements the [Tables.jl
interface](https://tables.juliadata.org) in Markdown.

The single exported function is [`markdown_table`](@ref). Primarily developed for use in
[Literate.jl](https://fredrikekre.github.io/Literate.jl).
"""
module MarkdownTables

export markdown_table

using ArgCheck: @argcheck
using DocStringExtensions: SIGNATURES
import Tables
import DisplayAs

"""
$(SIGNATURES)

A small utility function that converts its input to a string for markdown representation.

Part of the API, but not exported.
"""
value_to_markdown(x::Number) = string(x)

value_to_markdown(x::AbstractString) = x

value_to_markdown(x) = "`$x`"

const _OUTPUTS = Union{MIME,Type{String}}

"""
$(SIGNATURES)

Format `table` (that support the ([Tables.jl interface](https://tables.juliadata.org)) using
a simple Markdown syntax, that looks like this by default:

```markdown
| *a* | *b* |
|-----|-----|
|   1 |   2 |
```

`output` can be

1. `String`, which results in a `String`,

2. a `::MIME` type, that wraps the output bytes using `DisplayAs.Raw.Showable`.

A partially applied version `markdown_table([output]; kwargs...)` is also available, for use
with `|>`, eg

```julia
some_table |> markdown_table([output]; kwargs...)
```

# Keyword arguments (with defaults)

- `header`: whether to print the column names

- `header_post = header_pre = \"*\"`: appended to column names, should make valid
  Markdown syntax

- `right_padding = left_padding = 1`: left and right padding for cells, use `0` for compact
  tables

- `formatter = MarkdownTables.value_to_markdown`: the actual function that converts to
  strings that should be valid Markdown.
"""
function markdown_table(table, output::_OUTPUTS = MIME("text/markdown");
                        header::Bool = true,
                        header_pre::AbstractString = "*",
                        header_post::AbstractString = header_pre,
                        left_padding::Integer = 1,
                        right_padding::Integer = left_padding,
                        formatter = value_to_markdown)
    @argcheck Tables.istable(table)
    @argcheck left_padding ≥ 0
    @argcheck right_padding ≥ 0
    columns = Tables.columns(table)
    m = mapreduce(hcat, Tables.columnnames(columns)) do col
        column_name = header_pre * string(col) * header_post
        cells = Tables.getcolumn(columns, col)
        md_cells = map(formatter, cells)
        width = max(length(column_name), maximum(length, md_cells)) + left_padding + right_padding
        padded_cells = map(c -> lpad(c * ' '^right_padding, width), md_cells)
        if header
            vcat([rpad(' '^left_padding * column_name, width), "-"^width], padded_cells)
        else
            padded_cells
        end
    end
    io = IOBuffer()
    for row in axes(m, 1)
        print(io, '|')
        for col in axes(m, 2)
            print(io, m[row, col], '|')
        end
        println(io)
    end
    if output isa MIME
        DisplayAs.Raw.Showable{typeof(output)}(take!(io))
    elseif output ≡ String
        String(take!(io))
    else
        error("Don't know how to handle `output = $(output)`.")
    end
end

function markdown_table(output::_OUTPUTS = MIME("text/markdown"); kwargs...)
    table -> markdown_table(table, output; kwargs...)
end

end # module
