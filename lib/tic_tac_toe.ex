defmodule TicTacToe do
  @moduledoc """
  Play all possible Tic Tac Toe games
  """

  @first_player 0
  @second_player 1

  def build_combinations do
    {:ok, counter_pid} = Agent.start_link(fn -> 0 end)
    {:ok, boards_history_pid} = Agent.start_link(fn -> [] end)
    all_fields = Enum.into(0..8, [])
    board = :array.new(9)

    Enum.map(all_fields, fn first_field ->
      Task.async(fn ->
        starting_board = :array.set(first_field, @first_player, board)
        unoccupied_fields = all_fields -- [first_field]

        play_game(starting_board, @second_player, unoccupied_fields, counter_pid, boards_history_pid)
      end)
    end)
    |> Enum.map(&Task.await(&1))

    {Agent.get(counter_pid, fn counter -> counter end),
     Agent.get(boards_history_pid, fn boards_history -> Enum.reverse(boards_history) end)}
  end

  defp play_game(board, _current_player, [], counter_pid, boards_history_pid) do
    Agent.update(counter_pid, fn counter -> counter + 1 end)
    Agent.update(boards_history_pid, fn boards_history -> [board | boards_history] end)
  end

  defp play_game(board, current_player, unoccupied_fields, counter_pid, boards_history_pid) do
    next_player = if current_player == @first_player, do: @second_player, else: @first_player

    Enum.each(unoccupied_fields, fn next_field ->
      updated_board = :array.set(next_field, current_player, board)
      updated_unoccupied_fields = unoccupied_fields -- [next_field]

      play_game(updated_board, next_player, updated_unoccupied_fields, counter_pid, boards_history_pid)
    end)
  end
end
