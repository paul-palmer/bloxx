require 'spec_helper'

describe SiameseCat do

  it 'can be created' do
    cat = SiameseCat.new

    expect(SummonCommand.new(cat).to_s).to eq %q<summon Ozelot {CatType:3}>
  end

  it 'with complex attributes' do
    duration = 999999

    cat = SiameseCat.new
    cat.name = %<Whiskers>
    cat.always_show_name
    cat.owner_uuid = '4af775e8-2d26-45b9-a824-89c91110fb79'
    cat.persistant
    cat.silent
    cat.healrate = 40
    cat.attrs   << MaxHealth.new(80)
    cat.attrs   << FollowRange.new(99999)
    cat.effects << Regeneration.new(6, duration, false)
    cat.effects << Resistance.new(4, duration, false)
    cat.effects << FireResist.new(1-1, duration, false)
    cat.effects << WaterBreath.new(1-1, duration, false)

    expect(SummonCommand.new(cat).to_s).to eq %q<summon Ozelot {CatType:3,CustomName:Whiskers,CustomNameVisible:1,OwnerUUID:4af775e8-2d26-45b9-a824-89c91110fb79,PersistenceRequired:1,Silent:1,AbsorptionAmount:40,ActiveEffects:[{Id:10,Amplifier:6,Duration:999999,ShowParticles:0},{Id:11,Amplifier:4,Duration:999999,ShowParticles:0},{Id:12,Amplifier:0,Duration:999999,ShowParticles:0},{Id:13,Amplifier:0,Duration:999999,ShowParticles:0}],Attributes:[{Name:generic.maxHealth,Base:80},{Name:generic.followRange,Base:99999}]}>
  end

end