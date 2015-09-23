require 'spec_helper'

describe RunOnClick do
  it 'can be created' do
    line = RunOnClick.new('/say hello')

    expect(line.to_s).to eq %q<{clickEvent:{action:run_command,value:"/say hello"}}>
  end

  it 'formats a simple string' do
    line = RunOnClick.new('/say hello')
    line << 'this is a string.'

    expect(line.to_s).to eq %q<{text:"this is a string.",clickEvent:{action:run_command,value:"/say hello"}}>
  end

  it 'formats a bolded string' do
    line = RunOnClick.new('/say hello')
    line.bold_start
    line << 'this is bold.'

    expect(line.to_s).to eq %q<{text:"this is bold.",bold:true,clickEvent:{action:run_command,value:"/say hello"}}>
  end

  it 'formats an italicized string' do
    line = RunOnClick.new('/say hello')
    line.italic_start
    line << 'this is italic.'

    expect(line.to_s).to eq %q<{text:"this is italic.",italic:true,clickEvent:{action:run_command,value:"/say hello"}}>
  end

  it 'can change the foreground color of a string' do
    line = RunOnClick.new('/say hello')
    line.start_fg_color(Color.by_name('blue_foreground'))
    line << 'this is blue.'

    expect(line.to_s).to eq %q<{text:"this is blue.",color:blue,clickEvent:{action:run_command,value:"/say hello"}}>
  end

  it 'formats a multiple strings' do
    line = RunOnClick.new('/say hello')
    line.bold_start
    line << 'this is bold.'
    line << 'And, so is this.'

    expect(line.to_s).to eq %q<{text:"this is bold.",bold:true,clickEvent:{action:run_command,value:"/say hello"},extra:[{text:"And, so is this."}]}>
  end

  it 'can combine formats on a string' do
    line = RunOnClick.new('/say hello')
    line.bold_start
    line.start_fg_color(Color.by_name('blue_foreground'))
    line << 'this is bold blue.'

    expect(line.to_s).to eq %q<{text:"this is bold blue.",bold:true,color:blue,clickEvent:{action:run_command,value:"/say hello"}}>
  end

  it 'can combine formats across multiple strings' do
    line = RunOnClick.new('/say hello')
    line.bold_start
    line << 'this is bold. '
    line.bold_end
    line.italic_start
    line.start_fg_color(Color.by_name('blue_foreground'))
    line << 'this is blue italic.'
    line.start_fg_color(Color.by_name('yellow_foreground'))
    line << 'this is yellow italic.'

    expect(line.to_s).to eq %q<{text:"this is bold. ",bold:true,clickEvent:{action:run_command,value:"/say hello"},extra:[{text:"this is blue italic.",bold:false,italic:true,color:blue},{text:"this is yellow italic.",bold:false,italic:true,color:yellow}]}>
  end

=begin
=end


end
