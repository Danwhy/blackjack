defmodule Blackjack.Deck do
  @values ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
  @suits [:clubs, :hearts, :spades, :diamonds]

  @type card :: {String.t(), atom()}
  @type deck :: [card]
  @type hand :: [card]

  @spec create_deck() :: deck
  def create_deck do
    @suits
    |> Enum.flat_map(fn s -> Enum.map(@values, fn v -> {v, s} end) end)
    |> Enum.shuffle()
  end

  @spec deal(deck) :: {deck, hand}
  def deal(deck) when is_list(deck) do
    with {card_1, deck} when not is_nil(card_1) <- List.pop_at(deck, 0),
         {card_2, deck} when not is_nil(card_2) <- List.pop_at(deck, 0) do
      {deck, [card_1, card_2]}
    else
      {nil, []} -> {[], nil}
    end
  end
end
