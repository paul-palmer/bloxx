require 'uuidtools'
include UUIDTools

require_relative 'base'

module Bloxx

  class Attribute < Compound
    def initialize(name = nil, base = 1)
      super()

      self.name = name unless name.nil?
      self.base = base unless base.nil?
    end

    def name;     self['Name'] end
    def base;     self['Base'] end
    def base=(v)  self['Base'] = v end

    private

    def name=(v)  self['Name'] = v end
  end

  class AttackDamage < Attribute
    def initialize(base = 2.0) super('generic.attackDamage', base) end
  end

  class FollowRange < Attribute
    def initialize(base = 32.0) super('generic.followRange', base) end
  end

  class JumpStrength < Attribute # only applies to horses
    def initialize(base = 0.7) super('horse.jumpStrength', base) end
  end

  class KnockbackResistance < Attribute
    def initialize(base_percent = 0) super('generic.knockbackResistance', base_percent / 100) end
  end

  class MaxHealth < Attribute
    def initialize(base = 20.0) super('generic.maxHealth', base) end
  end

  class MovementSpeed < Attribute
    def initialize(base = 0.7) super('generic.movementSpeed', base) end
  end

  class SpawnReinforcements < Attribute # only applies to zombies
    def initialize(base = 0.0) super('zombie.spawnReinforcements', base) end
  end

  # coming in 1.9

  class ArmorValue < Attribute
    def initialize(base = 0.0) super('generic.armor', base) end # range -> 0.0..30.0
  end

  class AttackSpeed < Attribute
    def initialize(base = 4.0) super('generic.attackSpeed', base) end # range -> 0.0..1024.0
  end


end