require_relative 'base'

module Bloxx

  class Effect < Compound
    def initialize(id = nil, power = 1, duration = 30, particles = true)
      super()

      self.id    = id unless id.nil?
      self.power = power unless power.nil?
      self.duration = duration unless duration.nil?
      self.noparticles unless particles
    end

    def id;           self['Id'] end
    def id=(v)        self['Id'] = v end
    def duration;     self['Duration'] end
    def duration=(v)  self['Duration'] = v end # specified in ticks, 20 ticks/sec
    def level;        self['Amplifier'] end
    def level=(v)     self['Amplifier'] = v end
    def power;        self['Amplifier'] end
    def power=(v)     self['Amplifier'] = v end

    def ambient?;     self['Ambient'] == 1 end
    def ambient;      self['Ambient'] = 0 end
    def notambient;   self.delete('Ambient') end

    def particles?;   self['ShowParticles'] != 0 end
    def noparticles;  self['ShowParticles'] = 0 end
    def particles;    self.delete('ShowParticles') end

    TYPE = {
        speed:  1,
        slowness:  2,
        haste:  3,
        mining_fatigue:  4,
        strength: 5,
        healing:  6,
        harming:  7,
        leaping: 8,
        nausea: 9,
        regeneration: 10,
        resistance: 11,
        fireresist: 12,
        waterbreath: 13,
        invisibility: 14,
        blindness:  15,
        nightvision: 16,
        hunger: 17,
        weakness: 18,
        poison: 19,
        wither: 20,
        healthboost: 21,
        absorption: 22,
        saturation: 23,
        glowing: 24,
        levitation: 25,
    }
  end

  class Absorption < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:absorption], power, duration, particles) end
  end

  class Blindness < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:blindness], power, duration, particles) end
  end

  class FireResist < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:fireresist], power, duration, particles) end
  end

  class Glowing < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:glowing], power, duration, particles) end
  end

  class Harming < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:harming], power, duration, particles) end
  end

  class Haste < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:haste], power, duration, particles) end
  end

  class Healing < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:healing], power, duration, particles) end
  end

  class HealthBoost < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:healthboost], power, duration, particles) end
  end

  class Hunger < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:hunger], power, duration, particles) end
  end

  class Invisibility < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:invisibility], power, duration, particles) end
  end

  class Leaping < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:leaping], power, duration, particles) end
  end

  class Levitation < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:levitation], power, duration, particles) end
  end

  class MiningFatigue < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:mining_fatigue], power, duration, particles) end
  end

  class Nausea < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:nausea], power, duration, particles) end
  end

  class NightVision < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:nightvision], power, duration, particles) end
  end

  class Poison < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:poison], power, duration, particles) end
  end

  class Regeneration < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:regeneration], power, duration, particles) end
  end

  class Resistance < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:resistance], power, duration, particles) end
  end

  class Saturation < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:saturation], power, duration, particles) end
  end

  class Slowness < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:slowness], power, duration, particles) end
  end

  class Speed < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:speed], power, duration, particles) end
  end

  class Strength < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:strength], power, duration, particles) end
  end

  class WaterBreath < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:waterbreath], power, duration, particles) end
  end

  class Weakness < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:weakness], power, duration, particles) end
  end

  class Wither < Effect
    def initialize(power = 1, duration = nil, particles = true) super(TYPE[:wither], power, duration, particles) end
  end

end