module TicTacToe
  class Player
    attr_reader :name
  
    def initialize(name)
      @name = name
    end
  end

  class Board
    attr_reader :board
  
    def initialize
      @board = Array.new(3) { Array.new(3,0) }
    end
  
    def set_x(x, y)
      begin
        return @board[x][y] == 0 ?  @board[x][y] = 1 : false
      rescue
        return false
      end
    end
  
    def set_y(x, y)
      begin
        return @board[x][y] == 0 ?  @board[x][y] = 2 : false
      rescue
        return false
      end
    end

    def get_val(x, y)
      return @board[x][y]
    end

    def is_full?
      @board.each do |a|
        a.each do |b|
          if b == 0
            return false
          end
        end
      end

      true
    end
  
    def print_board
      puts "   0  1  2"
  
      @board.each_with_index do |a, i|
        print "#{i} "
        a.each do |b|
          case b
          when 0 
            print " - "
          when 1 
            print " X "
          when 2 
            print " O "
          end
        end
  
        puts ""
      end
      
    end
  end
  
  class Game
    def initialize
      @board = Board.new
    end

    def play
      puts "Enter player1 name:"
      @player1 = gets.chomp
      @player1 = Player.new(@player1)
      puts "Enter player2 name:"
      @player2 = gets.chomp
      @player2 = Player.new(@player2)

      @board.print_board

      puts "Enter coordinates like {1 1}, {0 2}, {2 2} etc."

      until win || @board.is_full? 
        puts "#{@player1.name}'s turn!"
        p1 = gets.chomp
        a = p1.split(" ").map(&:to_i)
        
        until @board.set_x(a.first,a.second)
          puts "You entered wrong coordinates, try again!"
          p1 = gets.chomp
          a = p1.split(" ").map(&:to_i)
        end
        
        if win
          puts "#{@player1.name}'s win"
          break
        elsif @board.is_full?
          puts "Draw"
          break
        end

        @board.print_board
        puts "#{@player2.name} turn!"
        p1 = gets.chomp
        b = p1.split(" ").map(&:to_i)

        until @board.set_y(b.first,b.second)
          puts "You entered wrong coordinates, try again!"
          p2 = gets.chomp
          b = p2.split(" ").map(&:to_i)
        end

        if win
          puts "#{@player2.name} win"
          break
        elsif @board.is_full?
          puts "Draw"
          break
        end

        @board.print_board
      end

      reset
    end

    private

      def reset
        @board = Board.new
      end
  
      def win
        array_win = [
          [[0,0],[0,1],[0,2]],
          [[1,0],[1,1],[1,2]],
          [[2,0],[2,1],[2,2]],
          [[0,0],[1,0],[2,0]],
          [[0,1],[1,1],[2,1]],
          [[0,2],[1,2],[2,2]],
          [[0,0],[1,1],[2,2]],
          [[0,2],[1,1],[2,0]]
        ]
  
        array_win.each do |x|
          return true if x.all? { |y| @board.get_val(y.first, y.last) == @board.get_val(x[0].first,x[0].last) && @board.get_val(y.first, y.last) != 0 }
        end
  
        return false
      end
  end
end