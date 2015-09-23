require_relative 'entity'


module Bloxx

  class Creeper < Entity
    def initialize
      super('Creeper')
    end

    def powered;    self['powered'] = 1 end
    def unpowered;  delete('powered') end
    def powered?;   self['powered'] == 1 end

    def fuse=(v) self['Fuse'] = v end
    def explosionradius=(v) self['ExplosionRadius'] = v end
  end

  class EnderDragon < Entity
    def initialize
      super('EnderDragon')
    end
  end

  class Skeleton < Entity
    def initialize
      super('Skeleton')
      self << (@equip = Equipment.new)
    end

    def equipment; @equip end
  end

  class WitherSkeleton < Skeleton
    def initialize
      super
      self['SkeletonType'] = 1
    end
  end

  class WitherBoss < Entity
    def initialize
      super('WitherBoss')
    end

    def invulnerable_ticks;     self['Invul'] end
    def invulnerable_ticks=(v); self['Invul'] = v end
  end



end