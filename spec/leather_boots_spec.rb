require 'spec_helper'

describe LeatherBoots do

  it 'can be created' do
    boots = LeatherBoots.new

    expect(ItemCommand.new(boots).to_s).to eq %q<i leather_boots 1 {}>
  end

  it 'with complex attributes' do
    boots = LeatherBoots.new
    boots.name = %q<Ruby Slippers>
    boots.color = Color.rgb(0xff, 0x00, 0x00)
    boots.unbreakable
    boots.hide_enchantments
    boots.hide_modifiers
    boots.hide_unbreakable
    boots.hide_others
    boots.modifiers << AttackDamageModifier.new(:percent_adjust, +1.0).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.modifiers << FollowRangeModifier.new(:percent_adjust, -0.9).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.modifiers << KnockbackResistanceModifier.new(:add, +0.95).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.modifiers << MaxHealthModifier.new(:percent_adjust, +1.0).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.modifiers << MovementSpeedModifier.new(:percent_adjust, +0.5).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
    boots.enchantments << Protection.new(5)
    boots.enchantments << DepthStrider.new(5)
    boots.enchantments << FeatherFalling.new(5)
    puts ItemCommand.new(boots)

    expect(ItemCommand.new(boots).to_s).to eq %q<i leather_boots 1 {Unbreakable:1,HideFlags:39,display:{Name:"Ruby Slippers",color:16711680},AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Operation:2,Amount:1.0,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.followRange",Name:"generic.followRange",Operation:2,Amount:-0.9,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.knockbackResistance",Name:"generic.knockbackResistance",Operation:0,Amount:0.95,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.maxHealth",Name:"generic.maxHealth",Operation:2,Amount:1.0,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.movementSpeed",Name:"generic.movementSpeed",Operation:2,Amount:0.5,UUIDMost:0,UUIDLeast:0}],ench:[{id:0,lvl:5},{id:8,lvl:5},{id:2,lvl:5}]}>
  end

end