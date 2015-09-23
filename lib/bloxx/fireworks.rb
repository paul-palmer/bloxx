require_relative 'item'

module Bloxx


  class FireworkStar < Item
    def initialize
      super('firework_charge')
      self << (@exp = Explosion.new)
    end

    def small_ball;     @exp.small_ball end
    def large_ball;     @exp.large_ball end
    def star;           @exp.star end
    def creeper;        @exp.creeper end
    def burst;          @exp.burst end

    def colors;         @exp.colors end
    def fade_colors;    @exp.fade_colors end

    def set_twinkle;    @exp.set_twinkle end
    def clear_twinkle;  @exp.clear_twinkle end
    def twinkle?;       @exp.twinkle? end

    def set_trail;      @exp.set_trail end
    def clear_trail;    @exp.clear_trail end
    def trail?;         @exp.trail? end

    def get_explosion;  @exp.get_explosion end

    private

    class Explosion < Aspect
      def initialize; @expl = Struct.new; super(Explosion: @expl) end

      def small_ball;     @expl.delete('Type') end
      def large_ball;     @expl['Type'] = 1 end
      def star;           @expl['Type'] = 2 end
      def creeper;        @expl['Type'] = 3 end
      def burst;          @expl['Type'] = 4 end

      def set_twinkle;    @expl['Flicker'] = 1 end
      def clear_twinkle;  @expl.delete('Flicker') end
      def twinkle?;       @expl['Flicker'] == 1 end

      def set_trail;      @expl['Trail'] = 1 end
      def clear_trail;    @expl.delete('Trail') end
      def trail?;         @expl['Trail'] == 1 end

      def colors;         @expl['Colors'] ||= List.new end
      def fade_colors;    @expl['FadeColors'] ||= List.new end

      def empty?;         @expl.empty? end

      def get_explosion;  @expl end
    end

  end

  class Fireworks < Item
    def initialize
      super(401)
      self << (@fw = FW.new)
    end

    def charges; @fw end

    class FW < Aspect
      def initialize; @expl = Explosions.new; super(Fireworks: @expl) end

      def<<(c) @expl << c.get_explosion end

      class Explosions < Struct
        def initialize
          super
          self['Explosions'] = List.new
        end

        def<<(c) self['Explosions'] << c end
      end

    end

  end


end
