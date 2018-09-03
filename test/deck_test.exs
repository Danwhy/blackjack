defmodule DeckTest do
  use ExUnit.Case

  test "create a deck" do
    deck = Blackjack.Deck.create_deck()
    assert length(deck) == 52
  end

  test "handle end of deck" do
    deck = []
    {deck, hand} = Blackjack.Deck.deal(deck)

    assert hand == nil
    assert deck == []
  end

  test "deal hands" do
    deck = Blackjack.Deck.create_deck()
    {deck, hand} = Blackjack.Deck.deal(deck)

    assert length(deck) == 50
    assert length(hand) == 2

    {deck, hand_2} = Blackjack.Deck.deal(deck)

    assert length(deck) == 48
    assert length(Enum.uniq(hand ++ hand_2)) == 4
  end
end
