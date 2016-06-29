require 'gosu'

class GameOfLife

  LIFE = "*"
  DEATH = "-"

  def initialize width, height
    @width, @height = width, height
    @finished = false
    generateMatrix
  end

  def generateMatrix
   random = Random.new
   @matrix = Array(@width * @height)
   @width.times{|i|
     @height.times{|j|
       if i > 0 && i < @width - 1 && j > 0 && j < @height - 1
         if(random.rand(1.0) > 0.7)
            @matrix[i*@width + j] = LIFE
         else
           @matrix[i*@width + j] = DEATH
         end
       else
         @matrix[i*@width + j] = DEATH
       end
     }
   }
  end

  def update
    @width.times{|i|
     @height.times{|j|
        neighbours = neighbours(i,j)
        if neighbours < 2 || neighbours > 3
          @matrix[i*@width+j] = DEATH
        elsif neighbours == 3 && @matrix[i*@width + j]  ==LIFE
          @matrix[i*@width+j] = LIFE
        end
     }
   }
 end

 def getMatrix
   return @matrix
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

class BlockMatrix
  def initialize(life, death,blocksX, blocksY, x,y,width,height)
    @blocksX, @blocksY, @x, @y, @width, @height = blocksX, blocksY,x,y,width,height

    @life = Gosu::Image.new(life)
    @death = Gosu::Image.new(death)
    @blockSize = @life.width
    @blocks = Array(@blocksX * @blocksY)

    @blocksX.times{|i|
      @blocksY.times{|j|
        @blocks[i*@blocksX + j] = Gosu::Image.new(@img)
      }
   }
  end

  def makeMatrix gol
    matrix = gol.getMatrix
    @blocksX.times{|i|
      @blocksY.times{|j|
        if(matrix[i*@blocksX+j] == GameOfLife.LIFE)
          @blocks[i*@blocksX + j] = Gosu::Image.new(@life)
        else
          @blocks[i*@blocksX + j] = Gosu::Image.new(@death)
        end
      }
    }
  end

  def draw gol
      makeMatrix gol
      @blocksX.times{|i|
        @blocksY.times{|j|
          @blocks[i*@blocksX + j].draw_rot(i * @blockSize + @x, @blockSize * j+ @y,0,0)
        }
      }
  end

end

class GameWindow < Gosu::Window
  def initialize
    super 800, 600, true
    @debug = true
    self.caption = "Game"
    @font = Gosu::Font.new(20)

    @life = "img/life.png"
    @death = "img/death.png"
    @blockSize = 60
    @percentagew = width * 0.80
    @blocksX = (@percentagew / @blockSize).to_i
    @blocksY = (height/@blockSize).to_i
    @game = GameOfLife.new(@blocksX,@blocksY)
    @blockMatrix = BlockMatrix.new(@life,@death,@blocksX,@blocksY,width*0.15,@blockSize/2,@percentagew,height)

    updateTime

    @pause = false
    @before = false

  end

  def update
    if !@pause
      @game.update
      if(@currentTime >= @timeToReset)
        updateTime
      end
      @currentTime = Time.now.to_f
    end

    checkPause
    checkExit


  end

  def draw
    if @debug
    #Show fps
     @font.draw("fps: #{Gosu.fps} ", 0,height/100,ZOrder::UI, 0.75, 0.75, 0xff_ffff00)
     @font.draw("Stopped?: #{@pause? "Si":"No"} ", 0,20,ZOrder::UI, 0.75, 0.75, 0xff_ffffff)
   end
   @blockMatrix.draw game

  end

  def updateTime
    @currentTime =  Time.now.to_f
    @timeToReset = (Time.now.to_f + @blockGenerator.getSeconds)
  end

  def checkPause
    if @before && !(Gosu::button_down? Gosu::KbP)
      @before = false
    end
    if (Gosu::button_down? Gosu::KbP) && !@before
      @pause = !@pause
      puts "Pausing..."
      @before = true
    end
  end

  def checkExit
    if Gosu::button_down? Gosu::KbEscape
        abort("Exiting...")
    end
  end


end

window = GameWindow.new
window.show
