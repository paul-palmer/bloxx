require_relative 'base'

module Bloxx

  class Item < Compound
    def initialize(type, subtype = nil)
      @type, @subtype, @disp, @attrs, @modifiers = type, subtype, Display.new, Attributes.new, Modifiers.new
      @hideflags = [0] * 6
      super(@disp, @attrs, @modifiers)
    end

    attr_reader :type, :subtype

    extend Forwardable
    def_delegators :@disp, :color, :color=, :lore, :lore=, :name, :name=

    def unbreakable?;   self['Unbreakable'] == 1 end
    def unbreakable;    self['Unbreakable'] = 1 end
    def breakable;      self.delete('Unbreakable') end

    def hide_enchantments;  hide(0) end
    def show_enchantments;  show(0) end
    def hide_modifiers;     hide(1) end
    def show_modifiers;     show(1) end
    def hide_unbreakable;   hide(2) end
    def show_unbreakable;   show(2) end
    def hide_candestroy;    hide(3) end
    def show_candestroy;    show(3) end
    def hide_canplaceon;    hide(4) end
    def show_canplaceon;    show(4) end
    def hide_others;        hide(5) end
    def show_others;        show(5) end

    def subtype;    @subtype end
    def subtype=(v) @subtype = v end

    def attrs;      @attrs end
    def modifiers;  @modifiers end

    private

    def hide(n) @hideflags[n] = 1; hideflags! end
    def show(n) @hideflags[n] = 0; hideflags! end
    def hideflags!; self['HideFlags'] = @hideflags.reverse.inject(0){|f, b| f << 1 | b} end

    class Attributes < Aspect
      def initialize; @attrs = List.new; super(Attributes: @attrs) end
      def<<(a)        @attrs << a end
      def empty?;     @attrs.empty? end
    end

    class Display < Aspect
      def initialize; @display = Internal.new; super(display: @display) end

      extend Forwardable
      def_delegators :@display, :color, :color=, :lore, :lore=, :name, :name=, :empty?

      class Internal < Compound
        def color;    self['color'] end
        def color=(v) self['color'] = v end
        def lore;     self['Lore'] end
        def lore=(v)  self['Lore'] = cast2raw(v) end
        def name;     self['Name'] end
        def name=(v)  self['Name'] = SafeString.new(v) end
      end
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
      raise 'BlockItem requires a block' unless Block === block

      super(block.type)
      self['BlockEntityTag'] = @block = block
    end

    ###
    ### I would have preferred a design in which blocks could be automatically
    ### promoted to items, but Minecraft doesn't maintain a clear inheritance
    ### in these situations. The existing block data is split across two levels
    ### during the conversion. Some, such as the display data (name, et al.)
    ### move to the same level in the item. Others, such as chest items move down
    ### a level into TileEntityData. This is an awkward design to manage.
    ###

    def empty?;       super && @block.empty? end
    def field_names;  super - ['BlockEntityTag'] end


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
