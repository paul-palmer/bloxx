require_relative 'item'


module Bloxx

  class DiamondPickaxe < EnchantableItem
    def initialize; super('diamond_pickaxe') end
  end

  class GoldenPickaxe < EnchantableItem
    def initialize; super('golden_pickaxe') end
  end

  class IronPickaxe < EnchantableItem
    def initialize; super('iron_pickaxe') end
  end

  class StonePickaxe < EnchantableItem
    def initialize; super('stone_pickaxe') end
  end

  class WoodenPickaxe < EnchantableItem
    def initialize; super('wooden_pickaxe') end
  end

end
