require_relative 'item'


module Bloxx


  class PotionItem < EffectItem
    def level; bits(self.subtype, 5..5) + 1 end
    def level=(v) self.subtype = bitset(self.subtype, 5..5, v - 1) end
    def normal; self.subtype = bitset(self.subtype, 6..6, 0) end
    def extended; self.subtype = bitset(self.subtype, 6..6, 1) end
    def extended?; bits(self.subtype, 6..6) == 1 end

    def effect; bits(self.subtype, 0..3) end
    def effect=(v); self.subtype = bitset(self.subtype, 0..3, v) end

    TYPE = {
        regeneration:     1,
        swiftness:        2,
        fire_resistance:  3,
        poison:           4,
        health:           5,
        night_vision:     6,
        weakness:         8,
        strength:         9,
        slowness:        10,
        leaping:         11,
        harming:         12,
        water_breathing: 13,
        invisibility:    14,
    }
  end

  class Potion < PotionItem
    def initialize; super(373, 1 << 13) end
  end

  class LingeringPotion < PotionItem
    def initialize; super(441, 0) end
  end

  class SplashPotion < PotionItem
    def initialize; super(373, 1 << 14) end
  end


end
