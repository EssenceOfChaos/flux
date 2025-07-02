# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Flux.Repo.insert!(%Flux.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Flux.Research.Document
alias Flux.Repo

for n <- Range.new(16, 85, 1) do
  attrs = %{"content" => "Creating the #{n}th entry", "name" => "Doc #{n}", "tags" => ["option1"]}

  %Document{}
  |> Document.changeset(attrs)
  |> Repo.insert()
end
