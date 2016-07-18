require 'weapon'

class BattleBot

  attr_reader :name, :health, :enemies, :weapon , :count

  def initialize(name, health=100)
    raise(ArgumentError) unless name.is_a?(String)
    @name = name
    @health = health
    @enemies = []
    @weapon = nil
    @@count += 1
  end


  def self.count
    @@count
  end

  def dead?
    @health == 0
  end

  def has_weapon?
    @weapon != nil
  end

  def pick_up(weapon)
    raise(ArgumentError) if weapon.class != Weapon
    raise ArgumentError if weapon.bot != nil

    @enemies.each { |enemy| return @weapon if enemy.weapon == weapon }


    if @weapon == nil
      @weapon = weapon
      @weapon.bot = self
    else
      return nil
    end

    @weapon
  end

  def take_damage(amt)
    raise ArgumentError unless amt.class == Fixnum

    if (@health -= amt) < 0
      @health = 0
      @@count -= 1
    else
      @health -= 0
    end
    @health
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def heal
    if dead?
      return @health
    elsif @health < 90
      @health += 10
    else
      @health = 100
    end

  end

  def receive_attack_from(enemy)
    raise(ArgumentError) unless enemy.is_a?(BattleBot)
    raise(ArgumentError) if enemy.weapon == nil
    raise(ArgumentError) if enemy == self

    take_damage(enemy.weapon.damage)
    self.defend_against(enemy) unless enemy.dead?

    @enemies << enemy unless @enemies.include? (enemy)
  end

  def attack(enemy)
    raise(ArgumentError) unless enemy.class == BattleBot
    raise(ArgumentError) if @weapon == nil
    raise(ArgumentError)if enemy == self
    enemy.receive_attack_from(self) if weapon != nil
  end


  def defend_against(enemy)
    attack(enemy)  if !dead? && has_weapon?
  end

end