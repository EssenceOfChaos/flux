defmodule FluxWeb.DocumentLive.Index do
  use FluxWeb, :live_view
  require Logger
  alias Flux.Research
  alias Flux.Research.Document

  @impl true
  # def mount(_params, _session, socket) do
  #   {:ok, stream(socket, :documents, Research.list_documents(), limit: 5)}
  # end

  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> paginate_posts(1)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Document")
    |> assign(:document, Research.get_document!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Document")
    |> assign(:document, %Document{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Documents")
    |> assign(:document, nil)
  end

  @impl true
  def handle_info({FluxWeb.DocumentLive.FormComponent, {:saved, document}}, socket) do
    {:noreply, stream_insert(socket, :documents, document)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    document = Research.get_document!(id)
    {:ok, _} = Research.delete_document(document)

    {:noreply, stream_delete(socket, :documents, document)}
  end

  def handle_event("on", _, socket) do
    Logger.info("Handling on Event")
    socket = assign(socket, :limit, 10)
    {:noreply, socket}
  end

  defp paginate_posts(socket, new_page) when new_page >= 1 do
    Logger.info("Current page: #{socket.assigns.page}")
    Logger.info("New page: #{new_page}")
    %{per_page: per_page, page: cur_page} = socket.assigns

    docs =
      Research.list_documents_with_pagination((new_page - 1) * per_page, per_page)

    {docs, at, limit} =
      if new_page >= cur_page do
        {docs, -1, per_page * 3 * -1}
      else
        {Enum.reverse(docs), 0, per_page * 3}
      end

    case docs do
      [] ->
        assign(socket, end_of_timeline?: at == -1)

      [_ | _] = docs ->
        socket
        |> assign(end_of_timeline?: false)
        |> assign(:page, new_page)
        |> stream(:documents, docs, at: at, limit: limit)
    end
  end

  def handle_event("next-page", _, socket) do
    {:noreply, paginate_posts(socket, socket.assigns.page + 1)}
  end

  def handle_event("prev-page", %{"_overran" => true}, socket) do
    {:noreply, paginate_posts(socket, 1)}
  end

  def handle_event("prev-page", _, socket) do
    if socket.assigns.page > 1 do
      {:noreply, paginate_posts(socket, socket.assigns.page - 1)}
    else
      {:noreply, socket}
    end
  end
end
