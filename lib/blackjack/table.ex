defmodule Blackjack.Table do
  use GenServer

  alias Blackjack.{Deck, Game}

  defmodule State do
    defstruct deck: [], dealer_hand: [], players: []
  end

  def start_link do
    GenServer.start_link(__MODULE__, State)
  end

  def handle_cast(:deal, %State{deck: current_deck} = state) do
    {deck, dealer_hand} = Deck.deal(current_deck)
    {:noreply, %{state | deck: deck, dealer_hand: dealer_hand}}
  end

  def init(deck) do
    {:ok, %State{deck: Deck.create_deck()}}
  end

  def deal(pid) do
    GenServer.cast(pid, :deal)
  end
end
