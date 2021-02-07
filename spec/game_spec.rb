# frozen_string_literal: true

require 'game'

describe Game do
  describe '#init_players' do
    context 'given an empty string as arguments' do
      it 'returns empty hash' do
        expect(Game.new('', '').players).to eq({})
      end
    end

    context 'given a number of players and max points as arguments' do
      it 'returns players intial info' do
        obj = Game.new(3, 20)
        result = obj.players
        expect(result.size).to eq(3)
        expect(result.map { |_id, r| r.name }).to match_array(%w[Player-1 Player-2 Player-3])
      end
    end
  end
end
