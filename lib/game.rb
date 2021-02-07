# frozen_string_literal: true

require_relative 'player.rb'

class Game
  DICE_MIN = 1
  DICE_MAX = 6
  MAX_COUNT_OF_1 = 2

  attr_accessor :players

  def initialize(no_of_players, max_points)
    @no_of_players = no_of_players.to_i
    @max_points = max_points.to_i
    init_players
  end

  def init_players
    player_list = []
    @no_of_players.times do |i|
      player_list << Player.new({ id: i + 1 })
    end
    @players = player_list.shuffle.map { |player| [player.id, player] }.to_h
  end

  def start
    while players_in_game.size > 1
      players_in_game.each do |id, player|
        if player.count_of_one == MAX_COUNT_OF_1
          player.count_of_one = 0
          next
        end
        game_steps(id)
      end
    end
  end

  private

  # get players who have not scored maximum points
  def players_in_game
    players.select { |_id, player| player.score < @max_points }
  end

  def game_steps(id)
    show_prompt(players[id].name)
    input = gets.chomp
    continue_or_quit(input, id)
  end

  def show_prompt(name)
    puts "#{name} it's your turn (press r to roll the dice)"
  end

  def roll_a_dice_for_player(player_id)
    points = rand(DICE_MIN..DICE_MAX)
    players[player_id].score += points
    print_rank
    check_rules(player_id, points)
  end

  def check_rules(player_id, points)
    return if win?(player_id)

    case points
    when 1
      players[player_id].count_of_one += 1
    when 6
      game_steps(player_id)
    end
  end

  def win?(player_id)
    if players[player_id].score >= @max_points
      puts "#{players[player_id].name} wons"
      exit if players_in_game.size == 1
      return true
    end
    false
  end

  def continue_or_quit(input, id)
    case input
    when 'r'
      roll_a_dice_for_player(id)
    when 'q'
      exit
    else
      game_steps(id)
    end
  end

  def print_rank
    players.each do |_id, player|
      puts "#{player.name} : #{player.score}"
    end
  end
end
