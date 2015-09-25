require_relative 'entities'

module Bloxx


  class ChestMinecart < Entity
    # almost exactly duplicates the chest block except subclassed from Entity.
    # TODO: share implemnattion used a shared module
    def initialize
      super('chest_minecart')
      self << (@items = SlottedItems.new)
    end

    def slot; @items end

    private

    class SlottedItem < Compound
      def initialize(slot, item)
        super(item) # add the item as an aspect
        self['Slot'] = slot
      end

      def to_nbt
        empty? ? '' : "#{@s.reject(&:empty?).map(&:to_nbt).reject(&:empty?).join(',')}"
      end
    end

    class SlottedItems < Aspect
      def initialize; @items = List.new; super(Items: @items) end

      def[]=(slot, item) @items[slot] = SlottedItem.new(slot, item) end
    end
  end

  class CommandMinecart < Entity
    def initialize
      super('command_block_minecart')
    end
  end

  class FurnaceMinecart < Entity
    def initialize
      super('furnace_minecart')
    end
  end

  class HopperMinecart < Entity
    # almost exactly duplicates the chest block except subclassed from Entity.
    # TODO: share implemnattion used a shared module
    def initialize
      super('hopper_minecart')
      self << (@items = SlottedItems.new)
    end

    def slot; @items end

    private

    class SlottedItem < Compound
      def initialize(slot, item)
        super(item) # add the item as an aspect
        self['Slot'] = slot
      end

      def to_nbt
        empty? ? '' : "#{@s.reject(&:empty?).map(&:to_nbt).reject(&:empty?).join(',')}"
      end
    end

    class SlottedItems < Aspect
      def initialize; @items = List.new; super(Items: @items) end

      def[]=(slot, item) @items[slot] = SlottedItem.new(slot, item) end
    end

  end

  class Minecart < Entity
    def initialize
      super('minecart')
    end
  end

  class TntMinecart < Entity
    def initialize
      super('tnt_minecart')
    end
  end

  class SpawnerMinecart < Entity
    def initialize
      super('spawner_minecart')
    end
  end


end