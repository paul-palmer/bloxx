require_relative 'entity'


module Bloxx


  class Rabbit < Entity
    def initialize(rabbit_type)
      super('Rabbit')
      self.rabbit_type = rabbit_type
    end

    def rabbit_type;      self['RabbitType'] end

    protected

    def rabbit_type=(v)   self['RabbitType'] = v end
  end

  class BrownRabbit < Rabbit
    def initialize
      super(0)
    end
  end

  class WhiteRabbit < Rabbit
    def initialize
      super(1)
    end
  end

  class BlackRabbit < Rabbit
    def initialize
      super(2)
    end
  end

  class BlackAndWhiteRabbit < Rabbit
    def initialize
      super(3)
    end
  end

  class GoldRabbit < Rabbit
    def initialize
      super(4)
    end
  end

  class SaltAndPepperRabbit < Rabbit
    def initialize
      super(5)
    end
  end

  class KillerBunny < Rabbit
    def initialize
      super(99)
    end
  end

end
