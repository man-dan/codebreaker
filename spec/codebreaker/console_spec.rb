require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    subject(:console) { Console.new }
    context "#game process" do
      it "game win" do
        expect{subject.win(subject.game.secret_code)}.to output(/You win!/).to_stdout
      end

      it "game lose" do
        subject.instance_variable_set(:@turns,0)
        expect(subject.lose(6666)).to eq("Game over")
      end 

      it "play again" do
        expect{subject.play_again}.to output(/play again/).to_stdout
      end
    end
  end
end