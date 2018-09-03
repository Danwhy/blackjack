defmodule GameTest do
  use ExUnit.Case

  test "hit" do
    deck = Blackjack.Deck.create_deck()
    {deck, hand} = Blackjack.Deck.deal(deck)

    {deck, hand} = Blackjack.Game.hit(deck, hand)

    assert length(hand) == 3
    assert length(deck) == 49
  end

  test "compare hands" do
    hand_1 = [{"2", :clubs}, {"5", :hearts}]
    hand_2 = [{"1", :spades}, {"8", :hearts}]

    assert Blackjack.Game.compare(hand_1, hand_2) == :lt
    assert Blackjack.Game.compare(hand_2, hand_1) == :gt

    hand_3 = [{"2", :clubs}, {"2", :hearts}]
    hand_4 = [{"1", :spades}, {"3", :hearts}]

    assert Blackjack.Game.compare(hand_3, hand_4) == :eq
    assert Blackjack.Game.compare(hand_4, hand_3) == :eq

    hand_5 = [{"10", :clubs}, {"K", :hearts}]
    hand_6 = [{"A", :spades}, {"Q", :hearts}]

    assert Blackjack.Game.compare(hand_5, hand_6) == :lt
    assert Blackjack.Game.compare(hand_6, hand_5) == :gt
  end
end
