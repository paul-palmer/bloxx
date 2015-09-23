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

  class AttackSpeed < Attribute # 1.9
    def initialize(base = 4.0) super('generic.attackSpeed', base) end
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

  class AttributeModifier < Compound
    def initialize(attr, name, operation, amount)
      super()

      self.attr = attr unless attr.nil?
      self.name = name unless name.nil?
      self.operation = operation unless operation.nil?
      self.amount = amount unless amount.nil?
      self.uuid = ::UUID.random_create.to_s
    end

    def attr;         self['AttributeName'] end
    def name;         self['Name'] end
    def name=(v)      self['Name'] = v.to_s end
    def amount;       self['Amount'] end
    def amount=(v)    self['Amount'] = v.to_f end
    def operation;    self['Operation'] end
    def operation=(v) self['Operation'] = OP[v] end
    def uuid;         UUID.parse_int(self['UUIDMost'] << 64 | self['UUIDLeast']).to_s end
    def uuid=(v)
      id = UUID.parse(v).to_i
      self['UUIDMost'] = id >> 64
      self['UUIDLeast'] = id & ((1 << 64) - 1)
    end

    private

    def attr=(v)  self['AttributeName'] = v.to_s end

    OP = {
        add: 0,
        multiply: 1,
        percent_adjust: 2,
    }
  end

  class AttackDamageModifier < AttributeModifier
    def initialize(operation, amount) super('generic.attackDamage', 'generic.attackDamage', operation, amount) end
  end

  class KnockbackResistanceModifier < AttributeModifier
    def initialize(operation, amount) super('generic.knockbackResistance', 'generic.knockbackResistance', operation, amount) end
  end

  class MovementSpeedModifier < AttributeModifier
    def initialize(operation, amount) super('generic.movementSpeed', 'generic.movementSpeed', operation, amount) end
  end



=begin
/give @a bedrock 1 0 {
	AttributeModifiers:[
		{
			AttributeName:generic.knockbackResistance,
			Name:generic.knockbackResistance,
			Amount:1,
			Operation:0,
			UUIDMost:10,
			UUIDLeast:10
		}
	]
}

=end


end