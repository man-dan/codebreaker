module Codebreaker
  class Console
    attr_accessor :game, :name
    def initialize
      @game = Game.new
      @name = ''
    end

    def start
      puts "Enter name of player:"
      @name = gets.chomp while @name.empty?
      puts "Enter guess of code (4 numbers from 1 to 6)"
      puts "Enter 'h' - for hint,'q' for exit or 'r' for viewing records"
      while (@game.game_process) do
        case  guess = gets.chomp
          when 'h' then puts "One of the  number: #{@game.hint}"
          when 'q' then break
          when 'r' then @game.load_rec
          else
            guess.match(/^[1-6]{4}$/) ? check_guess(guess) :  "Uncorrect input\n".display
          end
        end
    end

    def check_guess(guess)
      puts @game.check(guess)
      win(guess)
      lose(guess)
      play_again if @game.game_process==false
    end

    def win(guess)
      if guess == @game.secret_code
        @game.game_process=false
        puts "You win! Press 's' if you want to save record"
        @game.save_game(@name) if gets.chomp == "s"
      end
    end

    def lose(guess)
      if @game.turns == 0
        @game.game_process=false
        puts "You lose =("
      end
    end

    def play_again
      puts "Press 'p' if you want to play again"
      Console.new.start if gets.chomp == "p"
    end
  end
end

