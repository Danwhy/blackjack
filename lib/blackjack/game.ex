defmodule Blackjack.Game do
  alias Blackjack.Deck

  @spec hit(Deck.deck(), Deck.hand()) :: {Deck.deck(), Deck.hand()}
  def hit(deck, hand) do
    with {card, deck} when not is_nil(card) <- List.pop_at(deck, 0) do
      {deck, hand ++ [card]}
    else
      {nil, []} -> {[], hand}
    end
  end

  @spec compare(Deck.hand(), Deck.hand()) :: :lt | :eq | :gt
  def compare(hand_1, hand_2) do
    sum_hand_1 = sum_hand(hand_1)
    sum_hand_2 = sum_hand(hand_2)

    cond do
      sum_hand_1 > sum_hand_2 -> :gt
      sum_hand_1 < sum_hand_2 -> :lt
      sum_hand_1 == sum_hand_2 -> :eq
    end
  end

  @spec sum_hand(Deck.hand()) :: pos_integer()
  def sum_hand(hand) do
    hand
    |> Enum.reduce(0, fn ({v, _s}, acc) ->
      acc + case v do
        f when f in ["K", "Q", "J"] -> 10
        "A" -> 11
        int -> String.to_integer(int)
      end
    end)
  end
end
