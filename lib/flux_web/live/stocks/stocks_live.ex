defmodule FluxWeb.Stocks.StocksLive do
  use FluxWeb, :live_view
  alias Flux.Exchange
  require Logger
  # TODO: make sure open_stocks_csv() is called a single time then cached
  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       query: "",
       results: %{},
       mock_stocks: Exchange.mock_stocks(),
       stocks_csv: Exchange.open_stocks_csv()
     )}
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case validate_stock(query) do
      [{:ok, stock_name}] ->
        {:noreply,
         socket
         |> put_flash(:info, "Searching the company \"#{stock_name}\"!")
         |> assign(
           results: search(query),
           query: query
         )}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No stocks found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    Logger.debug(query)

    if not FluxWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for stock <- Exchange.mock_stocks() do
      if String.starts_with?(String.downcase(stock.name), String.downcase(query)) do
        stock.name
      end
    end
  end

  defp validate_stock(query) do
    Logger.debug(query)

    for %{name: name} <- Exchange.mock_stocks(),
        query = to_string(query),
        String.equivalent?(name, query),
        do: {:ok, name}
  end
end
