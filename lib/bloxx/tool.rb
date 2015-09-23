
module Bloxx

  class SetBlockCommand
    def initialize(entity, x = nil, y = nil, z = nil)
      @entity, @where = entity, [x, y, z].join(' ')
    end

    def to_s
      %<setblock #{@where} #{@entity.type} 0 replace #{@entity}>
    end
  end

  class SummonCommand
    def initialize(entity, x = '~', y = '~', z = '~')
      @entity, @where = entity, [nil, x, y, z].join(' ')
    end

    def to_s
      %<summon #{@entity.type}#{@where unless @where == ' ~ ~ ~'} #{@entity}>
    end
  end

  class ItemCommand
    def initialize(item, quantity = 1)
      @item, @quantity = item, quantity
    end

    def to_s
      %<i #{[@item.type, @item.subtype].compact.join(':')} #{@quantity} #{@item}>
    end
  end

end
