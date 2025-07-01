defmodule Flux.Exchange do
  @moduledoc """
  The Exchange Context
  """
  alias Flux.Exchange.Stock

  def open_stocks_csv() do
    Stock.open_stocks()
  end

  def mock_stocks() do
    [
      %{
        market_cap: "$2,482,288,353,920",
        name: "Apple Inc",
        sector: "Information Technology",
        symbol: "AAPL",
        image: "apple.png"
      },
      %{
        market_cap: "$1,928,014,206,749",
        name: "Microsoft Corp",
        sector: "Information Technology",
        symbol: "MSFT",
        image: "microsoft.png"
      },
      %{
        market_cap: "$1,324,201,940,000",
        name: "Alphabet Inc Class C",
        sector: "Communication Services",
        symbol: "GOOG",
        image: "google.png"
      },
      %{
        market_cap: "$1,324,201,940,000",
        name: "Alphabet Inc Class A",
        sector: "Communication Services",
        symbol: "GOOGL",
        image: "google.png"
      },
      %{
        market_cap: "$1,322,548,366,473",
        name: "Amazon.Com Inc.",
        sector: "Consumer Discretionary",
        symbol: "AMZN",
        image: "amazon.png"
      }
    ]
  end
end
