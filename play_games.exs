{combinations, boards_history} = TicTacToe.build_combinations()

IO.puts("Total combinations: #{combinations}")

file = File.open!("boards_history.txt", [:write])

Enum.each(boards_history, fn board ->
  rows =
    :array.to_list(board)
    |> Enum.map(&(if &1 == 0, do: "0", else: "X"))
    |> Enum.chunk_every(3)

  str =
    rows
    |> Enum.map(&Enum.join(&1, " | "))
    |> Enum.intersperse("---------")
    |> Enum.join("\n")

  IO.write(file, str)
  IO.write(file, "\n\n")
end)

File.close(file)

IO.puts("Check boards_history.txt for all possible combiantions")
