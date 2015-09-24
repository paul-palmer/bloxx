require 'spec_helper'

describe DiamondBoots do

  it 'can be created' do
    boots = DiamondBoots.new

    expect(ItemCommand.new(boots).to_s).to eq %q<i diamond_boots 1 {}>
  end

  it 'with complex attributes' do
    boots = DiamondBoots.new
    boots.name = %q<Safety Boots!>
    boots.unbreakable
    boots.hide_enchantments
    boots.hide_modifiers
    boots.hide_unbreakable
    boots.modifiers << MovementSpeedModifier.new(:percent_adjust, +0.5).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.modifiers << KnockbackResistanceModifier.new(:add, +0.95).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.modifiers << FollowRangeModifier.new(:percent_adjust, -0.9).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.enchantments << Protection.new(4)
    boots.enchantments << DepthStrider.new(3)
    boots.enchantments << FeatherFalling.new(4)

    expect(ItemCommand.new(boots).to_s).to eq %q<i diamond_boots 1 {Unbreakable:1,HideFlags:7,display:{Name:"Safety Boots!"},AttributeModifiers:[{AttributeName:"generic.movementSpeed",Name:"generic.movementSpeed",Operation:2,Amount:0.5,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.knockbackResistance",Name:"generic.knockbackResistance",Operation:0,Amount:0.95,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.followRange",Name:"generic.followRange",Operation:2,Amount:-0.9,UUIDMost:0,UUIDLeast:0}],ench:[{id:0,lvl:4},{id:8,lvl:3},{id:2,lvl:4}]}>
  end

end