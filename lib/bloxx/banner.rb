require_relative 'block'
require_relative 'item'


module Bloxx

  class BannerBlock < Block
    def initialize(type)
      super(type)
      self << (@patterns = Patterns.new)
    end

    def base_color=(v) self['Base'] = v.closest_wool.wool_subtype end
    def patterns; @patterns end

    private

    class Patterns < Aspect
      def initialize; super(Patterns: (@pats = List.new)) end
      def<<(p)        @pats << p end
      def empty?;     @pats.empty? end
    end
  end

  class Banner < BlockItem
    def initialize
      super(BannerBlock.new('banner'))
    end
  end

  class StandingBanner < BannerBlock
    def initialize
      super('standing_banner')
    end
  end

  class WallBanner < BannerBlock
    def initialize
      super('wall_banner')
    end
  end

  class Pattern < Compound
    def initialize(type, color)
      super()
      self['Pattern'], self['Color'] = type, color.wool_subtype
    end
  end

  class BaseFess < Pattern; def initialize(color) super('bs', color) end end
  class ChiefFess < Pattern; def initialize(color) super('ts', color) end end
  class PaleDexter < Pattern; def initialize(color) super('ls', color) end end
  class PaleSinister < Pattern; def initialize(color) super('rs', color) end end

  class Pale < Pattern; def initialize(color) super('cs', color) end end
  class Fess < Pattern; def initialize(color) super('ms', color) end end
  class Bend < Pattern; def initialize(color) super('drs', color) end end
  class BendSinister < Pattern; def initialize(color) super('dls', color) end end

  class Paly < Pattern; def initialize(color) super('ss', color) end end
  class Saltire < Pattern; def initialize(color) super('cr', color) end end
  class Cross < Pattern; def initialize(color) super('sc', color) end end

  class PerBend < Pattern; def initialize(color) super('rud', color) end end
  class PerBendSinister < Pattern; def initialize(color) super('ld', color) end end
  class PerBendInverted < Pattern; def initialize(color) super('lud', color) end end
  class PerBendSinisterInverted < Pattern; def initialize(color) super('rd', color) end end

  class PerPale < Pattern; def initialize(color) super('vh', color) end end
  class PerPaleInverted < Pattern; def initialize(color) super('vhr', color) end end
  class PerFess < Pattern; def initialize(color) super('hh', color) end end
  class PerFessInverted < Pattern; def initialize(color) super('hhb', color) end end

  class BaseDexterCanton < Pattern; def initialize(color) super('bl', color) end end
  class BaseSinisterCanton < Pattern; def initialize(color) super('br', color) end end
  class ChiefDexterCanton < Pattern; def initialize(color) super('tl', color) end end
  class ChiefSinisterCanton < Pattern; def initialize(color) super('tr', color) end end

  class Chevron < Pattern; def initialize(color) super('bt', color) end end
  class InvertedChevron < Pattern; def initialize(color) super('tt', color) end end

  class BaseIndented < Pattern; def initialize(color) super('bts', color) end end
  class ChiefIndented < Pattern; def initialize(color) super('tts', color) end end

  class Roundel < Pattern; def initialize(color) super('mc', color) end end
  class Lozenge < Pattern; def initialize(color) super('mr', color) end end
  class Bordure < Pattern; def initialize(color) super('bo', color) end end
  class BordureIndented < Pattern; def initialize(color) super('cbo', color) end end
  class FieldMasoned < Pattern; def initialize(color) super('bri', color) end end

  class Gradient < Pattern; def initialize(color) super('gra', color) end end
  class BaseGradient < Pattern; def initialize(color) super('gru', color) end end

  class CreeperCharge < Pattern; def initialize(color) super('cre', color) end end
  class SkullCharge < Pattern; def initialize(color) super('sku', color) end end
  class FlowerCharge < Pattern; def initialize(color) super('flo', color) end end
  class MojangCharge < Pattern; def initialize(color) super('moj', color) end end
end