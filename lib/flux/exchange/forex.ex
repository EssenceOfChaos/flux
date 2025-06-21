defmodule Flux.Exchange.Forex do
  @moduledoc """
    Functions for retrieving Forex quotes
  """
  defstruct [
    :from,
    :to,
    :rate,
    :last_updated,
    :bid,
    :ask
  ]

  @api_key "Z8L6LGYIU0JK5GVN"
  @base_url "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency={FROM}&to_currency={TO}&apikey=#{@api_key}"

  def get_quote(from_currency, to_currency)
      when is_binary(from_currency) and is_binary(to_currency) do
    exchange_rate(from_currency, to_currency)
  end

  defp exchange_rate(from_currency, to_currency) do
    ufc = String.replace(@base_url, "{FROM}", from_currency)
    uri = String.replace(ufc, "{TO}", to_currency)

    case HTTPoison.get(uri) do
      {:ok, %{status_code: 200, body: body}} -> handle_response(body)
      # 404 Not Found Error
      {:ok, %{status_code: 404}} -> "Not found"
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end

  defp handle_response(body) do
    tmp = Jason.decode!(body)
    build_struct(tmp["Realtime Currency Exchange Rate"])
  end

  defp build_struct(attrs) do
    formatted_attrs = %{
      from: attrs["1. From_Currency Code"],
      to: attrs["3. To_Currency Code"],
      rate: attrs["5. Exchange Rate"],
      last_updated: attrs["6. Last Refreshed"],
      bid: attrs["8. Bid Price"],
      ask: attrs["9. Ask Price"]
    }

    struct(__MODULE__, formatted_attrs)
  end
end
