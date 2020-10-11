defmodule Blackjack.Table do
  use GenServer

  alias Blackjack.{Deck, Game}

  defmodule State do
    defstruct deck: [], dealer_hand: [], players: []
  end

  def start_link do
    GenServer.start_link(__MODULE__, State)
  end

  def deal(pid) do
    GenServer.cast(pid, :deal)
  end

  def join(pid) do
    with {:ok, player_pid} <- GenServer.start_link(Blackjack.Player, []) do
      GenServer.cast(pid, {:add_player, player_pid})
      {:ok, player_pid}
    end
  end

  def list_players(pid) do
    GenServer.call(pid, :list_players)
  end

  ## GenServer implementation

  def init(deck) do
    {:ok, %State{deck: Deck.create_deck()}}
  end

  def handle_cast(:deal, %State{deck: current_deck, players: players} = state) do
    {deck, dealer_hand} = Deck.deal(current_deck)

    updated_deck = Enum.reduce(players, deck, fn p, d ->
      GenServer.call(p, {:deal, d})
    end)

    {:noreply, %{state | deck: updated_deck, dealer_hand: dealer_hand}}
  end

  def handle_cast({:add_player, player_pid}, %State{players: players} = state) do
    {:noreply, %{state | players: players ++ [player_pid]}}
  end

  def handle_call(:list_players, _, state) do
    {:reply, state.players, state}
  end
end
