require_relative 'base'

module Bloxx


  class Entity < Compound
    def initialize(type)
      @type = type
      super((@effects = Effects.new), (@attrs = Attributes.new), (@riding = Riding.new))
    end

    def name=(v)  self['CustomName'] = v end

    def always_show_name; self['CustomNameVisible'] = 1 end
    def persistant;     self['PersistenceRequired'] = 1 end
    def angry;          self['Angry'] = 1 end
    def invulnerable;   self['Invulnerable'] = 1 end
    def silent;         self['Silent'] = 1 end
    def glowing;        self['Glowing'] = 1 end
    def no_AI;           self['NoAI'] = 1 end
    def can_pickup_loot;self['CanPickUpLoot'] = 1 end

    def fire;           self['Fire'] end # how many ticks the MOB will continue to be on fire
    def fire=(v)        self['Fire'] = v end

    def healrate;       self['AbsorptionAmount'] end
    def healrate=(v)    self['AbsorptionAmount'] = v end

    def riding;         @riding.proxy.entity end
    def riding=(v)      @riding.proxy.entity = v end

    def direction(x, y, z) self['Motion'] = List.new(x / 1.0, y / 1.0, z / 1.0) end

    def type;           @type end

    def attrs;          @attrs end
    def effects;        @effects end

    protected

    class Attributes < Aspect
      def initialize; @attrs = List.new; super(Attributes: @attrs) end
      def<<(a)        @attrs << a end
      def empty?;     @attrs.empty? end
    end

    class Effects < Aspect
      def initialize; @effects = List.new; super(ActiveEffects: @effects) end
      def<<(e)        @effects << e end
      def empty?;     @effects.empty? end
    end

    class Riding < Aspect
      attr_accessor :proxy

      def initialize; super(Riding: (@proxy = Proxy.new)) end
      def empty?;     @proxy.empty? end

      class Proxy
        attr_accessor :entity

        def empty?; @entity.nil? end
        def to_nbt; @entity.to_nbt.sub('{', %<{id="#{@entity.type}",>) end
        def to_s;   to_nbt end
      end
    end

    class Equipment < Compound
    end
  end

  module Entity_Breedable
    def age;              self['Age'] end
    def age(v)            self['Age'] = v end
    def forced_age;       self['ForcedAge'] end
    def forced_age(v)     self['ForcedAge'] = v end
    def in_love;          self['InLove'] end
    def in_love=(v)       self['InLove'] = v end
  end

  module Entity_Tameable
    def owner_uuid;       self['OwnerUUID'] end
    def owner_uuid=(v)    self['OwnerUUID'] = v end
    def sit;              self['Sitting'] = 1 end
    def stand;            delete('Sitting') end
    def sitting?(v)       self['Sitting'] == 1 end
  end

end
