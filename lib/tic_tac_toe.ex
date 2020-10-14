defmodule TicTacToe do
  @moduledoc """
  Play all possible Tic Tac Toe games
  """

  @first_player 0
  @second_player 1

  def build_combiantions do
    empty_table = [nil, nil, nil, nil, nil, nil, nil, nil, nil]

    Enum.map(0..8, &play_game(List.replace_at(empty_table, &1, @first_player), @first_player, []))
  end

  defp play_game([], _, res_table), do: res_table

  defp play_game([field | rest_of_board], previous_player, new_table) do
    if field == previous_player do
      play_game(rest_of_board, previous_player, new_table ++ [previous_player])
    else
      new_player = if previous_player == @first_player, do: @second_player, else: @first_player

      play_game(rest_of_board, new_player, new_table ++ [new_player])
    end
  end
end
