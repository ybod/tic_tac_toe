defmodule TicTacToeTest do
  use ExUnit.Case

  test "works" do
    assert 9 ==
             TicTacToe.build_combiantions()
             |> Enum.count()

    # 255 168
  end
end
