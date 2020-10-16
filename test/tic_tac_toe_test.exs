defmodule TicTacToeTest do
  use ExUnit.Case, async: true

  test "it works" do
    {games_played, unique_end_game_boards, all_unqiue_boards_configurations} = TicTacToe.try_all_combinations()

    assert games_played == 255_168
    assert unique_end_game_boards == 958
    assert Enum.count(all_unqiue_boards_configurations) == 958
    refute similar_fields?(all_unqiue_boards_configurations)
  end

  defp similar_fields?([]), do: false

  defp similar_fields?([h | t]) do
    if Enum.any?(t, &(&1 === h)),
      do: true,
      else: similar_fields?(t)
  end
end
