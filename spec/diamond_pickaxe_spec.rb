require 'spec_helper'

describe DiamondPickaxe do

  it 'can be created' do
    pickaxe = DiamondPickaxe.new

    expect(ItemCommand.new(pickaxe).to_s).to eq %q<i diamond_pickaxe 1>
  end

  it 'with complex attributes' do
    pickaxe = DiamondPickaxe.new
    pickaxe.name = %q<Silky>
    pickaxe.unbreakable
    pickaxe.hide_enchantments
    pickaxe.hide_unbreakable
    pickaxe.enchantments << SilkTouch.new(1)
    pickaxe.enchantments << Efficiency.new(5)

    expect(ItemCommand.new(pickaxe).to_s).to eq %q<i diamond_pickaxe 1 {Unbreakable:1,HideFlags:5,display:{Name:Silky},ench:[{id:33,lvl:1},{id:32,lvl:5}]}>
  end

  it 'with complex attributes, part 2' do
    pickaxe = DiamondPickaxe.new
    pickaxe.name = %q<Lucky>
    pickaxe.unbreakable
    pickaxe.hide_enchantments
    pickaxe.hide_unbreakable
    pickaxe.enchantments << Fortune.new(100)
    pickaxe.enchantments << Efficiency.new(5)

    expect(ItemCommand.new(pickaxe).to_s).to eq %q<i diamond_pickaxe 1 {Unbreakable:1,HideFlags:5,display:{Name:Lucky},ench:[{id:35,lvl:100},{id:32,lvl:5}]}>
  end

end