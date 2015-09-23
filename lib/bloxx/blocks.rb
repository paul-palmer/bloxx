require_relative 'block'
require_relative 'banner'

module Bloxx

  simple_block Air: 'air'
  simple_block BedRock: 'bedrock'
  simple_block Bookshelf: 'bookshelf'
  simple_block BrownMushroom: 'brown_mushroom'
  simple_block BrownMushroomBlock: 'brown_mushroom_block'
  simple_block Cactus: 'cactus'
  simple_block Carrot: 'carrots'
  simple_block Cauldron: 'cauldron'
  simple_block ChorusFlower: 'chorus_flower'
  simple_block ChorusPlant: 'chorus_plant'
  simple_block Clay: 'clay'
  simple_block CoalBlock: 'coal_block'
  simple_block CoalOre: 'coal_ore'
  simple_block Cobblestone: 'cobblestone'
  simple_block Cobweb: 'web'
  simple_block Cocoa: 'cocoa'
  simple_block CraftingTable: 'crafting_table'
  simple_block Dandelion: 'yellow_flower'
  simple_block DeadBush: 'deadbush'
  simple_block DiamondBlock: 'diamond_block'
  simple_block DiamondOre: 'diamond_ore'
  simple_block Dirt: 'dirt'
  simple_block Dispenser: 'dispenser'
  simple_block DragonEgg: 'dragon_egg'
  simple_block EmeraldBlock: 'emerald_block'
  simple_block EmeraldOre: 'emerald_ore'
  simple_block EndPortalFrame: 'end_portal_frame'
  simple_block EndRod: 'end_rod'
  simple_block EndStone: 'end_stone'
  simple_block EndStoneBricks: 'end_bricks'
  simple_block Farmland: 'farmland'
  simple_block Fence: 'fence'
  simple_block Fire: 'fire'
  simple_block Flower: 'red_flower'
  simple_block FlowerPot: 'flower_pot'
  simple_block Furnace: 'furnace'
  simple_block GlassPane: 'glass_pane'
  simple_block Glowstone: 'glowstone'
  simple_block GoldBlock: 'gold_block'
  simple_block GoldOre: 'gold_ore'
  simple_block Grass: 'tallgrass'
  simple_block GrassBlock: 'grass'
  simple_block Gravel: 'gravel'
  simple_block HardenedClay: 'hardened_clay'
  simple_block Ice: 'ice'
  simple_block IronBars: 'iron_bars'
  simple_block IronDoor: 'iron_door'
  simple_block IronBlock: 'iron_block'
  simple_block IronOre: 'iron_ore'
  simple_block JackOLantern: 'lit_pumpkin'
  simple_block Ladder: 'ladder'
  simple_block LapisBlock: 'lapis_block'
  simple_block LapisOre: 'lapis_ore'
  simple_block LargeFlower: 'double_plant'
  simple_block Lava: 'flowing_lava'
  simple_block Leaves: 'leaves'
  simple_block Lever: 'lever'
  simple_block LilyPad: 'waterlily'
  simple_block Melon: 'melon_block'
  simple_block MonsterEgg: 'monster_egg'
  simple_block MossStone: 'mossy_cobblestone'
  simple_block Mycelium: 'mycelium'
  simple_block NetherBrick: 'nether_brick'
  simple_block NetherBrickFence: 'nether_brick_fence'
  simple_block NetherBrickStairs: 'nether_brick_stairs'
  simple_block NetherPortal: 'portal'
  simple_block NetherRack: 'netherrack'
  simple_block NetherWart: 'nether_wart'
  simple_block Obsidian: 'obsidian'
  simple_block PackedIce: 'packed_ice'
  simple_block Potato: 'potatoes'
  simple_block Prismarine: 'prismarine'
  simple_block Pumpkin: 'pumpkin'
  simple_block PurpurBlock: 'purpur_block'
  simple_block PurpurPillar: 'purpur_pillar'
  simple_block PurpurSlab: 'purpur_slab'
  simple_block PurpurStairs: 'purpur_stairs'
  simple_block QuartzBlock: 'quartz_block'
  simple_block QuartzOre: 'quartz_ore'
  simple_block Rail: 'rail'
  simple_block RedMushroom: 'red_mushroom'
  simple_block RedMushroomBlock: 'red_mushroom_block'
  simple_block RedstoneBlock: 'redstone_block'
  simple_block RedstoneOre: 'redstone_ore'
  simple_block RedstoneRepeater: 'unpowered_repeater'
  simple_block RedstoneWire: 'redstone_wire'
  simple_block Sand: 'sand'
  simple_block SandStone: 'sandstone'
  simple_block SandstoneStairs: 'sandstone_stairs'
  simple_block SeaLantern: 'sea_lantern'
  simple_block Snow: 'snow'
  simple_block SnowLayer: 'snow_layer'
  simple_block SoulSand: 'soulsand'
  simple_block Sponge: 'sponge'
  simple_block StainedClay: 'stained_hardened_clay'
  simple_block StaionaryLava: 'lava'
  simple_block StickyPiston: 'sticky_piston'
  simple_block StoneBlock: 'stone'
  simple_block StoneBricks: 'stonebrick'
  simple_block StoneButton: 'stone_button'
  simple_block StonePressurePlate: 'stone_pressure_plate'
  simple_block StoneSlab: 'stone_slab'
  simple_block StoneStairs: 'stone_stairs'
  simple_block SugarCane: 'reeds'
  simple_block TNT: 'tnt'
  simple_block Torch: 'torch'
  simple_block Tripwire: 'tripwire'
  simple_block TripwireHook: 'tripwire_hook'
  simple_block Vines: 'vine'
  simple_block Water: 'flowing_water'
  simple_block Wheat: 'wheat'
  simple_block WoodPlanks: 'planks'
  simple_block WoodenDoor: 'wooden_door'
  simple_block WoodenPressurePlate: 'wooden_pressure_plate'
  simple_block WoodenStairs: 'oak_stairs'

  subtyped_block Wool: 'wool'
  subtyped_block Wood: 'log'



  class Chest < Block
    prepend NameableBlock
    prepend LockableBlock

    def initialize
      super('chest')
      #self << (@disp = Display.new)
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

  class CommandBlock < Block
    include NameableBlock

    def initialize(command = nil)
      super('command_block')
      self << (@disp = Display.new)
      self.command = command unless command.nil?
    end

    def command;    self['Command'] end
    def command=(v) self['Command'] = v end
  end


  class MobSpawner < Block
    def initialize(entity)
      super('mob_spawner')
      self['EntityId'] = entity.type
      self['SpawnData'] = entity
    end

    def spawn_count;              self['SpawnCount'] end
    def spawn_count=(v)           self['SpawnCount'] = v end
    def spawn_range=(v)           self['SpawnRange'] = v end
    def max_nearby_entities=(v)   self['MaxNearbyEntities'] = v end
    def required_player_range=(v) self['RequiredPlayerRange'] = v end
    def spawn_delay(initial, min = nil, max = nil)
      self['Delay'] = initial unless initial.nil?
      self['MinSpawnDelay'] = min unless min.nil?
      self['MaxSpawnDelay'] = max unless max.nil?
    end
  end

end