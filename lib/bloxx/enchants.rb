require_relative 'base'

module Bloxx

  class Enchantment < Compound
    def initialize(id = nil, lvl = nil)
      super()
      self.id    = id unless id.nil?
      self.level = lvl unless lvl.nil?
    end

    def id;       self['id'] end
    def id=(v)    self['id'] = v end
    def level;    self['lvl'] end
    def level=(v) self['lvl'] = v end

    TYPE = {
        protection: 0,
        fire_protection:  1,
        feather_falling:  2,
        blast_protection: 3,
        projectile_protection:  4,
        respiration:  5,
        aqua_affinity:  6,
        thorns: 7,
        depth_strider:  8,
        sharpness:  16,
        smite:  17,
        bane_of_arthropods: 18,
        knockback:  19,
        fire_aspect:  20,
        looting:  21,
        efficiency: 32,
        silk_touch: 33,
        unbreaking: 34,
        fortune:  35,
        power:  48,
        punch:  49,
        flame:  50,
        infinity: 51,
        luck_of_the_sea:  61,
        lure: 62,
    }
  end

  class AquaAffinity < Enchantment
    def initialize(lvl = nil) super(TYPE[:aqua_affinity], lvl) end
  end

  class DepthStrider < Enchantment
    def initialize(lvl = nil) super(TYPE[:depth_strider], lvl) end
  end

  class Efficiency < Enchantment
    def initialize(lvl = nil) super(TYPE[:efficiency], lvl) end
  end

  class FeatherFalling < Enchantment
    def initialize(lvl = nil) super(TYPE[:feather_falling], lvl) end
  end

  class FireProtection < Enchantment
    def initialize(lvl = nil) super(TYPE[:fire_protection], lvl) end
  end

  class Fortune < Enchantment
    def initialize(lvl = nil) super(TYPE[:fortune], lvl) end
  end

  class Infinity < Enchantment
    def initialize(lvl = nil) super(TYPE[:infinity], lvl) end
  end

  class Knockback < Enchantment
    def initialize(lvl = nil) super(TYPE[:knockback], lvl) end
  end

  class Looting < Enchantment
    def initialize(lvl = nil) super(TYPE[:looting], lvl) end
  end

  class Power < Enchantment
    def initialize(lvl = nil) super(TYPE[:power], lvl) end
  end

  class Protection < Enchantment
    def initialize(lvl = nil) super(TYPE[:protection], lvl) end
  end

  class Punch < Enchantment
    def initialize(lvl = nil) super(TYPE[:punch], lvl) end
  end

  class Respiration < Enchantment
    def initialize(lvl = nil) super(TYPE[:respiration], lvl) end
  end

  class Sharpness < Enchantment
    def initialize(lvl = nil) super(TYPE[:sharpness], lvl) end
  end

  class SilkTouch < Enchantment
    def initialize(lvl = nil) super(TYPE[:silk_touch], lvl) end
  end

  class Thorns < Enchantment
    def initialize(lvl = nil) super(TYPE[:thorns], lvl) end
  end

  class Unbreaking < Enchantment
    def initialize(lvl = nil) super(TYPE[:unbreaking], lvl) end
  end

end


