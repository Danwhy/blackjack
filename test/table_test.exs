defmodule TableTest do
  use ExUnit.Case

  alias Blackjack.Table

  test "init" do
    assert {:ok, _} = Table.start_link()
  end

  test "deal" do
    {:ok, pid} = Table.start_link()
    assert Table.deal(pid) == :ok
  end

end
