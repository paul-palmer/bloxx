require_relative 'base'

module Bloxx

  class Item < Compound
    def initialize(type, subtype = nil)
      @type, @subtype, @disp, @attrs, @modifiers = type, subtype, Display.new, Attributes.new, Modifiers.new
      super(@disp, @attrs, @modifiers)
    end

    attr_reader :type, :subtype

    def unbreakable?;   self['Unbreakable'] == 1 end
    def unbreakable;    self['Unbreakable'] = 1 end
    def breakable;      self.delete('Unbreakable') end

    def hide_enchantments;  hide(0) end
    def show_enchantments;  show(0) end
    def hide_attributes;    hide(1) end
    def show_attributes;    show(1) end
    def hide_unbreakable;   hide(2) end
    def show_unbreakable;   show(2) end
    def hide_candestroy;    hide(3) end
    def show_candestroy;    show(3) end
    def hide_canplaceon;    hide(4) end
    def show_canplaceon;    show(4) end
    def hide_others;        hide(5) end
    def show_others;        show(5) end

    def age;              self['Age'] end
    def age=(v)           self['Age'] = v end
    def health;           self['Health'] end
    def health=(v)        self['Health'] = v end
    def pickup_delay;     self['PickupDelay'] end
    def pickup_delay=(v)  self['PickupDelay'] = v end
    def owner;            self['Owner'] end
    def owner=(v)         self['Owner'] = v end
    def color;    @disp.lore end
    def color=(v) @disp.lore = v end
    def lore;     @disp.lore end
    def lore=(v)  @disp.lore = v end
    def name;     @disp.name end
    def name=(v)  @disp.name = v end

    def subtype;    @subtype end
    def subtype=(v) @subtype = v end

    def attrs;      @attrs end
    def modifiers;  @modifiers end

    private

    def hide(n) self['HideFlags'] = (self['HideFlags'] || 0) | (1 << n) end
    def show(n) self['HideFlags'] = (self['HideFlags'] || 0) & ~(1 << n) end

    class Attributes < Aspect
      def initialize; @attrs = List.new; super(Attributes: @attrs) end
      def<<(a)        @attrs << a end
      def empty?;     @attrs.empty? end
    end

    class Display < Aspect
      def initialize; @display = Compound.new; super(display: @display) end

      def color;    @display['color'] end
      def color=(v) @display['color'] = v end
      def lore;     @display['Lore'] end
      def lore=(v)  @display['Lore'] = Text.new(v) end
      def name;     @display['Name'] end
      def name=(v)  @display['Name'] = SafeString.new(v) end

      def empty?;   @display.empty? end
    end

    class Modifiers < Aspect
      def initialize; @mods = List.new; super(AttributeModifiers: @mods) end
      def<<(a)        @mods << a end
      def empty?;     @mods.empty? end
    end

  end

  class Items < Compound
    def initialize(item, count = 1, damage = nil)
      super()
      @item = item
      self['id'] = item.type
      self['tag'] = item
      self.count = count unless ((count || 0) == 0)
      self.damage = damage unless damage.nil?
    end

    def count;      self['Count'] end # item cannot be picked up if count has not been set
    def count=(v)   self['Count'] = v end

    def damage;     self['Damage'] end
    def damage=(v)  self['Damage'] = v end
  end


  class EffectItem < Item
    def initialize(type, subtype = nil)
      super
      self << (@effects = Effects.new)
    end

    def effects; @effects end

    class Effects < Aspect
      def initialize; @effects = List.new; super(CustomPotionEffects: @effects) end
      def<<(e)        @effects << e end
      def empty?;     @effects.empty? end
    end
  end

  class EnchantableItem < Item
    def initialize(type, subtype = nil)
      super
      self << (@ench = Enchantments.new)
    end

    def enchantments; @ench end

    class Enchantments < Aspect
      def initialize; @effects = List.new; super(ench: @effects) end
      def<<(e)        @effects << e end
      def empty?;     @effects.empty? end
    end
  end

  ###
  ### BlockItem is used when a block is held and acts as an item
  ###
  class BlockItem < Item
    def initialize(block)
      super(block.type)
      self['BlockEntityTag'] = @block = block
    end

    def to_nbt; super end

    def method_missing(meth, *args, &block)
      if @block.respond_to?(meth)
        self.class.class_eval <<-end_eval
          def #{meth}(*args, &block)
            @block.__send__(:#{meth}, *args, &block)
          end
        end_eval
        __send__(meth, *args, &block)
      else
        super # NoMethodError
      end
    end
  end



end
