defmodule TicTacToe do
  @moduledoc """
  Play all possible Tic Tac Toe games
  """

  alias TicTacToe.GameField

  @symbol_X 1
  @symbol_0 0

  # X is starting game
  def try_all_combinations do
    results_ets = :ets.new(__MODULE__, [:set, :public, {:write_concurrency, true}])
    :ets.insert_new(results_ets, {:unique_end_game_boards, 0})
    :ets.insert_new(results_ets, {:games_played, 0})

    all_cells = Enum.to_list(0..8)
    empty_field = GameField.new()

    # Play Games
    Task.async_stream(all_cells, fn first_cell ->
      starting_game_field = GameField.put!(empty_field, first_cell, @symbol_X)
      empty_cells = all_cells -- [first_cell]

      play_game(starting_game_field, @symbol_0, empty_cells, results_ets)
    end)
    |> Stream.run()

    # Get Results
    [unique_end_game_boards: unique_end_game_boards] = :ets.lookup(results_ets, :unique_end_game_boards)
    [games_played: games_played] = :ets.lookup(results_ets, :games_played)

    :ets.delete(results_ets, :unique_end_game_boards)
    :ets.delete(results_ets, :games_played)

    all_unqiue_boards_configurations = Enum.map(:ets.tab2list(results_ets), fn {field} -> field end)

    {games_played, unique_end_game_boards, all_unqiue_boards_configurations}
  end

  defp play_game(game_field, _current_symbol, _empty_cells = [], results_ets) do
    save_results(game_field, results_ets)
  end

  defp play_game(game_field, current_symbol, empty_cells, results_ets) do
    Enum.each(empty_cells, fn next_cell ->
      new_game_field = GameField.put!(game_field, next_cell, current_symbol)
      new_empty_cells = empty_cells -- [next_cell]
      next_symbol = get_next_symbol(current_symbol)

      if five_moves_made(new_empty_cells) and GameField.win?(new_game_field) do
        save_results(new_game_field, results_ets)
      else
        play_game(new_game_field, next_symbol, new_empty_cells, results_ets)
      end
    end)
  end

  defp save_results(game_field, results_ets) do
    if :ets.insert_new(results_ets, {game_field}) == true do
      :ets.update_counter(results_ets, :unique_end_game_boards, 1)
    end

    :ets.update_counter(results_ets, :games_played, 1)
  end

  defp get_next_symbol(@symbol_X), do: @symbol_0
  defp get_next_symbol(@symbol_0), do: @symbol_X

  defp five_moves_made([_, _, _, _]), do: true
  defp five_moves_made([_, _, _]), do: true
  defp five_moves_made([_, _]), do: true
  defp five_moves_made([_]), do: true
  defp five_moves_made([]), do: true
  defp five_moves_made(empty_cells) when is_list(empty_cells), do: false
end
