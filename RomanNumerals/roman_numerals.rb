class RomanNumeral
  I = 1
  V = 5
  X = 10
  L = 50
  C = 100
  D = 500
  M = 1000

  def initialize
    @valueInt = 0
    @lastRoman = 0
  end


  def toInteger roman
    #Check roman is a string with only the roman numbers
    @valueInt = 0
    @lastRoman = 0
    return toIntegerArray (roman.scan /\w/)
  end

  def toIntegerArray array
    if array.empty?
      return @valueInt
    else
      currentRoman = RomanNumeral.const_get(array.pop)
      if currentRoman >= @lastRoman
        @valueInt += currentRoman
      else
        @valueInt -= currentRoman
      end
      @lastRoman = currentRoman
      toIntegerArray array
    end
  end

  def toRoman integer
    #Check roman is a string with only the roman numbers
    return toRomanArray ((integer.to_s.scan /\w/).reverse)
  end

  def toRomanArray array
    values = array.length
    valueString = ""
    if values > 0
      (valueString += (toRomanValues array[0].to_i, "I", "V","X").reverse)
    end
    values -= 1
    if values > 0
      (valueString += (toRomanValues array[1].to_i, "X", "L","C").reverse)
    end
    values -= 1
    if values > 0
      (valueString += (toRomanValues array[2].to_i, "C", "D","M").reverse)
    end
    values -= 1
    if values > 0
      (valueString += (toRomanValues array[3].to_i, "M", "(¬V)","(¬X)").reverse)
    end
    return valueString.reverse
  end

  def toRomanValues u, minus, middle, max
    if u == 0
      return ""
    end
    solution = ""
    if u < 5
      if u < 4
        u.to_i.downto(1){solution += minus}
      else
        solution += (minus + middle)
      end
    elsif u >= 5
      if u == 9
        solution += (minus + max)
      elsif u <= 9
        solution = middle
        u.downto(6){solution += minus}
      end
    end
    return solution
  end

  private :toIntegerArray, :toRomanArray, :toRomanValues

end
 
