defmodule Flux.Research.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :name, :string
    field :content, :string
    field :tags, {:array, :string}
    field :created_by, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :content, :tags])
    |> validate_required([:name, :content])

    # |> validate_length(:name, min: 2)
    # |> validate_length(:content, min: 16)
  end
end
