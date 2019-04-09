defmodule FibMad.Application do 
  @moduledoc """
  This module holds out OTP application configuration that runs our top level Supervisor and also starts our application 
  """
  use Application 
  require Logger 

  alias FibMad.{
    Router
  }

  @doc """
  Starts our application
  """
  @spec start(term(), term()) :: {:ok, pid()}
  def start(_type, _args) do 
    children = [
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: 5006]}
    ]

    opts = [strategy: :one_for_one, name: FibonacciMadness.Supervisor]

    Logger.info("Starting application on port 5006")
    
    Supervisor.start_link(children, opts)
  end  
end 
