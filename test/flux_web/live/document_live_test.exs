defmodule FluxWeb.DocumentLiveTest do
  use FluxWeb.ConnCase

  import Phoenix.LiveViewTest
  import Flux.ResearchFixtures

  @create_attrs %{name: "some name", content: "some content", tags: ["option1", "option2"]}
  @update_attrs %{name: "some updated name", content: "some updated content", tags: ["option1"]}
  @invalid_attrs %{name: nil, content: nil, tags: []}

  defp create_document(_) do
    document = document_fixture()
    %{document: document}
  end

  describe "Index" do
    setup [:create_document]

    test "lists all documents", %{conn: conn, document: document} do
      {:ok, _index_live, html} = live(conn, ~p"/documents")

      assert html =~ "Listing Documents"
      assert html =~ document.name
    end

    test "saves new document", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/documents")

      assert index_live |> element("a", "New Document") |> render_click() =~
               "New Document"

      assert_patch(index_live, ~p"/documents/new")

      assert index_live
             |> form("#document-form", document: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#document-form", document: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/documents")

      html = render(index_live)
      assert html =~ "Document created successfully"
      assert html =~ "some name"
    end

    test "updates document in listing", %{conn: conn, document: document} do
      {:ok, index_live, _html} = live(conn, ~p"/documents")

      assert index_live |> element("#documents-#{document.id} a", "Edit") |> render_click() =~
               "Edit Document"

      assert_patch(index_live, ~p"/documents/#{document}/edit")

      assert index_live
             |> form("#document-form", document: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#document-form", document: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/documents")

      html = render(index_live)
      assert html =~ "Document updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes document in listing", %{conn: conn, document: document} do
      {:ok, index_live, _html} = live(conn, ~p"/documents")

      assert index_live |> element("#documents-#{document.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#documents-#{document.id}")
    end
  end

  describe "Show" do
    setup [:create_document]

    test "displays document", %{conn: conn, document: document} do
      {:ok, _show_live, html} = live(conn, ~p"/documents/#{document}")

      assert html =~ "Show Document"
      assert html =~ document.name
    end

    test "updates document within modal", %{conn: conn, document: document} do
      {:ok, show_live, _html} = live(conn, ~p"/documents/#{document}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Document"

      assert_patch(show_live, ~p"/documents/#{document}/show/edit")

      assert show_live
             |> form("#document-form", document: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#document-form", document: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/documents/#{document}")

      html = render(show_live)
      assert html =~ "Document updated successfully"
      assert html =~ "some updated name"
    end
  end
end
