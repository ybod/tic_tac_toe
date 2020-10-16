defmodule TicTacToeTest do
  use ExUnit.Case, async: true

  test "it works" do
    assert {unique_field_configurations, all_fields_configurations} = TicTacToe.try_all_combinations()

    assert unique_field_configurations == 958
    assert Enum.count(all_fields_configurations) == 958
    refute similar_fields?(all_fields_configurations)
  end

  defp similar_fields?([]), do: false

  defp similar_fields?([h | t]) do
    if Enum.any?(t, &(&1 === h)),
      do: true,
      else: similar_fields?(t)
  end
end
