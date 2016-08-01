module CreditCard

  class Application
    def self.generate_card_summary(input)
      output_lines = input.split('\n').map do |line|
        line
      end
      output_lines.join('\n')
    end
  end

end
