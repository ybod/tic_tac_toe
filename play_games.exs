{combinations, boards_history} = TicTacToe.build_combinations()

IO.puts("Total combinations: #{combinations}")

file = File.open!("boards_history.txt", [:write])

Task.async_stream(boards_history, fn board ->
  :array.to_list(board)
  |> Enum.map(&if &1 == 0, do: "0", else: "X")
  |> Enum.chunk_every(3)
  |> Enum.map(&Enum.join(&1, " | "))
  |> Enum.intersperse("---------")
  |> Enum.join("\n")
end)
|> Enum.each(fn {:ok, str} ->
  IO.write(file, str)
  IO.write(file, "\n\n")
end)

File.close(file)

IO.puts("Check boards_history.txt for all possible games combinations")
