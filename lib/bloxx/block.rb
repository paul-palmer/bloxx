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
  end


  module NameableBlock
    extend Forwardable

    def_delegators :@__nameableblock, :color, :color=, :name, :name=, :lore, :lore=

    def initialize(*args, &block)
      super *args, &block
      self << (@__nameableblock = NameableBlock__Display.new)
    end

    class NameableBlock__Display < Aspect
      def initialize; @display = Compound.new; super(display: @display) end

      def lore;     @display['Lore'] end
      def lore=(v)  @display['Lore'] = Text.new(v) end
      def name;     @display['Name'] end
      def name=(v)  @display['Name'] = SafeString.new(v) end

      def empty?;   @display.empty? end
    end
  end


  module LockableBlock
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
