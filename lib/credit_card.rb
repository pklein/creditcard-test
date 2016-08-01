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
        @valid = satisfies_luhn_check?
      end
    end

    def to_s
      type = @type ? @type.to_s : 'Unknown'
      "#{type}: #{@card_number} #{@valid ? '(valid)' : '(invalid)'}"
    end

    private

    def satisfies_luhn_check?
      # reversing the arrand and adding the index to the collection so that we can determine which digits need the special logic applied.
      num_array_with_index = @card_number.reverse.chars.map(&:to_i).each_with_index
      digit_sum = num_array_with_index.reduce(0) {|sum, (x, index)|
        digit_val = x
        # every 2nd digit needs to be doubled and it's resulting digits to be added together
        if index % 2 == 1
          # using mod & integer division is sufficient. It's not possible to get numbers with more than 2 digits, so '/ 10' works.
          digit_val = x*2 % 10 + x*2 / 10
        end
        sum + digit_val
      }
      digit_sum % 10 == 0
    end
  end

end
