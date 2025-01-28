require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Création des joueurs
player1 = Player.new("Booba")
player2 = Player.new("Kaaris")

# Boucle de combat
while player1.life_points > 0 && player2.life_points > 0
  # Présentation des combattants
  puts " "
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
  puts " "


  puts "Que le combat commence !"
  puts " "
  
  player1.attacks(player2)
  puts " "
  if player2.life_points <=0
    break  
  else 
    player2.attacks(player1)
  puts " " 
  end
end

binding.pry