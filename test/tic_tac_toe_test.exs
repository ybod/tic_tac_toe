defmodule TicTacToeTest do
  use ExUnit.Case, async: true

  test "it works" do
    # 362880
    # 255168

    assert {362_880, _} = TicTacToe.build_combinations()
  end
end
