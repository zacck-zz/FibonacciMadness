defmodule FibMad.RouterTest do
  @moduledoc """
  This module holds unit tests for our Json API  router
  """
  use ExUnit.Case
  use Plug.Test

  alias FibMad.Router

  @opts Router.init([])

  describe "Router" do
    test "returns sum" do
      conn =
        conn(:get, "/sum/3")
        |> Router.call(@opts)

      assert conn.status == 200
      assert %{"sum" => 4} = Jason.decode!(conn.resp_body)
    end

    test "returns sums" do
      conn =
        conn(:get, "/sums/1,2")
        |> Router.call(@opts)

      assert conn.status == 200
      assert %{"sums" => _sums} = Jason.decode!(conn.resp_body)
    end

    test "returns count" do
      conn =
        conn(:get, "/count")
        |> Router.call(@opts)

      assert conn.status == 200
      assert %{"counts" => _counts} = Jason.decode!(conn.resp_body)
    end

    test "returns server history" do
      conn =
        conn(:get, "/history")
        |> Router.call(@opts)

      assert conn.status == 200
      assert %{"history" => _hist} = Jason.decode!(conn.resp_body)
    end
  end
end
