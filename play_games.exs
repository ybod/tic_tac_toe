{unique_field_configurations, all_fields_configurations} = TicTacToe.try_all_combinations()

IO.puts("Total unique game boards combinations aftel all games were played: #{unique_field_configurations}")

file = File.open!("all_unique_fields.txt", [:write])

Enum.each(all_fields_configurations, &IO.write(file, [TicTacToe.GameField.to_iolist(&1), "\n\n"]))

File.close(file)

IO.puts("Check all_unique_fields.txt for all unique valid game boards combinations")
