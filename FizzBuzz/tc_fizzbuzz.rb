require_relative 'fizzbuzz.rb'
require 'test/unit'

class TestFizzBuzz < Test::Unit::TestCase 
  def test_number_is_div3
    #Arrange
    a = 3
    b = 4
    #Act
    resA = FizzBuzz.div3(a)
    resB = FizzBuzz.div3(b)
    #Assert
    assert_equal(true, resA)
    assert_equal(false, resB)
  end

  def test_number_is_div5
    #Arrange
    a = 5
    b = 6
    #Act
    resA = FizzBuzz.div5(a)
    resB = FizzBuzz.div5(b)
    #Assert
    assert_equal(true, resA)
    assert_equal(false, resB)
  end
end
