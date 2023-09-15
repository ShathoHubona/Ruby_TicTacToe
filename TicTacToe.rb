module TicTacToe
    class Game
        @@someone_won = false
        @@availables_position = 9
        def initialize

            puts "Welcome to Tic-Tac-Toe!"

            puts "Insert 1st player name"
            player1_name = gets.chomp

            puts "Insert 2nd player name"
            player2_name = gets.chomp

            puts "Starting game between #{player1_name} and #{player2_name}"

            @player1 = Player.new(player1_name, 'X')
            @player2 = Player.new(player2_name, 'O')
            @table = Table.new
            @current_turn = who_starts
            puts "Tossing a coin..."
            2.times do 
                sleep 1
                puts '.'
                puts '.'
            end

            run_game
        end

        def who_starts
            rand(0..1) == 1 ? @player1 : @player2
        end

        def run_game
            @table.print_table
            until @@someone_won || @@availables_position == 0
                puts "#{@current_turn.name} turn, choose a position"
                puts "Indicates position as a coordinate separated by a white space.\nExample: 1 1 (First column - First row)"
                

                #Check correct input
                @correct_input = false
                until @correct_input
                    user_move = gets.chomp
                    if correct_input?(user_move)

                        if available_position?(user_move,@table.array_table)
                            @table.update_table(user_move, @current_turn.symbol)
                            @@availables_position -= 1
                            @correct_input = true
                        else
                            puts 'Unavailable position'
                            puts 'Please indicates other coordinate'
                        end

                    else
                        puts "Please write a appropiate input. Two number separated by a whitespace"
                    end
                    
                    

                end

                @@someone_won = @table.check_winner

                unless @@someone_won
                    switch_players
                end
                
                @table.print_table
                
            end

            if @@someone_won
                puts "We have a winner!"
                puts "Congratulations #{@current_turn.name}"
            else
                puts "It's a tie..."
            end
            
        end 

        def correct_input?(user_move)

            if user_move.length != 3
                return false
            elsif user_move[1] != ' '
                return false
            end

            [0,2].each do |position|
                unless user_move[position].to_i.between?(1,3)
                    return false
                end
            end
            return true
        end

        def available_position?(user_move,array_table)
            row = (user_move[0].to_i) -1
            column = (user_move[2].to_i) -1
            if array_table[row][column] != '_' 

                return false
            else
                return true
            end
        end

        def switch_players
            @current_turn = (@current_turn == @player1) ? @player2 : @player1
        end


    end
    end

    class Player
        attr_reader :name, :symbol

        def initialize(name, symbol)
            @name = name
            @symbol = symbol
        end
    end

    class Table
        attr_reader :array_table
        def initialize()
            @array_table = [['_','_','_'],['_','_','_'],['_','_','_']]
        end

        def print_table()
            @array_table.each do |row|
                puts "| #{row[0]} #{row[1]} #{row[2]} |"
            end
            return "Current state"
        end

        def update_table(move_as_array, player_symbol)
            row = move_as_array[0].to_i - 1
            column = move_as_array[2].to_i - 1
            @array_table[row][column] = player_symbol
        end

        def check_winner()
            # Win cases
            win_cases = {upper_row: @array_table[0], middle_row: @array_table[1],
                down_row: @array_table[2], left_column: [@array_table[0][0],@array_table[1][0],@array_table[2][0]], 
                center_column: [@array_table[0][1],@array_table[1][1],@array_table[2][1]],
                right_column: [@array_table[0][2],@array_table[1][2],@array_table[2][2]],
                down_up_diagonal: [@array_table[2][0],@array_table[1][1],@array_table[0][2]],
                up_down_diagonal: [@array_table[0][0],@array_table[1][1],@array_table[2][2]]}

            win_cases.each do |key,value|
                reduced_array = value.uniq
                if reduced_array.uniq.length == 1 && reduced_array[0] != '_'
                    return true
                end
            end

            return false
            # upper_row = @array_table[0]
            # middle_row = @array_table[1]
            # down_row = @array_table[2]
            # left_column = [@array_table[0][0],@array_table[1][0],@array_table[2][0]]
            # center_column = [@array_table[0][1],@array_table[1][1],@array_table[2][1]]
            # right_column = [@array_table[0][2],@array_table[1][2],@array_table[2][2]]
            # down_up_diagonal = [@array_table[2][0],@array_table[1][1],@array_table[0][2]]
            # up_down_diagonal = [@array_table[0][0],@array_table[1][1],@array_table[2][2]]


        
        end

    end

    


include TicTacToe
Game.new()