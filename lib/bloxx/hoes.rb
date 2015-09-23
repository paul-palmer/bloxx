require_relative 'item'


module Bloxx

  class DiamondHoe < EnchantableItem
    def initialize; super('diamond_hoe') end
  end

  class GoldenHoe < EnchantableItem
    def initialize; super('golden_hoe') end
  end

  class IronHoe < EnchantableItem
    def initialize; super('iron_hoe') end
  end

  class StoneHoe < EnchantableItem
    def initialize; super('stone_hoe') end
  end

  class WoodenHoe < EnchantableItem
    def initialize; super('wooden_hoe') end
  end

end