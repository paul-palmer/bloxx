require 'delegate'

require_relative 'base'


module Bloxx

  class FormatState
    attr_reader :flags

    def initialize(flags = nil)
      @flags = flags || INIT_FLAGS.clone
    end

    def end_bold;           @flags[:bold] = false end
    def end_italic;         @flags[:italic] = false end
    def end_obfuscated;     @flags[:obfuscated] = false end
    def end_strikethrough;  @flags[:strikethrough] = false end
    def end_underline;      @flags[:underline] = false end

    def start_bold;           @flags[:bold] = true end
    def start_italic;         @flags[:italic] = true end
    def start_obfuscated;     @flags[:obfuscated] = true end
    def start_strikethrough;  @flags[:strikethrough] = true end
    def start_underline;      @flags[:underline] = true end

    def color;    @flags[:color] end
    def color=(v) @flags[:color] = v end
    def reset;    @flags = INIT_FLAGS.clone end

    INIT_FLAGS = {
        bold:           false,
        italic:         false,
        obfuscated:     false,
        strikethrough:  false,
        underline:      false,
        color:          'white',
    }

    def-(other)       FormatState.new(Hash[@flags.select {|k,v| other.flags[k] != v}]) end
    def merge(other)  FormatState.new(@flags.merge(other.flags)) end
    def clone;        FormatState.new(@flags.clone) end
  end


  class FormattedText
    extend Forwardable

    def_delegators :@state, :color, :color=, :reset

    attr_accessor :text, :state

    def initialize(text)
      @text = text
      @state = FormatState.new
    end

    def bold;           @state.start_bold end
    def italic;         @state.start_italic end
    def obfuscated;     @state.start_obfuscated end
    def strikethrough;  @state.start_strikethrough end
    def underline;      @state.start_underline end
    def reset;          @state.reset end
    def color;          @color end
    def color=(c)       @state.color = (@color = c).closest_text.text end

    def to_nbt;         self.format(FormatState.new) end
    def to_s;           self.to_nbt end

    def format(prev_state)
      new_flags = (@state - prev_state).flags
      "{#{([@text] + format_flags(new_flags)).join(',')}}"
    end

    def format_flags(flags) flags.map{|k,v| "#{k}:#{v}"} end
    def merge(state) @state.merge(state) end
  end

  class FormattedLine
    def initialize(*text)
      @text = [*text]
      @state = FormatState.new
    end

    def<<(text)           @text << text end

    def to_nbt
      state = @state
      "[#{@text.map{|t| t.format(state).tap {state = t.state}}.join(',')}]"
    end

    def to_s;           self.to_nbt end

  end

  class RawText_Base
    def to_RawFormat; self end
    def format?;      true end
    def text?;        false end
  end

  class RawText < RawText_Base
    def initialize
      @actions = []
    end

    def<<(a) @actions << to_format(a) end

    def bold_start;           self << StartBold.new end
    def bold_end;             self << EndBold.new end

    def italic_start;         self << StartItalic.new end
    def italic_end;           self << EndItalic.new end

    def obfuscated_start;     self << StartFormat.new(:obfuscated) end
    def obfuscated_end;       self << EndFormat.new(:obfuscated) end

    def strikethrough_start;  self << StartFormat.new(:strikethrough) end
    def strikethrough_end;    self << EndFormat.new(:strikethrough) end

    def underline_start;      self << StartFormat.new(:underline) end
    def underline_end;        self << EndFormat.new(:underline) end

    def start_fg_color(c)     self << ColorFormat.new(c) end
    def reset;                @flags = INIT_FLAGS.clone end

    def to_s;                 self.to_nbt end
    def to_nbt;               self.format(FormatState.new, FormatState.new) end

    def format(initial_state, cum_state)
      actions = split_after_text(@actions)

      # the first segment is special and modifies state for the entire run
      result = format_actions(actions.shift, initial_state, cum_state)
      return "{#{result}}" if actions.empty?

      # remaining text segments inherit formatting from the first one
      extra = actions.map {|a| "{#{format_actions(a, initial_state.clone, cum_state)}}"}.join(',')
      "{#{result},extra:[#{extra}]}"
    end

    def split_after_text(actions)
      split_after = false
      actions.slice_before {|a| split_after.tap {split_after = a.text?}}.to_a
    end

    def apply_formats(actions, state)
      actions.each {|a| a.format(state)}
    end

    def format_actions(actions, state, cum_state)
      initial_state = state.clone
      text = actions.last.text? ? actions.pop : %q<"">
      actions.each {|a| a.format(cum_state); a.format(state)} # apply formatting
      hsh = {text: text}.merge((cum_state - initial_state).flags)
      "#{hsh.map{|k,v| "#{k}:#{v}"}.join(',')}"
    end

    private

    def to_format(a)
      case
        when a.respond_to?(:to_RawFormat) then a.to_RawFormat
        when a.respond_to?(:to_s)         then Text.new(a.to_s)
        else
          warn a.inspect
          raise "Broked"
      end
    end

    class StartFormat < RawText_Base
    end

    class StartBold < StartFormat
      def format(state) state.start_bold end
      def to_hash;      {bold: true} end
    end

    class StartItalic < StartFormat
      def format(state) state.start_italic end
      def to_hash;      {italic: true} end
    end



    class EndFormat < RawText_Base
    end

    class EndBold < StartFormat
      def format(state) state.end_bold end
      def to_hash;      {bold: false} end
    end

    class EndItalic < StartFormat
      def format(state) state.end_italic end
      def to_hash;      {italic: false} end
    end


    class ColorFormat < RawText_Base
      attr_reader :color
      def initialize(color) @color = color.closest_text.text end
      def format(state)     state.color = @color end
      def to_hash;          {color: @color} end
    end

    class Text < RawText_Base
      attr_reader :text
      def initialize(text)  @text = SafeString.new(text) end
      def format(state)     @text end # need to handle quoting and escaping of text
      def to_hash;          {text: @text} end
      def to_s;             @text.to_s end

      def format?;      false end
      def text?;        true end

    end
  end

  class ClickEvent < DelegateClass(RawText)
    protected

    def initialize(event) @event = event; super(@text = RawText.new) end
    def to_hash;          @text.to_hash.merge(@event) end
  end

  class HoverEvent < DelegateClass(RawText)
    protected

    def initialize(event) @event = event; super(@text = RawText.new) end
    def to_hash;          @text.to_hash.merge(@event) end
  end

  class Insertion; end #TBD
  class Score; end # TBD
  class Selector; end # TBD
  class Translate; end # TBD



  class RunOnClick < ClickEvent
    def initialize(command) super(action: 'run_command', value: command.to_s) end
  end

  class SuggestOnClick < ClickEvent
    def initialize(command) super(action: 'suggest_command', value: command.to_s) end
  end

  class OpenUrlOnClick < ClickEvent
    def initialize(url) super(action: 'open_url', value: url.to_s) end
  end

  class ChangePageOnClick < ClickEvent
    def initialize(page) super(action: 'change_page', value: page.to_i) end
  end

  class TextOnHover < HoverEvent
    def initialize(raw_text) super(action: 'show_text', value: raw_text) end
  end

  class ShowItemOnHover < HoverEvent
    def initialize(item) super(action: 'show_item', value: item) end
  end

  class ShowEntityOnHover < HoverEvent
    def initialize(entity) super(action: 'show_entity', value: entity) end
  end

  class ShowAchievementOnHover < HoverEvent
    def initialize(achievement) super(action: 'show_achievement', value: achievement) end
  end

end