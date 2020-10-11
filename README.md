# Blackjack

## Instructions

```elixir
iex -S mix

# Start a new table
{:ok, pid} = Blackjack.Table.start_link
# {:ok, #PID<0.180.0>}

# Add a player to the table
{:ok, player_id} = Blackjack.Table.join(pid)
# {:ok, #PID<0.182.0>}

# Deal a hand to all players
Blackjack.Table.deal(pid)
# :ok

# View a player's hand
Blackjack.Player.view_hand(player_id)
# [{"Q", :spades}, {"3", :hearts}]
```