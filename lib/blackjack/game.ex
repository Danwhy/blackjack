defmodule Blackjack.Game do
  alias Blackjack.Deck

  @spec hit(Deck.deck(), Deck.hand()) :: {Deck.deck(), Deck.hand()}
  def hit(deck, hand) do
    with sum when sum <= 21 <- sum_hand(hand),
         {card, deck} when not is_nil(card) <- List.pop_at(deck, 0) do
      {deck, hand ++ [card]}
    else
      n when is_integer(n) -> {:error, "already bust"}
      {nil, []} -> {:error, "deck is empty"}
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
    parsed_hand =
      Enum.map(hand, fn {v, _} ->
        case v do
          "A" -> [1, 11]
          c when c in ["J", "Q", "K"] -> 10
          c -> String.to_integer(c)
        end
      end)

    without_aces = sum_numbers_from_list(parsed_hand)

    aces = Enum.filter(parsed_hand, &is_list(&1))

    if length(aces) > 0 do
      without_aces =
        cond do
          length(aces) > 1 -> without_aces + (length(aces) - 1)
          true -> without_aces
        end

      cond do
        without_aces + 11 > 21 -> without_aces + 1
        true -> without_aces + 11
      end
    else
      without_aces
    end
  end

  @spec sum_numbers_from_list(list) :: integer()
  defp sum_numbers_from_list(list) when is_list(list) do
    Enum.reduce(list, 0, fn
      a, acc when is_integer(a) -> acc + a
      _a, acc -> acc
    end)
  end
end
