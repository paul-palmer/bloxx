require_relative 'item'
require_relative 'armor'
require_relative 'axes'
require_relative 'banner'
require_relative 'fireworks'
require_relative 'hoes'
require_relative 'pickaxes'
require_relative 'potions'
require_relative 'shovels'
require_relative 'swords'

module Bloxx

  class Bone < EnchantableItem
    def initialize; super('bone') end
  end

  class Bow < EnchantableItem
    def initialize; super(261) end
  end

  class Saddle < EnchantableItem
    def initialize; super(329) end
  end

end
