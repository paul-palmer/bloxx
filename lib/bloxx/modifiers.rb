require 'uuidtools'
include UUIDTools

require_relative 'base'

module Bloxx


  class AttributeModifier < Compound
    def initialize(attr, name, operation, amount)
      super()

      self.attr = %<"#{attr.to_s}"> unless attr.nil?
      self.name = %<"#{name.to_s}"> unless name.nil?
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
      id = UUID.parse(v.to_s).to_i
      self['UUIDMost'] = id >> 64
      self['UUIDLeast'] = id & ((1 << 64) - 1)
    end

    private

    def attr=(v)  self['AttributeName'] = v.to_s end

    OP = {
        add: 0,            # a value of 2.0 would set the attribute to 2.0
        multiply: 1,       # a value of 2.0 would double the attribute
        percent_adjust: 2, # a value of 2.0 would increase the attribute by 200% (triple it)
    }
  end

  class AttackDamageModifier < AttributeModifier
    def initialize(operation, amount) super('generic.attackDamage', 'generic.attackDamage', operation, amount) end
  end

  class FollowRangeModifier < AttributeModifier
    def initialize(operation, amount) super('generic.followRange', 'generic.followRange', operation, amount) end
  end

  class KnockbackResistanceModifier < AttributeModifier
    def initialize(operation, amount) super('generic.knockbackResistance', 'generic.knockbackResistance', operation, amount) end
  end

  class MaxHealthModifier < AttributeModifier
    def initialize(operation, amount) super('generic.maxHealth', 'generic.maxHealth', operation, amount) end
  end

  class MovementSpeedModifier < AttributeModifier
    def initialize(operation, amount) super('generic.movementSpeed', 'generic.movementSpeed', operation, amount) end
  end



  # coming in 1.9

  class GenericArmorModifier < AttributeModifier
    def initialize(operation, amount) super('generic.armor', 'generic.armor', operation, amount) end
  end

  class GenericAttackSpeedModifier < AttributeModifier
    def initialize(operation, amount) super('generic.attackSpeed', 'generic.attackSpeed', operation, amount) end
  end


end