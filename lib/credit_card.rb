module CreditCard

  class Application
    def self.generate_card_summary(input)
      cards = input.split('\n').map do |line|
        Card.new(line)
      end
      cards.map(&:to_s).join('\n')
    end
  end

  class CreditCardType
    def initialize name, valid_prefixes, valid_number_lengths
      @name = name
      @valid_prefixes = valid_prefixes
      @valid_number_lengths = valid_number_lengths
    end

    def matches? card_number
      return is_valid_length?(card_number) && has_valid_prefix?(card_number)
    end

    def to_s
      @name
    end

    private

    def is_valid_length? card_number
      @valid_number_lengths.include?(card_number.length)
    end

    def has_valid_prefix? card_number
      !!@valid_prefixes.find {|prefix| card_number.start_with? prefix.to_s}
    end
  end

  class Card
    CARD_TYPES = {
      :amex =>       CreditCardType.new('AMEX',       [34,37],       [15]),
      :discover =>   CreditCardType.new('Discover',   [6011],        [16]),
      :mastercard => CreditCardType.new('MasterCard', (51..55).to_a, [16]),
      :visa =>       CreditCardType.new('VISA',       [4],           [13,16])
    }

    def initialize card_str
      @card_number = card_str.gsub(/\s+/, '')
      if @card_number =~ /^\d+$/
        @type = CARD_TYPES.values.find {|type| type.matches? @card_number}
      end
    end

    def to_s
      @card_number
    end
  end

end
