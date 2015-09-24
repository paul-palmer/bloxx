require 'spec_helper'

describe Bow do
  it 'can be created' do
    bow = Bow.new

    expect(ItemCommand.new(bow).to_s).to eq %q<i bow 1>
  end

  it 'with complex attributes' do
    bow = Bow.new.tap do |mci|
      mci.name = %q<CrossBow>
      mci.lore = RawText.new.tap {|lore|
        lore.start_fg_color Color.by_name('yellow_foreground')
        lore.bold_start
        lore << 'CrossBow'
        lore.reset
        lore << ' is '
        lore.start_fg_color Color.by_name('red_foreground')
        lore.italic_start
        lore << 'long, strong,'
        lore.reset
        lore << ' and '
        lore.start_fg_color Color.by_name('green_foreground')
        lore.italic_start
        lore << 'always ready'
        lore.reset
        lore << '!'
      }
      mci.unbreakable
      mci.hide_enchantments
      mci.hide_unbreakable
      mci.enchantments << Power.new(11)
      mci.enchantments << Punch.new(5)
      mci.enchantments << Infinity.new(1)
    end

    expect(ItemCommand.new(bow).to_s).to eq %q<i bow 1 {Unbreakable:1,HideFlags:5,display:{Name:CrossBow,Lore:{text:CrossBow,bold:true,color:yellow,extra:[{text:" is ",bold:false,color:white},{text:"long, strong,",bold:false,italic:true,color:red},{text:" and ",bold:false,color:white},{text:"always ready",bold:false,italic:true,color:green},{text:!,bold:false,color:white}]}},ench:[{id:48,lvl:11},{id:49,lvl:5},{id:51,lvl:1}]}>
  end
end
