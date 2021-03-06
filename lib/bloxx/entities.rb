require_relative 'entity'
require_relative 'cats'
require_relative 'horses'
require_relative 'minecarts'
require_relative 'monsters'
require_relative 'rabbits'



module Bloxx


  class Bat < Entity
    def initialize
      super('Bat')
    end
  end

  class FallingSand < Entity
    def initialize(block = nil, riding = nil)
      super('FallingSand')
      self.block = block unless block.nil?
      self.riding = riding unless riding.nil?
    end

    def block;          self['TileEntityData'] end
    def block=(v)       self['Block'] = v.type; self['TileEntityData'] = v;  end
    def time;           self['Time'] end
    def time=(v)        self['Time'] = v end
    def drop_item!;     self['DropItem'] end
    def dont_drop_item!;delete('DropItem') end
    def drop_item?;     self['DropItem'] == 1 end
  end

  class IronGolem < Entity
    def initialize
      super('VillagerGolem')
    end
  end

  class PrimedTNT < Entity
    def initialize
      super('PrimedTnt')
      self.fuse = 80 # ticks ~= 4 seconds
    end

    def fuse=(v) self['Fuse'] = v.to_i end
  end

  class Wolf < Entity
    include Breedable
    include Tameable

    def initialize
      super('Wolf')
    end

    def angry!;   self['Angry'] = 1 end
    def neutral!; delete('Angry') end
    def angry?;   self['Angry'] == 1 end

    def collar_color;     self['CollarColor'] end
    def collar_color=(v)  self['CollarColor'] = v end
  end

  class XPOrb < DroppedEntity
    def initialize(value = 1)
      super('XPOrb')
      self.value = value
    end

    def value;      self['Value'] end

    protected

    def value=(v)   self['Value'] = v end
  end


end