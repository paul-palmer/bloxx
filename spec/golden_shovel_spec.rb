require 'spec_helper'

describe GoldenShovel do

  it 'can be created' do
    shovel = GoldenShovel.new

    expect(ItemCommand.new(shovel).to_s).to eq %q<i golden_shovel 1 {}>
  end

  it 'with complex attributes' do
    shovel = GoldenShovel.new
    shovel.name = %q<Digger>
    shovel.unbreakable
    shovel.hide_enchantments
    shovel.hide_unbreakable
    shovel.enchantments << Fortune.new(20)
    shovel.enchantments << Sharpness.new(8)
    shovel.enchantments << Efficiency.new(5)

    expect(ItemCommand.new(shovel).to_s).to eq %q<i golden_shovel 1 {Unbreakable:1,HideFlags:5,display:{Name:Digger},ench:[{id:35,lvl:20},{id:16,lvl:8},{id:32,lvl:5}]}>
  end

end