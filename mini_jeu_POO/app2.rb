require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#Accueil
puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "------------------------------------------------"

# Initialisation du joueur
puts "Ton prénom :"
print ">"
user_name = gets.chomp 
user = Humanplayer.new(user_name)

#Initialisation des ennemis
enemy1 = Player.new("Booba")
enemy2 = Player.new("Kaaris")
enemies = [enemy1, enemy2]

#Etats des joueurs
puts "Voici l'état des joueurs"
user.show_state
enemies.each do |enemy|
  enemy.show_state
end

# Boucle de combat
while user.life_points > 0 && enemies.any? { |enemy| enemy.life_points > 0 }
  # Affichage de l'état du HumanPlayer
  user.show_state

  # Affichage du menu
  puts "\nQuelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "attaquer un joueur en vue :"
  enemies.each_with_index do |enemy, index|
    puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
  end

  # Lecture de l'action choisie par le joueur
  print "> "
  action = gets.chomp

  case action
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when /\d+/
    enemy_index = action.to_i
    if enemy_index >= 0 && enemy_index < enemies.length
      enemy = enemies[enemy_index]
      user.attacks(enemy)
    else
      puts "Choix invalide. Veuillez réessayer."
    end
  else
    puts "Choix invalide. Veuillez réessayer."
  end

  # Les ennemis attaquent le joueur
  puts "Les autres joueurs t'attaquent !"
  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end

  # Suppression des ennemis morts du tableau
  enemies.delete_if { |enemy| enemy.life_points <= 0 }
end

# Fin du jeu
puts "La partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end


binding.pry