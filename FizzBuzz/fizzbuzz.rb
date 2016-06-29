
class FizzBuzz

  def initialize
    1.upto(100){ |i|
      if self.div3 i
        if self.div5 i
          puts "FizzBuzz"
        else
          puts "Fizz"
        end
      elsif self.div5 i
        puts "Buzz"
      else
        puts "#{i}"
      end
    }
  end

  def div3 number
    return (number % 3 == 0)
  end

  def div5 number
    return (number % 5 == 0)
  end

end

FizzBuzz.new
