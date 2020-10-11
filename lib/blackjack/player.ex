defmodule Blackjack.Player do
  use GenServer

  alias Blackjack.{Deck, Game}

  def handle_call({:deal, current_deck}, _from, []) do
    {deck, hand} = Deck.deal(current_deck)
    {:reply, deck, hand}
  end

  def handle_call(:view_hand, _, hand), do: {:reply, hand, hand}

  def view_hand(pid) do
    GenServer.call(pid, :view_hand)
  end

  def init(hand) do
    {:ok, hand}
  end
end
