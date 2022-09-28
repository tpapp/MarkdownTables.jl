using DisplayAs, MarkdownTables, Tables, Test

table = [(a = 1, b = :b), (a = 2, b = :d)]

# get rid of whitespace for comparison
_normalize(str::AbstractString) = filter(x -> x ≠ ' ', str)

table_string = _normalize(markdown_table(table, String))
@test table_string == _normalize("| a | b |\n|---|-----|\n| 1 | `b` |\n| 2 | `d` |\n")
@test table |> markdown_table(String) |> _normalize == table_string
@test markdown_table(table) isa DisplayAs.Raw.Showable{MIME"text/markdown"}
