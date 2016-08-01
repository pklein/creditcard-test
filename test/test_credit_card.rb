require 'minitest/autorun'
require 'credit_card'

class CreditCardTest < Minitest::Test

  def test_full_example
    full_input = [
      '4111111111111111',
      '4111111111111',
      '4012888888881881',
      '378282246310005',
      '6011111111111117',
      '5105105105105100',
      '5105 1051 0510 5106',
      '9111111111111111'
    ].join('\n')

    expected_output = [
      'VISA: 4111111111111111       (valid)',
      'VISA: 4111111111111          (invalid)',
      'VISA: 4012888888881881       (valid)',
      'AMEX: 378282246310005        (valid)',
      'Discover: 6011111111111117   (valid)',
      'MasterCard: 5105105105105100 (valid)',
      'MasterCard: 5105105105105106 (invalid)',
      'Unknown: 9111111111111111    (invalid)'
    ].join('\n')

    assert_equal expected_output, CreditCard::Application.generate_card_summary(full_input)
  end

  def test_whitespace_is_stripped
    assert_equal '4111111111111111', CreditCard::Card.new("4111 1111  1111  \t  1111").instance_variable_get(:@card_number)
  end

  def test_match_visa
    assert_equal 'VISA', CreditCard::Card.new("4111111111111111").instance_variable_get(:@type).to_s
  end

  def test_match_amex
    assert_equal 'AMEX', CreditCard::Card.new("378282246310005").instance_variable_get(:@type).to_s
  end

  def test_match_discover
    assert_equal 'Discover', CreditCard::Card.new("6011111111111117").instance_variable_get(:@type).to_s
  end

  def test_match_mastercard
    assert_equal 'MasterCard', CreditCard::Card.new("5105105105105100").instance_variable_get(:@type).to_s
  end

  def test_unknown_card_type
    assert_nil CreditCard::Card.new("9111111111111111").instance_variable_get(:@type)
  end
end
