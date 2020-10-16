defmodule TicTacToe.GameField do
  @moduledoc """
  Tic Tac Toe Game Field: 9 cells

  0 | 1 | 2
  ---------
  3 | 4 | 5
  ---------
  6 | 7 | 8
  """

  @symbol_X 1
  @symbol_0 0

  @empty_game_field %{
    # row 1
    c0: nil,
    c1: nil,
    c2: nil,
    # row 2
    c3: nil,
    c4: nil,
    c5: nil,
    # row 3
    c6: nil,
    c7: nil,
    c8: nil
  }

  def new, do: @empty_game_field

  def put!(game_field, cell_num, symbol)
      when is_map(game_field) and cell_num >= 0 and cell_num <= 8 and symbol in [@symbol_0, @symbol_X] do
    Map.update!(game_field, get_cell_name(cell_num), fn val ->
      unless val == nil, do: raise(KeyError, message: "field #{cell_num} is not empty")
      symbol
    end)
  end

  def to_iolist(game_field) when is_map(game_field) do
    game_field
    |> Enum.map(fn
      {_k, @symbol_X} -> " X "
      {_k, @symbol_0} -> " 0 "
      {_k, nil} -> "   "
    end)
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.intersperse(&1, "|"))
    |> Enum.intersperse("-----------")
    |> Enum.intersperse("\n")
  end

  # three in a row
  def win?(%{c0: same_symbol, c1: same_symbol, c2: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  def win?(%{c3: same_symbol, c4: same_symbol, c5: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  def win?(%{c6: same_symbol, c7: same_symbol, c8: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  # three in a column
  def win?(%{c0: same_symbol, c3: same_symbol, c6: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  def win?(%{c1: same_symbol, c4: same_symbol, c7: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  def win?(%{c2: same_symbol, c5: same_symbol, c8: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  # diagonals
  def win?(%{c0: same_symbol, c4: same_symbol, c8: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  def win?(%{c2: same_symbol, c4: same_symbol, c6: same_symbol}) when same_symbol in [@symbol_0, @symbol_X], do: true
  # esle
  def win?(%{}), do: false

  defp get_cell_name(cell_num), do: String.to_existing_atom("c#{cell_num}")
end
