defmodule Flux.Research do
  @moduledoc """
  The Research context.
  """

  import Ecto.Query, warn: false
  alias Flux.Repo
  require Logger
  alias Flux.Research.Document

  @doc """
  Returns the list of documents.

  ## Examples

      iex> list_documents()
      [%Document{}, ...]

  """
  def list_documents do
    Repo.all(Document)
  end

  def list_documents_with_total() do
    query = from(d in Document)
    total_count = Repo.aggregate(query, :count)

    result =
      query
      |> Repo.all()

    Logger.debug(result)
    %{documents: result, total_count: total_count}
  end

  def list_documents_with_pagination(offset, limit) do
    Logger.info("Checking offset #{offset}")
    Logger.info("Checking limit #{limit}")

    query =
      from d in Document,
        order_by: d.id,
        limit: ^limit,
        offset: ^offset

    Repo.all(query)
  end

  @doc """
  Gets a single document.

  Raises `Ecto.NoResultsError` if the Document does not exist.

  ## Examples

      iex> get_document!(123)
      %Document{}

      iex> get_document!(456)
      ** (Ecto.NoResultsError)

  """
  def get_document!(id), do: Repo.get!(Document, id)

  @doc """
  Creates a document.

  ## Examples

      iex> create_document(%{field: value})
      {:ok, %Document{}}

      iex> create_document(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_document(attrs \\ %{}) do
    %Document{}
    |> Document.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a document.

  ## Examples

      iex> update_document(document, %{field: new_value})
      {:ok, %Document{}}

      iex> update_document(document, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_document(%Document{} = document, attrs) do
    document
    |> Document.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a document.

  ## Examples

      iex> delete_document(document)
      {:ok, %Document{}}

      iex> delete_document(document)
      {:error, %Ecto.Changeset{}}

  """
  def delete_document(%Document{} = document) do
    Repo.delete(document)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking document changes.

  ## Examples

      iex> change_document(document)
      %Ecto.Changeset{data: %Document{}}

  """
  def change_document(%Document{} = document, attrs \\ %{}) do
    Document.changeset(document, attrs)
  end

  # defp paginate(query, %{page: page, page_size: page_size})
  #      when is_integer(page) and is_integer(page_size) do
  #   offset = max(page - 1, 0) * page_size

  #   query
  #   |> limit(^page_size)
  #   |> offset(^offset)
  # end

  # defp sort(query, %{sort_dir: sort_dir, sort_by: sort_by})
  #      when sort_dir in [:asc, :desc] and
  #             sort_by in [:id, :name] do
  #   order_by(query, {^sort_dir, ^sort_by})
  # end

  # defp sort(query, _opts), do: query

  # defp paginate(query, _opts), do: query

  # defp filter(query, opts) do
  #   query
  #   |> filter_by_id(opts)
  #   |> filter_by_name(opts)
  # end

  # defp filter_by_id(query, %{id: id}) when is_integer(id) do
  #   where(query, id: ^id)
  # end

  # defp filter_by_id(query, _opts), do: query

  # defp filter_by_name(query, %{name: name})
  #      when is_binary(name) and name != "" do
  #   query_string = "%#{name}%"
  #   where(query, [m], ilike(m.name, ^query_string))
  # end

  # defp filter_by_name(query, _opts), do: query
end
