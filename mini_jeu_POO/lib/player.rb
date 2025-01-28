class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "- #{@name} a #{@life_points}pts de vie 💚"
  end

  def attacks(enemy)
    puts " "
    puts "#{@name} attaque #{enemy.name} 💥💥"
    damage = compute_damage
    puts ""
    puts ">>-#{damage}pts de vie pour #{enemy.name}  🤍🤍"
    enemy.gets_damage(damage)
  end

  def gets_damage(damage_received)
    @life_points -= damage_received
    if @life_points <= 0
      puts "💪   \e[1m#{@name} a été tué ! GG!\e[0m  💪"
    end
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @weapon_level = 1
    @life_points = 100
  end

  def show_state
    puts "- Tu as a #{@life_points}pts de vie ❤️  et une arme de niveau #{@weapon_level} ⚔️"
    puts " "
    if @life_points < 30
      puts "⚠️  ATTENTION, TU AS #{@life_points}pts de vie !!!   ⚠️ "
    end
  end 

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts " "
    puts " "
    puts "\e[1m🔫🔫   Tu as trouvé une arme de niveau #{new_weapon_level}  🔫🔫\e[0m"
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts "🔫🔫   ENJOOOOYYYY !   🔫🔫"
      puts " "
    else
      puts "\e[1m🔫🔫Cette arme est à chier !🔫🔫\e[0m"
    end
  end

  def attacks(enemy)
    puts " "
    puts "💥💥#{@name} attaque #{enemy.name}💥💥"
    damage = compute_damage
    puts " "
    gets.chomp
    puts "⚠️   -#{damage}pts de vie pour #{enemy.name}   ⚠️"
    puts " "
    enemy.gets_damage(damage)
  end

  def search_health_pack
    new_pack = rand(1..6)
    case new_pack
    when 1
      puts " "
      puts "Tu n'as rien trouvé !"
    when 2..5
      @life_points = [@life_points + 50, 100].min
      puts "Bravo, tu as trouvé un pack de +50 points de vie !⚕️"
    when 6
      @life_points = [@life_points + 80, 100].min
      puts "Waow, tu as trouvé un pack de +80 points de vie !⚕️"
    end
  end
end
