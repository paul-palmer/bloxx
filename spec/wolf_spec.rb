require 'spec_helper'

describe Wolf do

  it 'can be created' do
    wolf = Wolf.new

    expect(SummonCommand.new(wolf).to_s).to eq %q<summon Wolf {}>
  end

  it 'with complex attributes' do
    duration = 999999

    wolf = Wolf.new
    wolf.name = %<RazorTooth>
    wolf.always_show_name
    wolf.owner_uuid = '4af775e8-2d26-45b9-a824-89c91110fb79'
    wolf.collar_color = 4
    wolf.persistant
    wolf.silent
    wolf.healrate = 40
    wolf.attrs   << AttackDamage.new(15)
    wolf.attrs   << FollowRange.new(4)
    wolf.attrs   << KnockbackResistance.new(90)
    wolf.attrs   << MaxHealth.new(80)
    wolf.effects << Regeneration.new(6, duration, false)
    wolf.effects << Resistance.new(4, duration, false)
    wolf.effects << Leaping.new(3-1, duration, false)
    wolf.effects << FireResist.new(1-1, duration, false)
    wolf.effects << WaterBreath.new(1-1, duration, false)

    expect(SummonCommand.new(wolf).to_s).to eq %q<summon Wolf {CustomName:RazorTooth,CustomNameVisible:1,OwnerUUID:4af775e8-2d26-45b9-a824-89c91110fb79,CollarColor:4,PersistenceRequired:1,Silent:1,AbsorptionAmount:40,ActiveEffects:[{Id:10,Amplifier:6,Duration:999999,ShowParticles:0},{Id:11,Amplifier:4,Duration:999999,ShowParticles:0},{Id:8,Amplifier:2,Duration:999999,ShowParticles:0},{Id:12,Amplifier:0,Duration:999999,ShowParticles:0},{Id:13,Amplifier:0,Duration:999999,ShowParticles:0}],Attributes:[{Name:generic.attackDamage,Base:15},{Name:generic.followRange,Base:4},{Name:generic.knockbackResistance,Base:0},{Name:generic.maxHealth,Base:80}]}>
  end

end