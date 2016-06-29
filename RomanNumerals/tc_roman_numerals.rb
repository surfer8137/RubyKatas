require_relative 'roman_numerals.rb'
require 'test/unit'

class TestRomanNumeral < Test::Unit::TestCase

  def test_roman_to_integer
    rn = RomanNumeral.new
    res = rn.toInteger("MMMMCMXCIX")
    assert_equal(true,res == 4999)
  end

  def test_interger_to_roman
    rn = RomanNumeral.new
    res = rn.toInteger("MCDXCVI")
    assert_equal(true,res == 1496)
  end


end
