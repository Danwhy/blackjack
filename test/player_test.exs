defmodule PlayerTest do
  use ExUnit.Case

  alias Blackjack.{Player, Table}

  test "init" do
    {:ok, pid} = Table.start_link()
    assert {:ok, _} = Table.join(pid)
  end

  test "deal" do
    {:ok, pid} = Table.start_link()
    {:ok, player_id} = Table.join(pid)

    deal = Task.async(fn -> Table.deal(pid) end)

    with :ok <- Task.await(deal) do
      assert length(Player.view_hand(player_id)) == 2
    end
  end
end
