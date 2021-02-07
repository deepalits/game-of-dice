# frozen_string_literal: true

class Player
  attr_accessor :id, :name, :score, :count_of_one

  def initialize(opts)
    @id = opts[:id]
    @name = "Player-#{opts[:id]}"
    @score = 0
    @count_of_one = 0
  end
end
