defmodule FibMad.Router do
  @moduledoc """
  This module holds routing logic for the application to enable it to handle different reques paths and HTTP verbs
  """
  use Plug.Router

  # plugs to match and dispatch routes
  plug(:match)
  plug(:dispatch)

  get("/", do: send_resp(conn, 200, "Welcome to Fibonacci"))

  get("/sum/:number") do
    {num, _} = Integer.parse(number)
    {:ok, total} = Fibonacci.calculate(num)

    send_resp(conn, 200, Jason.encode!(%{sum: total}))
  end

  get("/sums/:numbers") do
    {:ok, totals} =
      String.split(numbers, ",")
      |> Enum.map(fn item ->
        {num, _} = Integer.parse(item)
        num
      end)
      |> Fibonacci.calculate()

    send_resp(conn, 200, Jason.encode!(%{sums: totals}))
  end

  get("/history") do
    history =
      Fibonacci.history()
      |> Enum.into(%{})

    send_resp(conn, 200, Jason.encode!(%{history: history}))
  end

  get("/count") do
    count = Fibonacci.history_count()

    send_resp(conn, 200, Jason.encode!(%{counts: count}))
  end

  match(_, do: send_resp(conn, 404, "This server is not capable of that"))
end
