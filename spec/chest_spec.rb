require 'spec_helper'

describe Chest do
  it 'can be summoned' do
    chest = Chest.new

    expect(SummonCommand.new(chest).to_s).to eq %q<summon chest {}>
  end

  it 'can be given' do
    chest = Chest.new

    expect(ItemCommand.new(chest).to_s).to eq %q<i chest 1 {}>
  end

  it 'can be summoned with items already in it' do
    chest = Chest.new.tap do |mci|
      mci.slot[0] = Items.new(DiamondSword.new, 64)
      mci.slot[3] = Items.new(Bow.new, 63)
      mci.name = 'Chest of Wonders'
    end

    expect(SummonCommand.new(chest).to_s).to eq %q<summon chest {Items:[{Slot:0,id:diamond_sword,tag:{},Count:64},{Slot:3,id:261,tag:{},Count:63}],display:{Name:"Chest of Wonders"}}>
  end

  it 'can be given with items already in it' do
    chest = Chest.new.tap do |mci|
      mci.slot[0] = Items.new(DiamondSword.new, 64)
      mci.slot[3] = Items.new(Bow.new, 63)
      mci.name = 'Chest of Wonders'
    end

    expect(ItemCommand.new(chest).to_s).to eq %q<i chest 1 {BlockEntityTag:{Items:[{Slot:0,id:diamond_sword,tag:{},Count:64},{Slot:3,id:261,tag:{},Count:63}]},display:{Name:"Chest of Wonders"}}>
  end
end
