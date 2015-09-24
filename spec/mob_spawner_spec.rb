require 'spec_helper'

describe MobSpawner do

  it 'can be created' do
    spawner = MobSpawner.new

    expect(SummonCommand.new(spawner).to_s).to eq %q<summon mob_spawner>
  end

  it 'summon with complex attributes' do
    spawner = MobSpawner.new(XPOrb.new(50))
    spawner.spawn_range = 3
    spawner.required_player_range = 2
    spawner.max_nearby_entities = 5
    spawner.spawn_delay(20, 60, 120)

    expect(SetBlockCommand.new(spawner).to_s).to eq %q<setblock mob_spawner 0 replace {EntityId:XPOrb,SpawnData:{Value:50},SpawnRange:3,RequiredPlayerRange:2,MaxNearbyEntities:5,Delay:20,MinSpawnDelay:60,MaxSpawnDelay:120}>
  end

  it 'item with complex attributes' do
    spawner = MobSpawner.new(XPOrb.new(50))
    spawner.spawn_range = 3
    spawner.required_player_range = 2
    spawner.max_nearby_entities = 5
    spawner.spawn_delay(20, 60, 120)

    spawner_item = BlockItem.new(spawner)
    spawner_item.name = 'XP:50 Spawner'

    expect(ItemCommand.new(spawner_item).to_s).to eq %q<i mob_spawner 1 {BlockEntityTag:{EntityId:XPOrb,SpawnData:{Value:50},SpawnRange:3,RequiredPlayerRange:2,MaxNearbyEntities:5,Delay:20,MinSpawnDelay:60,MaxSpawnDelay:120},display:{Name:"XP:50 Spawner"}}>
  end

end