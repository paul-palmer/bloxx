require 'spec_helper'

describe GoldenAxe do

  it 'can be created' do
    axe = GoldenAxe.new

    expect(ItemCommand.new(axe).to_s).to eq %q<i golden_axe 1>
  end

  it 'with complex attributes' do
    axe = GoldenAxe.new
    axe.name = %<Chopper>
    axe.unbreakable
    axe.hide_enchantments
    axe.hide_unbreakable
    axe.enchantments << Fortune.new(11)
    axe.enchantments << Sharpness.new(8)
    axe.enchantments << Efficiency.new(5)

    expect(ItemCommand.new(axe).to_s).to eq %q<i golden_axe 1 {Unbreakable:1,HideFlags:5,display:{Name:Chopper},ench:[{id:35,lvl:11},{id:16,lvl:8},{id:32,lvl:5}]}>
  end

end