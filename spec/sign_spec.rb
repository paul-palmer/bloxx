require 'spec_helper'

describe Sign do
  it 'can be summoned' do
    sign = Sign.new

    expect(SummonCommand.new(sign).to_s).to eq %q<summon sign>
  end

  it 'can be given' do
    sign = Sign.new
    item = BlockItem.new(sign)

    expect(ItemCommand.new(item).to_s).to eq %q<i sign 1>
  end

  it 'with complex attributes' do
    sign = Sign.new
    sign.line << 'The next line is clickable'
    sign.line << RunOnClick.new('/say hello').tap {|line|
      line.start_fg_color Color.by_name('yellow_foreground')
      line.bold_start
      line << 'Hello!'
    }

    item = BlockItem.new(sign)
    item.name = '!!!'

    expect(ItemCommand.new(item).to_s).to eq %q<i sign 1 {BlockEntityTag:{Text1:"{text:\"The next line is clickable\"}",Text2:"{text:Hello!,bold:true,color:yellow,clickEvent:{action:run_command,value:\"/say hello\"}}"},display:{Name:!!!}}>
  end
end
