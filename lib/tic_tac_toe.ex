defmodule TicTacToe do
  @moduledoc """
  Play all possible Tic Tac Toe games
  """

  @first_player 0
  @second_player 1

  def build_combiantions do
    {:ok, counter_pid} = Agent.start_link(fn -> 0 end)

    Enum.each(0..8, fn cell ->
      starting_table = :array.set(cell, @first_player, :array.new(9))
      play_game(starting_table, @second_player, 0, counter_pid)
    end)

    Agent.get(counter_pid, fn counter -> counter end)
  end

  defp play_game(table, _current_player, _position = 9, counter_pid) do
    IO.inspect(:array.to_list(table))
    Agent.update(counter_pid, fn counter -> counter + 1 end)
  end

  defp play_game(table, current_player, position, counter_pid) do
    if :array.get(position, table) == :undefined do
      new_table = :array.set(position, current_player, table)
      new_player = if current_player == @first_player, do: @second_player, else: @first_player
      play_game(new_table, new_player, position + 1, counter_pid)
    else
      play_game(table, current_player, position + 1, counter_pid)
    end
  end
end
