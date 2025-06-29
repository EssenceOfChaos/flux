# Flux

## Setup

To start your Phoenix server you will need _Erlang_, _Elixir_, and _Postgres_.

Install Erlang with Homebrew: `brew install erlang`
Install Elixir `brew install elixir`

Install Hex package manager: `mix local.hex`
Install Phoenix `mix archive.install hex phx_new`
Install Postgres `brew install postgresql`

Install dependencies with `mix deps.get`

Create and migrate your database with `mix ecto.setup`

Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit `localhost:4000` from your browser.

If you already have Elixir, Phoenix, and Postgres on your machine:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

<hr/>

## Developing Flux

Run the tests with `mix test`

### Forex Pairs:

- usd / eur - euro
- usd / jpy - japanese yen
- usd / cad - canadian dollar
- usd / cny - chinese yuan
- usd / gbp - great british pound
- usd / krw - south korean won
- usd / aud - australian dollar
- usd / chf - swiss franc
- usd / nzd - new zealand dollar
- usd / inr - indian rupee

## Example

### Getting a Foreign Exchange Pair

```elixir
iex(1)> Flux.Exchange.Forex.get_quote("USD", "JPY")
%Flux.Exchange.Forex{
  from: "USD",
  to: "JPY",
  rate: "146.05400000",
  last_updated: "2025-06-20 21:46:25",
  bid: "146.05150000",
  ask: "146.06000000"
}
```

### Getting a Stock Quote

```elixir
iex(1)> Flux.Exchange.Stock.get_quote("AAPL")
%Flux.Exchange.Stock{
  symbol: "AAPL",
  price: "201.0000",
  volume: "95795378",
  change: "4.4200",
  change_percent: "2.2484%"
}
```
