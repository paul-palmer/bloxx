require 'spec_helper'

describe Bone do

  it 'can be created' do
    bone = Bone.new

    expect(ItemCommand.new(bone).to_s).to eq %q<i bone 1>
  end

  it 'with complex attributes' do
    rod = Bone.new.tap do |rod|
      rod.name = 'Rod of Authority!'
      rod.modifiers << AttackDamageModifier.new(:add, +999999).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
      rod.modifiers << FollowRangeModifier.new(:percent_adjust, -0.99).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
      rod.modifiers << MaxHealthModifier.new(:percent_adjust, +1.0).tap{|m| m.uuid = '00000000-0000-0000-0000-000000000000'}
      rod.enchantments << Knockback.new(10)
      rod.enchantments << Looting.new(100)
      rod.unbreakable
      rod.hide_unbreakable
      rod.hide_enchantments
    end

    expect(ItemCommand.new(rod).to_s).to eq %q<i bone 1 {Unbreakable:1,HideFlags:5,display:{Name:"Rod of Authority!"},AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Operation:0,Amount:999999.0,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.followRange",Name:"generic.followRange",Operation:2,Amount:-0.99,UUIDMost:0,UUIDLeast:0},{AttributeName:"generic.maxHealth",Name:"generic.maxHealth",Operation:2,Amount:1.0,UUIDMost:0,UUIDLeast:0}],ench:[{id:19,lvl:10},{id:21,lvl:100}]}>
  end

end