require_relative 'item'

class DiamondShovel < EnchantableItem
  def initialize; super('diamond_shovel') end
end

class GoldenShovel < EnchantableItem
  def initialize; super('golden_shovel') end
end

class IronShovel < EnchantableItem
  def initialize; super('iron_shovel') end
end

class StoneShovel < EnchantableItem
  def initialize; super('stone_shovel') end
end

class WoodenShovel < EnchantableItem
  def initialize; super('wooden_shovel') end
end