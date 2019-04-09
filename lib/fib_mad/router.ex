defmodule FibMad.Router do
  @moduledoc """
  This module holds routing logic for the application to enable it to handle different reques paths and HTTP verbs
  """
  use Plug.Router

  # plugs to match and dispatch routes
  plug(:match)
  plug(:dispatch)

  get("/", do: send_resp(conn, 200, "Welcome to Fibonacci"))
  match(_, do: send_resp(conn, 404, "This server is not capable of that"))
end 
