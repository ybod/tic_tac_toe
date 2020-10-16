defmodule TicTacToe.GameFieldTest do
  use ExUnit.Case, async: true

  alias TicTacToe.GameField

  @symbol_X 1
  @symbol_0 0

  test "can put symbol in unoccupied cell" do
    field =
      GameField.new()
      |> GameField.put!(0, @symbol_X)
      |> GameField.put!(8, @symbol_0)

    assert field[:c0] == @symbol_X
    assert field[:c8] == @symbol_0
  end

  test "can't put field in occupied cell" do
    field = GameField.put!(GameField.new(), 4, @symbol_X)

    assert_raise KeyError, fn -> GameField.put!(field, 4, @symbol_0) end
  end

  test "can't put field in non existing cell" do
    assert_raise FunctionClauseError, fn -> GameField.put!(GameField.new(), 10, @symbol_X) end
    assert_raise FunctionClauseError, fn -> GameField.put!(GameField.new(), -1, @symbol_0) end
  end

  test "can't put invalid value in existing cell" do
    assert_raise FunctionClauseError, fn -> GameField.put!(GameField.new(), 7, "X") end
  end

  test "can evaluate 3 in a row win condition" do
    Enum.to_list(0..8)
    |> Enum.chunk_every(3)
    |> Enum.each(fn [cell1, cell2, cell3] ->
      field =
        GameField.new()
        |> GameField.put!(cell1, @symbol_X)
        |> GameField.put!(cell2, @symbol_X)
        |> GameField.put!(cell3, @symbol_X)

      assert GameField.win?(field)
    end)
  end

  test "can evaluate 3 in a column win condition" do
    [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    |> Enum.each(fn [cell1, cell2, cell3] ->
      field =
        GameField.new()
        |> GameField.put!(cell1, @symbol_0)
        |> GameField.put!(cell2, @symbol_0)
        |> GameField.put!(cell3, @symbol_0)

      assert GameField.win?(field)
    end)
  end

  test "can evaluate diagonal win condition" do
    [[8, 4, 0, @symbol_X], [6, 4, 2, @symbol_0]]
    |> Enum.each(fn [cell1, cell2, cell3, symbol] ->
      field =
        GameField.new()
        |> GameField.put!(cell1, symbol)
        |> GameField.put!(cell2, symbol)
        |> GameField.put!(cell3, symbol)

      assert GameField.win?(field)
    end)
  end

  test "can evaluate no win conditions" do
    field = GameField.new()
    refute GameField.win?(field)

    field = GameField.put!(field, 0, @symbol_0)
    refute GameField.win?(field)

    field = GameField.put!(field, 1, @symbol_0)
    refute GameField.win?(field)

    field = GameField.put!(field, 2, @symbol_X)
    refute GameField.win?(field)
  end

  test "can create iolist from field" do
    field =
      Enum.reduce([8, 4, 0], GameField.new(), &GameField.put!(&2, &1, @symbol_X))
      |> GameField.put!(2, @symbol_0)
      |> GameField.put!(6, @symbol_0)

    assert " X |   | 0 \n" <>
             "-----------\n" <>
             "   | X |   \n" <>
             "-----------\n" <>
             " 0 |   | X " == IO.iodata_to_binary(GameField.to_iolist(field))
  end
end
