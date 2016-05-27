module Codebreaker
  class Game
    attr_accessor :secret_code, :game_process, :turns, :hints
    def initialize
      @secret_code = (0...4).map { rand(1..6) }.join
      @turns = 10
      @hints = 1
      @game_process = true
    end

    def check(guess)
      mark = ''
      @turns -=1
      codes = @secret_code.chars.zip(guess.to_s.chars)
      mark<< '+' * codes.select {|x,y| x==y }.count
      minus = codes.delete_if {|x,y| x==y }
      mark<< '-' * (minus.transpose[0] & minus.transpose[1]).count unless minus.empty?
      mark
    end

    def hint
      return "0 hints remain" if @hints==0
      @hints -=1
      @secret_code.chars.sample
    end

    def save_game(name)
      f = File.open("./db/records.txt","a+")
      f<<"name:#{name}-turns:#{10-@turns}-hints:#{@hints}"
      puts "The record was saved"
    end

    def load_rec
      url = './db/records.txt'
      File.exist?(url) ? File.open(url,'r').each { |rec| puts rec } : "Not have any records\n".display
    end
  end
end

