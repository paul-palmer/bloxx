require_relative 'entity'


module Bloxx


  class Ocelot < Entity
    include Breedable
    include Tameable

    def initialize(cat_type = 0)
      super('Ozelot')
      self.cat_type = cat_type
    end

    def cat_type;      self['CatType'] end

    protected

    def cat_type=(v)   self['CatType'] = v end
  end

  class CatEntity < Ocelot
    def initialize(cat_type)
      super(cat_type)
    end
  end

  class SiameseCat < CatEntity
    def initialize
      super(3)
    end
  end

  class TabbyCat < CatEntity
    def initialize
      super(2)
    end
  end

  class TuxedoCat < CatEntity
    def initialize
      super(1)
    end
  end


end