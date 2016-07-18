class Weapon
  attr_reader :name, :damage
  attr_accessor :weapon, :bot

  def initialize(name, damage=0)
    @name = name
    raise(ArgumentError) unless @name.is_a?(String)
    @damage = damage
    raise(ArgumentError) unless @damage.is_a?(Fixnum)
    @bot = nil
  end

  def picked_up?
    @bot != nil
  end

  def bot=(bot)
    raise ArgumentError unless bot.is_a?(BattleBot) || bot.nil?
    @bot = bot
  end

end