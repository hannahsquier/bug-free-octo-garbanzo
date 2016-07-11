require 'weapon'

class BattleBot
    
  attr_reader :name, :health, :enemies, :weapon , :count 

  def initialize(name, health=100)
    @name = name
    raise(ArgumentError) unless @name.is_a?(String)
    @health = health
    @enemies = []
    @weapon = nil
    @count ||= 0
    @count += 1
  end

  def dead?
    @health <= 0
  end

  def has_weapon?
    return false unless @weapon
    true
  end

  def pick_up(weapon)
    raise(ArgumentError) unless weapon.is_a?(Weapon)
    
    enemies.each do |enemy|
      if enemy.weapon == weapon
        return @weapon
      end
    end

    if @weapon == nil
      @weapon = weapon
    else 
      @weapon = nil
    end
  end

  def take_damage(amt)
    @health -= amt
  end

  def drop_weapon
    @weapon = nil
  end

  def heal
    if dead?
      return @health
    elsif (@health += 10) < 100
      @health += 10
    else
      @health = 100
    end

  end

  def receive_attack_from(enemy)
    raise(ArgumentError) unless enemy.is_a?(BattleBot)
    raise(ArgumentError) if enemy.weapon == nil
    raise(ArgumentError) if enemy == self
    enemies << enemy
  end

  def attack
    raise(ArgumentError) if @weapon == nil
    @health -= @weapon.damage
  end

  def defend_against(enemy)
    if !dead? && has_weapon?
      enemy.attack
    end
  end



end