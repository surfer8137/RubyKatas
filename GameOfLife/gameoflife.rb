
class GameOfLife

  def initialize width, height
    @width, @height = width, height
    @finished = false
    @life = "*"
    @death = "-"
    generateMatrix

    while !@finished
      draw
    end
  end


  def generateMatrix
   random = Random.new
   @matrix = Array(@width * @height)
   @width.times{|i|
     @height.times{|j|
       if i > 0 && i < @width - 1 && j > 0 && j < @height - 1
         if(random.rand(1.0) > 0.7)
            @matrix[i*@width + j] = @life
         else
           @matrix[i*@width + j] = @death
         end
       else
         @matrix[i*@width + j] = @death
       end
     }
   }
  end

  def update
    @width.times{|i|
     @height.times{|j|
        neighbours = neighbours(i,j)
        if neighbours < 2 || neighbours > 3
          @matrix[i*@width+j] = @death
        elsif neighbours == 3 && @matrix[i*@width + j]  == @life
          @matrix[i*@width+j] = @life
        end
     }
   }
 end

 def draw
   @width.times{|i|
     @height.times{|j|
       print  @matrix[i*@width + j]
     }
     puts ""
  }
  puts ""
  update
  sleep 2.0
 end

 def neighbours(i,j)
     result = 0
     (i-1).upto(i+1){ |x|
       (j-1).upto(j+1){ |y|
         if (x >= 0 && y >= 0 && !(x==i && y==j) && x < @width && y < @height  && @matrix[x*@width + y] != nil && @matrix[x*@width + y] == @life)
           result += 1
         end
       }
     }
     return result
  end

 private :neighbours

end

GameOfLife.new(20,20)
