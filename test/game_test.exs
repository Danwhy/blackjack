defmodule GameTest do
  use ExUnit.Case

  alias Blackjack.{Deck, Game}

  test "hit" do
    deck = Deck.create_deck()
    {deck, hand} = Deck.deal(deck)

    {deck, hand} = Game.hit(deck, hand)

    assert length(hand) == 3
    assert length(deck) == 49
  end

  test "Cannot hit when bust" do
    deck = Deck.create_deck()
    hand = [{"10", :clubs}, {"10", :spades}, {"5", :hearts}]

    assert Game.hit(deck, hand) == {:error, "already bust"}
  end

  test "compare hands" do
    hand_1 = [{"2", :clubs}, {"5", :hearts}]
    hand_2 = [{"1", :spades}, {"8", :hearts}]

    assert Game.compare(hand_1, hand_2) == :lt
    assert Game.compare(hand_2, hand_1) == :gt

    hand_3 = [{"2", :clubs}, {"2", :hearts}]
    hand_4 = [{"1", :spades}, {"3", :hearts}]

    assert Game.compare(hand_3, hand_4) == :eq
    assert Game.compare(hand_4, hand_3) == :eq

    hand_5 = [{"10", :clubs}, {"K", :hearts}]
    hand_6 = [{"A", :spades}, {"Q", :hearts}]

    assert Game.compare(hand_5, hand_6) == :lt
    assert Game.compare(hand_6, hand_5) == :gt
  end

  test "Ace can be worth 1 or 11" do
    hand_1 = [{"A", :clubs}, {"10", :spades}, {"5", :diamonds}]
    hand_2 = [{"A", :clubs}, {"10", :spades}]
    hand_3 = [{"A", :spades}, {"A", :diamonds}, {"A", :hearts}, {"A", :clubs}]
    hand_4 = [{"A", :spades}, {"Q", :hearts}]

    assert Game.sum_hand(hand_1) == 16
    assert Game.sum_hand(hand_2) == 21
    assert Game.sum_hand(hand_3) == 14
    assert Game.sum_hand(hand_4) == 21
  end
end
