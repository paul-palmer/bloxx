require 'spec_helper'

describe TextOnHover do
  it 'can be created' do
    hover = 'hover text'
    line = TextOnHover.new(hover)

    expect(line.to_s).to eq %q<{hoverEvent:{action:show_text,value:"hover text"}}>
  end

  it 'with a simple string' do
    hover = RawText.new
    hover.italic_start
    hover << 'italic'
    line = TextOnHover.new(hover)
    line << 'hover test.'

    expect(line.to_s).to eq %q<{text:"hover test.",hoverEvent:{action:show_text,value:{text:italic,italic:true}}}>
  end

end
