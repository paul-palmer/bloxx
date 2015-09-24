require 'spec_helper'

describe IronGolem do

  it 'can be created' do
    golem = IronGolem.new

    expect(SummonCommand.new(golem).to_s).to eq %q<summon VillagerGolem>
  end

  it 'with complex attributes' do
    duration = 999999
    golem = IronGolem.new
    golem.name = %<Rusty>
    golem.always_show_name
    golem.healrate = 40
    golem.attrs   << AttackDamage.new(15)
    golem.attrs   << KnockbackResistance.new(100)
    golem.attrs   << MaxHealth.new(100)
    golem.effects << Leaping.new(3-1, duration, false)
    golem.effects << Regeneration.new(4, duration, false)
    golem.effects << Strength.new(5, duration, false)
    golem.effects << Resistance.new(5, duration, false)

    expect(SummonCommand.new(golem).to_s).to eq %q<summon VillagerGolem {CustomName:Rusty,CustomNameVisible:1,AbsorptionAmount:40,ActiveEffects:[{Id:8,Amplifier:2,Duration:999999,ShowParticles:0},{Id:10,Amplifier:4,Duration:999999,ShowParticles:0},{Id:5,Amplifier:5,Duration:999999,ShowParticles:0},{Id:11,Amplifier:5,Duration:999999,ShowParticles:0}],Attributes:[{Name:generic.attackDamage,Base:15},{Name:generic.knockbackResistance,Base:1},{Name:generic.maxHealth,Base:100}]}>
  end

end