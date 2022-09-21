using DisplayAs, MarkdownTables, Tables, Test

table = [(a = 1, b = :b), (a = 2, b = :d)]

table_string = markdown_table(table, String)
@test table_string == "| *a* | *b* |\n|-----|-----|\n|   1 | `b` |\n|   2 | `d` |\n"
@test table |> markdown_table(String) == table_string
@test markdown_table(table) isa DisplayAs.Raw.Showable{MIME"text/markdown"}
