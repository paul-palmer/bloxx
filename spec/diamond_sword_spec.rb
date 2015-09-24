require 'spec_helper'

describe DiamondSword do

  it 'can be created' do
    sword = DiamondSword.new

    expect(ItemCommand.new(sword).to_s).to eq %q<i diamond_sword 1>
  end

  it 'with complex attributes' do
    sword = DiamondSword.new.tap do |mci|
      mci.name = 'Death!'
      mci.unbreakable
      mci.hide_enchantments
      mci.hide_unbreakable
      mci.enchantments << Sharpness.new(80)
    end

    expect(ItemCommand.new(sword).to_s).to eq %q<i diamond_sword 1 {Unbreakable:1,HideFlags:5,display:{Name:Death!},ench:[{id:16,lvl:80}]}>
  end

  it 'with complex attributes, part 2' do
    sword = DiamondSword.new.tap do |mci|
      mci.name = 'Sticker!'
      mci.lore = 'Pointy end towards your enemy'
      mci.unbreakable
      mci.owner = 'BornToCode'
      mci.age = -32768
      mci.hide_enchantments
      mci.hide_unbreakable
      mci.enchantments << Knockback.new(2)
      mci.enchantments << Looting.new(50)
      mci.enchantments << Sharpness.new(8)
    end

    expect(ItemCommand.new(sword).to_s).to eq %q<i diamond_sword 1 {Unbreakable:1,Owner:BornToCode,Age:-32768,HideFlags:5,display:{Name:Sticker!,Lore:{text:"Pointy end towards your enemy"}},ench:[{id:19,lvl:2},{id:21,lvl:50},{id:16,lvl:8}]}>
  end

end