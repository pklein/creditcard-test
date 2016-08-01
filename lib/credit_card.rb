module CreditCard

  class Application
    def self.generate_card_summary(input)
      cards = input.split('\n').map do |line|
        Card.new(line)
      end
      cards.map(&:to_s).join('\n')
    end
  end

  class Card
    def initialize card_str
      @card_number = card_str.gsub(/\s+/, '')
    end

    def to_s
      @card_number
    end
  end

end
