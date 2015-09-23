require_relative 'item'

module Bloxx

  class DiamondSword < EnchantableItem
    def initialize; super('diamond_sword') end
  end

  class GoldenSword < EnchantableItem
    def initialize; super('golden_sword') end
  end

  class IronSword < EnchantableItem
    def initialize; super('iron_sword') end
  end

  class StoneSword < EnchantableItem
    def initialize; super('stone_sword') end
  end

  class WoodenSword < EnchantableItem
    def initialize; super('wooden_sword') end
  end

end
