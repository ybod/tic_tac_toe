{games_played, unique_end_game_boards, all_unqiue_boards_configurations} = TicTacToe.try_all_combinations()

IO.puts("Total unique end game boards after #{games_played} games were played: #{unique_end_game_boards}")

file = File.open!("all_unique_boards.txt", [:write])

Enum.each(all_unqiue_boards_configurations, &IO.write(file, [TicTacToe.GameField.to_iolist(&1), "\n\n"]))

File.close(file)

IO.puts("Check all_unique_boards.txt for all unique valid game boards combinations")
