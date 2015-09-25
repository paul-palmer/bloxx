require_relative 'entity'


module Bloxx

  class EntityHorse < Entity
    include Breedable
    include Tameable

    def initialize(type = 0)
      super('EntityHorse')
      self['Type'] = type
    end

    def tamed!;    self['Tame'] = 1 end
    def untamed!;  delete('Tame') end
    def tamed?;    self['Tame'] == 1 end

    # temper -> 0..100 increases w/ feeding. Higher numbers make horse easier to tame
    def temper;     self['Temper'] = 1 end
    def temper=(v)  self['Temper'] = Items.new(v) end

    # SaddleItem:{id: 329, Count: 1}

    def armor;      self['ArmorItem'] end
    def armor=(v)   self['ArmorItem'] = Items.new(v) end

    def chest;      self['Items'] end
    def chest=(v)   self['Items'] = Items.new(v) end

    def saddle;     self['SaddleItem'] end
    def saddle=(v)  self['Saddle'] = 1; self['SaddleItem'] = Items.new(v) end

    def eating!;    self['EatingHaystack'] = 1 end
    def not_eating!;delete('EatingHaystack') end
    def eating?;    self['EatingHaystack'] == 1 end
    end


  class Horse < EntityHorse
    def white_base!;     set_base(0) end
    def creamy_base!;    set_base(1) end
    def chestnut_base!;  set_base(2) end
    def brown_base!;     set_base(3) end
    def black_base!;     set_base(4) end
    def gray_base!;      set_base(5) end
    def darkbrown_base!; set_base(6) end

    def no_markings!;    set_other(0) end
    def white_markings!; set_other(1) end
    def with_whitefield!;set_other(2) end
    def with_whitedots!; set_other(3) end
    def with_blackdots!; set_other(4) end

    private

    def set_base(v)  self['Variant'] = ((self['Variant'] || 0) & ~0x0f) + v end
    def set_other(v) self['Variant'] = ((self['Variant'] || 0) & ~0xf00) + (v << 8) end
  end

  class EntityDonky < EntityHorse
    def initialize(type)
      super(type)
    end
  end

  class Donkey < EntityDonky
    def initialize
      super(1)
    end
  end

  class Mule < EntityDonky
    def initialize
      super(2)
    end
  end

  class SkeletonHorse < EntityHorse
    def initialize
      super(4)
    end
  end

  class ZombieHorse < EntityHorse
    def initialize
      super(3)
    end
  end


end
