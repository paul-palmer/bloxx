#!/usr/bin/env ruby

module Bloxx
  class Color
    def self.rgb(r, g, b)
      new(rgb2color(r, g, b))
    end

    def self.by_name(name)
      color = NAME2RGB[name] || NAME2RGB[underscore(name)]
      new(color) unless color.nil?
    end

    def self.by_wool_subtype(id)
      new(WOOL2RGB[id])
    end

    def self.by_dye_subtype(id)
      new(WOOL2RGB[id])
    end

    def self.[](*args)
      (self.rgb(*args) rescue nil) ||
          (self.by_wool_subtype(*args) if args.first >= 0 && args.first <= 15 rescue nil) ||
          (self.by_name(*args) rescue nil)
    end

    def red;          (@color >> 16) & 0xff end
    def green;        (@color >> 8) & 0xff end
    def blue;         @color & 0xff end
    def name;         exact_color(NAME2RGB) end
    def wool_subtype; WOOL2RGB.find_index(@color) end
    def text;         exact_color(FOREGROUND_COLORS) end
    def to_nbt;       @color.to_i end
    def to_s;         self.to_nbt end

    def closest_wool; Color.new(closest_color(WOOL_COLORS).last) end
    def closest_text; Color.new(closest_color(FOREGROUND_COLORS).last) end

    protected

    def initialize(color)
      @color = color
    end

    def self.rgb2color(r, g, b) (((r << 8) + g) << 8) + b end

    def sq(n) n * n end

    def color_distance(other)
      Math.sqrt(sq(self.red - other.red) + sq(self.green - other.green) + sq(self.blue - other.blue))
    end

    def closest_color(colors)
      colors.min_by {|c| id, color = *c; [color_distance(Color.new(color)), id]}
    end

    def exact_color(colors)
      colors.reduce(nil) {|res, c| id, color = *c; res ||= (id if color == @color)}
    end

    def self.underscore(str)
      str.gsub(/([a-z])([A-Z])/,'\1 \2').
          gsub(/ +/, '_').
          downcase
    end

    private

    WOOL_COLORS = [
        ['white_wool',      0xdddddd],
        ['orange_wool',     0xdb7d3e],
        ['magenta_wool',    0xb350db],
        ['light_blue_wool', 0x6b8ac9],
        ['yellow_wool',     0xb1a627],
        ['lime_wool',       0x41ae38],
        ['pink_wool',       0xd08499],
        ['gray_wool',       0x404040],
        ['light_gray_wool', 0x9aa1a1],
        ['cyan_wool',       0x2e6e89],
        ['purple_wool',     0x7e3db5],
        ['blue_wool',       0x2e388d],
        ['brown_wool',      0x4f321f],
        ['green_wool',      0x35461b],
        ['red_wool',        0x963430],
        ['black_wool',      0x191616],
    ]

    # WOOL2RGB is array of wool colors indexed by wool subtype
    WOOL2RGB = WOOL_COLORS.map(&:last)

    DYE_COLORS = [
        ['ink_sac',         0x191919],
        ['rose_red',        0x993333],
        ['cactus_green',    0x667f33],
        ['cocoa_beans',     0x664c33],
        ['lapis_lazuli',    0x334cb2],
        ['purple_dye',      0x7f3fb2],
        ['cyan_dye',        0x4c7f99],
        ['light_gray_dye',  0x999999],
        ['gray_dye',        0x4c4c4c],
        ['pink_dye',        0xf27fa5],
        ['lime_dye',        0x7fcc19],
        ['dandelion_yellow',0xe5e533],
        ['light_blue_dye',  0x6699d8],
        ['magenta_dye',     0xb24cd8],
        ['orange_dye',      0xd87f33],
        ['bone_meal',       0xffffff],
    ]

    BACKGROUND_COLORS = {
        'black'         =>  0x000000,
        'dark_blue'     =>  0x00002a,
        'dark_green'    =>  0x002a00,
        'dark_aqua'     =>  0x002a2a,
        'dark_red'      =>  0x2a0000,
        'dark_purple'   =>  0x2a002a,
        'gold'          =>  0x2a2a00,
        'gray'          =>  0x2a2a2a,
        'dark_gray'     =>  0x151515,
        'blue'          =>  0x15153f,
        'green'         =>  0x153f15,
        'aqua'          =>  0x153f3f,
        'red'           =>  0x3f1515,
        'light_purple'  =>  0x3f153f,
        'yellow'        =>  0x3f3f15,
        'white'         =>  0x3f3f3f,
    }

    FOREGROUND_COLORS = {
        'black'         =>  0x000000,
        'dark_blue'     =>  0x0000aa,
        'dark_green'    =>  0x00aa00,
        'dark_aqua'     =>  0x00aa00,
        'dark_red'      =>  0xaa0000,
        'dark_purple'   =>  0xaa00aa,
        'gold'          =>  0xaaaa00,
        'gray'          =>  0xaaaaaa,
        'dark_gray'     =>  0x555555,
        'blue'          =>  0x5555ff,
        'green'         =>  0x55ff55,
        'aqua'          =>  0x55ffff,
        'red'           =>  0xff5555,
        'light_purple'  =>  0xff55ff,
        'yellow'        =>  0xffff55,
        'white'         =>  0xffffff,
    }

    NAME2RGB = Hash[WOOL_COLORS].
               merge(Hash[DYE_COLORS]).
               merge(Hash[BACKGROUND_COLORS.map{|n,c| [n+"_background", c]}]).
               merge(Hash[FOREGROUND_COLORS.map{|n,c| [n+"_foreground", c]}])
  end

end

if __FILE__ == $0
  include Bloxx

  puts Color.by_name('black').name
  puts Color.by_name('Dark Gray').name
  puts Color.by_name('Dark Gray').wool
  puts Color.by_name('White').closest_wool.wool
  puts Color.by_name('Green').closest_text.text
end
