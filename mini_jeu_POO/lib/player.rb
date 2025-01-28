class Player 
  attr_accessor :name, :life_points
  
  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{name} a #{life_points}pts de vie"
  end

  
  def attacks(player)
    puts "#{name} attaque #{player.name}"
    damage = compute_damage
    puts "-#{damage}pts de vie pour #{player.name}"
    player.gets_damage(damage)
  end
  
  def gets_damage(damage_received)
    @life_points -= damage_received
    if @life_points <=0 
      puts "#{name} a été tué !"
    end
  end

  def compute_damage
    return rand(1..6)
  end

end

class Humanplayer < Player
  attr_accessor :weapon_level
  
  def initialize(name)
    @weapon_level = 1
    @life_points = 100
    super(name)
  end
  
  def show_state
    puts "#{@name} a #{@life_points}pts de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level < @weapon_level
      @weapon_level = new_weapon_level
      puts "Enjoy !"
    else
      puts "Cette arme est à chier !"
    end
  end

  def search_health_pack
    new_pack = rand(1..6) 
    case 
    when 1
      puts "Tu n'as rien trouvé !"
    when 2..5
      @life_points = [@life_points + 50, 100].min
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    when 6
      @life_points = [@life_points + 80, 100].min
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end
