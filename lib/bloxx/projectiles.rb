require_relative 'entity'


module Bloxx


  class Fireball < Entity
    def initialize
      super('Fireball')
      self.power = 1 # 0-127
    end

    def power=(v) self['ExplosionPower'] = v.to_i end
  end

  class FireworksRocket < Entity
    def initialize
      super('FireworksRocketEntity')
    end

    def lifetime=(v)  self['LifeTime'] = v end
    def fireworks=(v) self['FireworksItem'] = Items.new(v) end
  end


end