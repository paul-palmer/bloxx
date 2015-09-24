
module Bloxx

  def cast2raw(obj)
    if ([RawText, ClickEvent, HoverEvent].any?{|c| c === obj})
      obj
    else
      RawText.new.tap{|rt| rt << RawText.to_format(obj)}
    end
  end

  class MCBase
    def bits(v, bit_rng)
      (v & mask(bit_rng)) >> bit_rng.first
    end

    def bitset(v, bit_rng, new_bits)
      (v & ~mask(bit_rng)) | (new_bits << bit_rng.first)
    end

    def mask(bit_rng)
      ((1 << bit_rng.size) - 1) << bit_rng.first
    end

  end

  class Aspect < MCBase
    def initialize(hsh = {})  @hsh = hsh end

    def[](n)                  @hsh[n] end
    def[]=(n, v)              @hsh[n] = v end

    def empty?;               @hsh.all?{|_, v| value_empty?(v)} end

    def to_nbt;               self.empty? ? '' : "#{@hsh.map { |key, value| "#{key}:#{value}" unless value_empty?(value) }.compact.join(',')}"  end
    def to_s;                 self.to_nbt end

    private

    def value_empty?(v)
      v.nil? ||
          (v.empty? if v.respond_to?(:empty?)) ||
          v.to_s.empty?
    end
  end

  class List < MCBase
    include Enumerable

    def initialize(*structs)  @s = structs.flatten end
    def<<(struct)             @s << struct end
    def[](i)                  @s[i] end
    def[]=(i, v)              @s[i] = v end
    def to_nbt;               @s.compact.map(&:to_s).join(',') end
    def to_s;                 self.empty? ? '' : "[#{self.to_nbt}]" end
    def each;                 @s.each {|a| yield a} end
    def empty?;               @s.empty? end
  end

  class SafeString < MCBase
    def initialize(s) @s = s.to_s end

    def to_s;   (@s.tr_s!(UNSAFE_CHARS, UNSAFE_CHARS).nil?) ? @s : self.quoted end
    def quoted; %<"#{@s.gsub('"', '\"')}"> end

    private

    UNSAFE_CHARS = %<[]{},'" >
  end

  class Compound < MCBase
    def initialize(*aspects)
      @s = [@fields = Aspect.new] + aspects.flatten
    end

    def empty?;               @fields.empty? && @s.all?(&:empty?) end
    def to_s;                 "{#{self.to_nbt}}" end

    def to_nbt
      empty? ? '' : "#{@s.reject(&:empty?).map(&:to_s).reject(&:empty?).join(',')}"
    end

    protected

    def<<(aspect)             @s << aspect end
    def[](n)                  @fields[n] end
    def[]=(n, v)              @fields[n] = v end
    def delete(n)             @fields.delete(n) end
  end

end

class Fixnum
  def to_nbt; self.to_s end
end

class Float
  def to_nbt; self.to_s end
end