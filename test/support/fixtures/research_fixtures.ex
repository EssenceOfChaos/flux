defmodule Flux.ResearchFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Flux.Research` context.
  """

  @doc """
  Generate a document.
  """
  def document_fixture(attrs \\ %{}) do
    {:ok, document} =
      attrs
      |> Enum.into(%{
        content: "some content",
        name: "some name",
        tags: ["option1", "option2"]
      })
      |> Flux.Research.create_document()

    document
  end
end
