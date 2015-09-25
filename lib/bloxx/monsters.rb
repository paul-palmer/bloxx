require_relative 'entity'


module Bloxx

  class Blaze < Entity
    def initialize
      super('Blaze')
    end
  end

  class CaveSpider < Entity
    def initialize
      super('CaveSpider')
    end
  end

  class Creeper < Entity
    def initialize
      super('Creeper')
    end

    def ignitied!;     self['ignited'] = 1 end
    def not_ignitied!; delete('ignited') end
    def ignitied?;     self['ignited'] == 1 end

    def powered!;      self['powered'] = 1 end
    def not_powered!;  delete('powered') end
    def powered?;      self['powered'] == 1 end

    def explosion_radius;   self['ExplosionRadius'] end
    def explosion_radius=(v)self['ExplosionRadius'] = v.to_i end
    def fuse;               self['Fuse'] end
    def fuse=(v)            self['Fuse'] = v.to_i end
  end

  class EnderDragon < Entity
    def initialize
      super('EnderDragon')
    end
  end

  class Enderman < Entity
    def initialize
      super('Enderman')
    end
  end

  class Endermite < Entity
    def initialize
      super('Endermite')
    end
  end

  class Ghast < Entity
    def initialize
      super('Ghast')
    end
  end

  class Guardian < Entity
    def initialize
      super('Guardian')
    end
  end

  class MagmaCube < Entity
    def initialize
      super('LavaSlime')
      self.size = 1 # 0-127
    end

    def size=(v) self['Size'] = v.to_i end
  end

  class PigZombie < Entity
    def initialize
      super('PigZombie')
    end
  end

  class Silverfish < Entity
    def initialize
      super('Silverfish')
    end
  end

  class Slime < Entity
    def initialize
      super('Slime')
      self.size = 1 # 0-127
    end

    def size=(v) self['Size'] = v.to_i end
  end

  class Skeleton < Entity
    def initialize
      super('Skeleton')
      self << (@equip = Equipment.new)
    end

    def equipment; @equip end
  end

  class Spider < Entity
    def initialize
      super('Silverfish')
    end
  end

  class Witch < Entity
    def initialize
      super('Witch')
    end
  end

  class WitherBoss < Entity
    def initialize
      super('WitherBoss')
    end

    def invulnerable_ticks;     self['Invul'] end
    def invulnerable_ticks=(v); self['Invul'] = v end
  end

  class Zombie < Entity
    def initialize
      super('Zombie')
    end
  end


  # Subclassed Monsters

  class ElderGuardian < Guardian
    def initialize
      super
      self['Elder'] = 1
    end
  end

  class WitherSkeleton < Skeleton
    def initialize
      super
      self['SkeletonType'] = 1
    end
  end



end