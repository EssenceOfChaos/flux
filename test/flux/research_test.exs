defmodule Flux.ResearchTest do
  use Flux.DataCase

  alias Flux.Research

  describe "documents" do
    alias Flux.Research.Document

    import Flux.ResearchFixtures

    @invalid_attrs %{name: nil, content: nil, tags: nil}

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Research.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Research.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      valid_attrs = %{name: "some name", content: "some content", tags: ["option1", "option2"]}

      assert {:ok, %Document{} = document} = Research.create_document(valid_attrs)
      assert document.name == "some name"
      assert document.content == "some content"
      assert document.tags == ["option1", "option2"]
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      update_attrs = %{name: "some updated name", content: "some updated content", tags: ["option1"]}

      assert {:ok, %Document{} = document} = Research.update_document(document, update_attrs)
      assert document.name == "some updated name"
      assert document.content == "some updated content"
      assert document.tags == ["option1"]
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_document(document, @invalid_attrs)
      assert document == Research.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Research.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Research.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Research.change_document(document)
    end
  end
end
