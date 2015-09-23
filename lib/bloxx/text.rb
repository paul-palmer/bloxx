require 'delegate'

require_relative 'base'


module Bloxx


  class RawText_Base
    def to_RawFormat; self end
    def format?;      true end
    def text?;        false end
  end

  class RawText < RawText_Base
    def initialize
      @actions, @event = [], nil
    end

    def<<(a) @actions << RawText.to_format(a) end

    def bold_start;           self << StartBold.new end
    def bold_end;             self << EndBold.new end

    def italic_start;         self << StartItalic.new end
    def italic_end;           self << EndItalic.new end

    def obfuscated_start;     self << StartObfuscated.new end
    def obfuscated_end;       self << EndObfuscated.new end

    def strikethrough_start;  self << StartStrikeThrough.new end
    def strikethrough_end;    self << EndStrikeThrough.new end

    def underline_start;      self << StartUnderline.new end
    def underline_end;        self << EndUnderline.new end

    def start_fg_color(c)     self << ColorFormat.new(c) end
    def reset;                @flags = INIT_FLAGS.clone end

    def to_s;                 self.to_nbt end
    def to_nbt
      state, cum_state = State.new, State.new

      sequences = split_after_text(@actions)

      # the first segment is special and sets state for the rest of the segments
      first_seq = format_actions(sequences.shift, state, cum_state)

      extra_seq = unless sequences.empty?
        # remaining text segments inherit formatting from the first one
        {extra: sequences.map {|s| format_actions(s, state.clone, cum_state)}}
      end

      obj2nbt(first_seq.merge(@event || {}).merge(extra_seq || {}))
    end

    # splits the activity list into runs of formatting activities followed and
    # terminated by a text string.
    def split_after_text(actions)
      split_after = false
      actions.slice_before {|a| split_after.tap {split_after = a.text?}}.to_a
    end

    def format_actions(actions, state, cum_state)
      initial_state = state.clone

      unless actions.nil?
        text = {text: (actions.last.text?) ? actions.pop : %q<"">}
        actions.each {|a| a.format(cum_state); a.format(state)} # apply formatting
      end

      (text || {}).merge((cum_state - initial_state).flags)
    end

    def self.import(obj) self.to_format(obj) end

    attr_accessor :event

    private

    def self.to_format(a)
      case
        when a.respond_to?(:to_RawFormat) then a.to_RawFormat
        when a.respond_to?(:to_s)         then Text.new(a.to_s)
        else
          raise 'Broked'
      end
    end

    def obj2nbt(obj)
      case
        when obj.respond_to?(:to_hash)
          '{%s}' % obj.to_hash.map{|k,v| "#{k}:#{obj2nbt(v)}"}.join(',')
        when obj.respond_to?(:each)
          '[%s]' % obj.map{|v| obj2nbt(v)}.join(',')
        else
          obj.to_s
      end
    end

    class State
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

      def-(other)       State.new(Hash[@flags.select {|k,v| other.flags[k] != v}]) end
      def merge(other)  State.new(@flags.merge(other.flags)) end
      def clone;        State.new(@flags.clone) end
    end


    class StartFormat < RawText_Base; end
    class EndFormat   < RawText_Base; end

    class StartBold           < StartFormat; def format(state) state.start_bold end end
    class EndBold             < EndFormat;   def format(state) state.end_bold end end
    class StartItalic         < StartFormat; def format(state) state.start_italic end end
    class EndItalic           < EndFormat;   def format(state) state.end_italic end end
    class StartObfuscated     < StartFormat; def format(state) state.start_obfuscated end end
    class EndObfuscated       < EndFormat;   def format(state) state.end_obfuscated end end
    class StartStrikeThrough  < StartFormat; def format(state) state.start_strikethrough end end
    class EndStrikeThrough    < EndFormat;   def format(state) state.end_strikethrough end end
    class StartUnderline      < StartFormat; def format(state) state.start_underline end end
    class EndUnderline        < EndFormat;   def format(state) state.end_underline end end

    class ColorFormat < RawText_Base
      attr_reader :color
      def initialize(color) @color = color.closest_text.text end
      def format(state)     state.color = @color end
    end

    class Text < RawText_Base
      attr_reader :text
      def initialize(text)  @text = SafeString.new(text) end
      def to_s;             @text.to_s end

      def format?;      false end
      def text?;        true end
    end
  end

  class ClickEvent < DelegateClass(RawText)
    protected

    def initialize(event) super(@text = RawText.new); @text.event = {clickEvent: event} end
  end

  class HoverEvent < DelegateClass(RawText)
    protected

    def initialize(event) super(@text = RawText.new); @text.event = {hoverEvent: event} end
  end

  class Insertion; end #TBD
  class Score; end # TBD
  class Selector; end # TBD
  class Translate; end # TBD



  class RunOnClick < ClickEvent
    def initialize(command) super(action: 'run_command', value: SafeString.new(command).quoted) end
  end

  class SuggestOnClick < ClickEvent
    def initialize(command) super(action: 'suggest_command', value: SafeString.new(command).quoted) end
  end

  class OpenUrlOnClick < ClickEvent
    def initialize(url) super(action: 'open_url', value: SafeString.new(url).quoted) end
  end

  class ChangePageOnClick < ClickEvent
    def initialize(page) super(action: 'change_page', value: page.to_i) end
  end

  class TextOnHover < HoverEvent
    def initialize(raw_text) super(action: 'show_text', value: RawText::import(raw_text)) end
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