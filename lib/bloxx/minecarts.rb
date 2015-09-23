require_relative 'entities'

module Bloxx


  class ChestMinecart < Entity
    def initialize
      super('chest_minecart')
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
    def initialize
      super('hopper_minecart')
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