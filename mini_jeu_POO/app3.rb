require 'bundler'
Bundler.require

require_relative './lib/game'

# Fonction pour demander le prénom de l'utilisateur
def ask_for_name
  loop do
    puts "Quel est ton prénom ?"
    print "> "
    user_name = gets.chomp
    if user_name.strip.empty?
      puts "Rentres ton prénom, si t'as les balls !"
    else
      return user_name
    end
  end
end

# Accueil
puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

# Initialisation du jeu
user_name = ask_for_name
game = Game.new(user_name)

# Boucle de combat
while game.is_still_ongoing?
  gets.chomp
  game.new_players_in_sight
  puts "\e[4mFais entrer pour continuer...\e[0m"
  gets.chomp
  game.show_players
  puts ""
  puts "\e[4mFais entrer pour continuer...\e[0m"
  gets.chomp
  game.menu
  print "> "
  choice = gets.chomp
  game.menu_choice(choice)
  puts " " 
  game.enemies_attack
  puts " "
  puts "\e[4mFais entrer pour continuer...\e[0m"
  gets.chomp
end

# Fin du jeu
game.end

# Utilisation de PRY pour vérifier l'état final
require 'pry'
binding.pry
