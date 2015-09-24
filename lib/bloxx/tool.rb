
module Bloxx

  class Command_Base
    protected

    def format(*args)
      args.compact.map(&:to_s).join(' ')
    end
  end

  class SetBlockCommand < Command_Base
    def initialize(entity, x = '~', y = '~', z = '~')
      @entity, @where = entity, [x, y, z].join(' ')
    end

    def to_s
      format('setblock',
             (@where unless @where == '~ ~ ~'),
             @entity.type,
             0,
             'replace',
             (@entity unless @entity.empty?))
    end
  end

  class SummonCommand < Command_Base
    def initialize(entity, x = '~', y = '~', z = '~')
      @entity, @where = entity, [x, y, z].join(' ')
    end

    def to_s
      format('summon',
             @entity.type,
             (@where unless @where == '~ ~ ~'),
             (@entity unless @entity.empty?))
    end
  end

  class ItemCommand < Command_Base
    def initialize(item, quantity = 1)
      raise 'ItemCommand requires an item' unless Item === item
      @item, @quantity = item, quantity
    end

    def to_s
      format('i',
             [@item.type, @item.subtype].compact.join(':'),
             @quantity,
             (@item unless @item.empty?))
    end
  end

end
