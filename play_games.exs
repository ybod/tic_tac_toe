{unique_field_configurations, all_fields_configurations} = TicTacToe.try_all_combinations()

IO.puts("Total unique field aftel all games were played: #{unique_field_configurations}")

file = File.open!("all_unique_field.txt", [:write])

Enum.each(all_fields_configurations, &IO.write(file, [TicTacToe.GameField.to_iolist(&1), "\n\n"]))

File.close(file)

IO.puts("Checkall_unique_field.txt for all unqiue fileds combinations after all games were played")
