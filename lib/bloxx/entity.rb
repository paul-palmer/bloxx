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

    # should the block drop its item form if it cannot be placed?
    def drop_item;      self['DropItem'] = 1 end
    def no_drop_item;   self['DropItem'] = 0 end

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


    module Breedable
      def age;              self['Age'] end
      def age=(v)           self['Age'] = v end
      def forced_age;       self['ForcedAge'] end
      def forced_age=(v)    self['ForcedAge'] = v end
      def in_love;          self['InLove'] end
      def in_love=(v)       self['InLove'] = v end
    end

    module Tameable
      def owner;            self['Owner'] end
      def owner=(v)         self['Owner'] = v end # pre 1.8 only
      def owner_uuid;       self['OwnerUUID'] end
      def owner_uuid=(v)    self['OwnerUUID'] = v end
      def sit!;             self['Sitting'] = 1 end
      def stand!;           delete('Sitting') end
      def sitting?;         self['Sitting'] == 1 end
    end

  end


  class DroppedEntity < Entity
    def age;              self['Age'] end             # ticks since entity dropped
    def age=(v)           self['Age'] = v end
    def health;           self['Health'] end          # defaults to 5. Entity destroyed when health reaches 0
    def health=(v)        self['Health'] = v end
  end


  class DroppedItem < DroppedEntity
    def initialize(item)
      super(item.type)
      self['Item'] = item
    end

    def pickup_delay;     self['PickupDelay'] end     # ticks until item can be picked up
    def pickup_delay=(v)  self['PickupDelay'] = v end
    def owner;            self['Owner'] end           # only named player can pickup item
    def owner=(v)         self['Owner'] = v end
    def thrower;          self['Thrower'] end         # name of player that dropped the item
    def thrower=(v)       self['Thrower'] = v end
  end


end
