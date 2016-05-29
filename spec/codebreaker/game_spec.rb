require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    context "#init" do
      it "saves secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
 
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code).length).to eq(4)
      end
 
      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context "#check guess" do
      before do
        game.instance_variable_set(:@secret_code,"1231")
      end

      it "game_result win" do
        expect(game.check(1231)).to eq("++++")
      end

      it "game_result not guessed" do
        expect(game.check(5656)).to eq("")
      end

      it "game_result not guessed positions" do
        expect(game.check(2113)).to eq("----")
      end

      it "game_result half guessed" do
        expect(game.check(1111)).to eq("++")
      end

      it "game_result half unguessed" do
        expect(game.check(6116)).to eq("--")
      end

      it "game_result half+ && half-" do
        expect(game.check(1321)).to eq("++--")
      end

       it "game_result +-" do
        expect(game.check(6111)).to eq("+-")
      end

      it "game_result another_one unguessed" do
        expect(game.check(6166)).to eq("-")
      end

      it "check - reduce turns" do
        game.check(2143)
        expect(game.instance_variable_get(:@turns)).to eq(9)
      end
    end

    context "#hints" do

      it "reduce hints" do
        game.hint
        expect(game.instance_variable_get(:@hints)).to eq(0)
      end
      
      it "hint" do
        expect(game.instance_variable_get(:@secret_code)).to include(game.hint)
      end

      it "0 hints" do
        game.hint
        expect(game.hint).to eq("0 hints remain")
      end
    end

    context "#files" do
      it "save record" do
        expect(game.save_game("Den")).to eq("The record was saved")
      end
    end
  end
end