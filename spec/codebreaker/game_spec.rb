require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    subject(:game) { Game.new }
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
      [
        ['1234', '1234', '++++'],['1234', '1233', '+++'],
        ['1111', '1215', '++'],  ['1234', '1111', '+'],
        ['1234', '4246', '+-'],  ['1234', '1643', '+--'],
        ['1234', '4132', '+---'],['1234', '6214', '++-'],
        ['1234', '1243', '++--'],['1212', '2121', '----'],
        ['1234', '3363', '-'],   ['1234', '6565', '']       
      ].each do |variant|
        it "secret_code - #{variant[0]}, guess - #{variant[1]}, marks - #{variant[2]}" do
          game.instance_variable_set(:@secret_code, variant[0])
          expect(game.send(:check, variant[1])).to eq(variant[2])
        end
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