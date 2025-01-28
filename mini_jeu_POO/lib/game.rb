require 'bundler'
require 'pry'

Bundler.require

require_relative 'player'

class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight

  def initialize(human_player_name)
    @human_player = HumanPlayer.new(human_player_name)
    @players_left = 10
    @enemies_in_sight = []
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
    @players_left -= 1
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @players_left > 0
  end

  def show_players
    puts "\e[4mRésumé :\e[0m"
    puts "Il reste #{@players_left} ennemis à éliminer.⚠️"
    puts " "
    puts "Ennemis en vue : 🔍🔍"
    @enemies_in_sight.each do |enemy|
      enemy.show_state
    end
    @human_player.show_state
    puts " "
  end

  def menu
    puts "\e[1mQuelle action veux-tu effectuer ?\e[0m"
    puts "a - chercher une meilleure arme 🏹"
    puts "s - chercher à se soigner ⚕️"
    puts "attaquer un joueur en vue : 🗡️"
    @enemies_in_sight.each_with_index do |enemy, index|
      if enemy.life_points > 0
        puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie 💚"
      end
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      puts " "
      puts "Le dès est lancé🎲"
      gets.chomp
      @human_player.search_weapon
    when "s"
      puts " "
      puts "Le dès est lancé🎲"
      gets.chomp
      @human_player.search_health_pack
    when /\d+/
      enemy_index = choice.to_i
      if enemy_index >= 0 && enemy_index < @enemies_in_sight.length
        enemy = @enemies_in_sight[enemy_index]
        if enemy.life_points > 0
          @human_player.attacks(enemy)
          kill_player(enemy) if enemy.life_points <= 0
        else
          puts "Cet ennemi est déjà mort."
        end
      else
        puts "Choix invalide. Veuillez réessayer."
      end
    else
      puts "Choix invalide. Veuillez réessayer."
    end
  end

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(@human_player)
      end
    end
  end

  def end
    puts "La partie est finie 🏅"
    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end

  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      puts "Tous les joueurs ont spawn sur la map!⚰️⚰️"
      return
    end

    dice_roll = rand(1..6)
    case dice_roll
    when 1
      puts "Aucun nouveau joueur adverse n'arrive.🤷"
    when 2..4
      new_enemy = Player.new("joueur_#{rand(1..999)}")
      @enemies_in_sight << new_enemy
      puts " "
      puts "Un nouvel adversaire a spawn sur la map : #{new_enemy.name} 💩"
    when 5..6
      new_enemy1 = Player.new("joueur_#{rand(1..100)}")
      new_enemy2 = Player.new("joueur_#{rand(100..200)}")
      @enemies_in_sight << new_enemy1
      @enemies_in_sight << new_enemy2
      puts "Deux nouveaux adversaires arrivent sur tes côtes ! : #{new_enemy1.name} et #{new_enemy2.name} 🤺🤺"
      puts " "
    end
  end
end