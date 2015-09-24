require 'spec_helper'

describe Chest do
  it 'can be summoned' do
    chest = Chest.new

    expect(SummonCommand.new(chest).to_s).to eq %q<summon chest>
  end

  it 'can be given' do
    chest = Chest.new
    item = BlockItem.new(chest)

    expect(ItemCommand.new(item).to_s).to eq %q<i chest 1>
  end

  it 'can be summoned with items already in it' do
    chest = Chest.new.tap do |mci|
      mci.slot[0] = Items.new(DiamondSword.new, 64)
      mci.slot[3] = Items.new(Bow.new, 63)
      mci.name = 'Chest of Wonders'
    end

    expect(SummonCommand.new(chest).to_s).to eq %q<summon chest {Items:[{Slot:0,id:diamond_sword,Count:64},{Slot:3,id:261,Count:63}],display:{Name:"Chest of Wonders"}}>
  end

  it 'can be given with items already in it' do
    chest = Chest.new.tap do |mci|
      mci.slot[0] = Items.new(DiamondSword.new, 2)
      mci.slot[3] = Items.new(Bow.new, 3)
      #mci.name = 'Chest of Wonders'
    end

    item = BlockItem.new(chest)
    item.name = 'Chest of Wonders!'

    expect(ItemCommand.new(item).to_s).to eq %q<i chest 1 {BlockEntityTag:{Items:[{Slot:0,id:diamond_sword,Count:2},{Slot:3,id:261,Count:3}]},display:{Name:"Chest of Wonders!"}}>
  end
end
