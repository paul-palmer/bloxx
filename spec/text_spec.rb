require 'spec_helper'

include Bloxx

describe RawText do
  it 'formats a simple string' do
    line = RawText.new
    line << 'this is a string.'

    expect(line.to_s).to eq %q<{text:"this is a string."}>
  end

  it 'formats a bolded string' do
    line = RawText.new
    line.bold_start
    line << 'this is bold.'

    expect(line.to_s).to eq %q<{text:"this is bold.",bold:true}>
  end

  it 'formats an italicized string' do
    line = RawText.new
    line.italic_start
    line << 'this is italic.'

    expect(line.to_s).to eq %q<{text:"this is italic.",italic:true}>
  end

  it 'can change the foreground color of a string' do
    line = RawText.new
    line.start_fg_color(Color.by_name('blue_foreground'))
    line << 'this is blue.'

    expect(line.to_s).to eq %q<{text:"this is blue.",color:blue}>
  end

  it 'formats a multiple strings' do
    line = RawText.new
    line.bold_start
    line << 'this is bold.'
    line << 'And, so is this.'

    expect(line.to_s).to eq %q<{text:"this is bold.",bold:true,extra:[{text:"And, so is this."}]}>
  end

  it 'can combine formats on a string' do
    line = RawText.new
    line.bold_start
    line.start_fg_color(Color.by_name('blue_foreground'))
    line << 'this is bold blue.'

    expect(line.to_s).to eq %q<{text:"this is bold blue.",bold:true,color:blue}>
  end

  it 'can combine formats across multiple strings' do
    line = RawText.new
    line.bold_start
    line << 'this is bold. '
    line.bold_end
    line.italic_start
    line.start_fg_color(Color.by_name('blue_foreground'))
    line << 'this is blue italic.'
    line.start_fg_color(Color.by_name('yellow_foreground'))
    line << 'this is yellow italic.'

    expect(line.to_s).to eq %q<{text:"this is bold. ",bold:true,extra:[{text:"this is blue italic.",bold:false,italic:true,color:blue},{text:"this is yellow italic.",bold:false,italic:true,color:yellow}]}>
  end

  it 'run a command when a string is clicked' do
    line = RunOnClick.new('/say hello')
    line << 'click this string.'

    expect(line.to_s).to eq %q<{text:"click this string."}>
  end



end
