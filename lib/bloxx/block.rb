require 'forwardable'

require_relative 'base'

module Bloxx


  class Block < Compound
    def initialize(type, subtype = nil)
      @type, @subtype = type, subtype
      super()
    end

    def tile_entity;         self['TileEntityData'] end
    def tile_entity=(v)      self['TileEntityData'] = v end

    def type;           @type end
    def subtype;        @subtype end

    protected

    module Nameable
      extend Forwardable

      def_delegators :@__nameableblock, :name, :name=, :lore, :lore=

      def initialize(*args, &block)
        super *args, &block
        self << (@__nameableblock = NameableBlock__Display.new)
      end

      class NameableBlock__Display < Aspect
        def initialize; @display = Internal.new; super(display: @display) end

        extend Forwardable
        def_delegators :@display, :lore, :lore=, :name, :name=, :empty?

        class Internal < Compound
          def lore;     self['Lore'] end
          def lore=(v)  self['Lore'] = cast2raw(v) end
          def name;     self['Name'] end
          def name=(v)  self['Name'] = SafeString.new(v) end
        end
      end

    end

    module Lockable
      extend Forwardable

      def_delegators :@__lockableblock, :lock, :lock=

      def initialize(*args, &block)
        super *args, &block
        self << (@__lockableblock = LockableBlock__Key.new)
      end

      class LockableBlock__Key < Aspect
        def lock(key) self['Lock'] = (key.name rescue key.to_s) end
        def unlock;   self.delete('Lock') end
        def locked?;  !self['Lock'].nil? end
      end
    end

  end




  def self.simple_block(hsh)
    hsh.each do |classname, type|

      klass = Class.new(Block) do
        define_method(:initialize) {super(type)}
      end

      self.const_set(classname, klass)
    end
  end

  def self.subtyped_block(hsh)
    hsh.each do |classname, type|

      klass = Class.new(Block) do
        define_method(:initialize) do |subtype|
          super(type)
          @subtype = subtype
        end
      end

      self.const_set(classname, klass)
    end
  end

end
