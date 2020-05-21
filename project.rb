require 'gosu'

module ZOrder
    BACKGROUND, LETTERS, UI = *0..2
end

class Tutorial < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Tic-tac-toe"
        @background_image = Gosu::Image.new("t-t-t_board.jpg")

        @font = Gosu::Font.new(20)

        @mouse_x = mouse_x
        @mouse_y = mouse_y

        @xTurn = true

        @xWins = 0
        @oWins = 0
        @draws = 0
        @temp = 0
        @tempXWins = 0
        @tempOWins = 0
        @display = 0


        @pos = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        @drwspts= [80, 20, 265, 20, 445, 20, 80, 165, 265, 165, 445, 165, 80, 310, 265, 310, 445, 310]
    end

    def needs_cursor?
        true
    end

    def game_over
        if @pos[0] == 1 && @pos[1] == 1 && @pos[2] == 1
            @xWins += 1 
        elsif @pos[3] == 1 && @pos[4] == 1 && @pos[5] == 1
            @xWins += 1
        elsif @pos[6] == 1 && @pos[7] == 1 && @pos[8] == 1
            @xWins += 1 
        elsif @pos[0] == 1 && @pos[3] == 1 && @pos[6] == 1
            @xWins += 1 
        elsif @pos[1] == 1 && @pos[4] == 1 && @pos[7] == 1
            @xWins += 1 
        elsif @pos[2] == 1 && @pos[5] == 1 && @pos[8] == 1
            @xWins += 1 
        elsif @pos[0] == 1 && @pos[4] == 1 && @pos[8] == 1
            @xWins += 1
        elsif @pos[6] == 1 && @pos[7] == 1 && @pos[8] == 1
            @xWins += 1 
        elsif @pos[2] == 1 && @pos[4] == 1 && @pos[6] == 1
            @xWins += 1 
        elsif @pos[0] == 2 && @pos[1] == 2 && @pos[2] == 2
            @oWins += 1 
        elsif @pos[3] == 2 && @pos[4] == 2 && @pos[5] == 2
            @oWins += 1
        elsif @pos[6] == 2 && @pos[7] == 2 && @pos[8] == 2
            @oWins += 1 
        elsif @pos[0] == 2 && @pos[3] == 2 && @pos[6] == 2
            @oWins += 1 
        elsif @pos[1] == 2 && @pos[4] == 2 && @pos[7] == 2
            @oWins += 1 
        elsif @pos[2] == 2 && @pos[5] == 2 && @pos[8] == 2
            @oWins += 1 
        elsif @pos[0] == 2 && @pos[4] == 2 && @pos[8] == 2
            @oWins += 1
        elsif @pos[6] == 2 && @pos[7] == 2 && @pos[8] == 2
            @oWins += 1 
        elsif @pos[2] == 2 && @pos[4] == 2 && @pos[6] == 2
            @oWins += 1 
        end
        @pos.size.times do|x|
            if @pos[x] != 0
                @temp += 1
            end
            if @temp == 9 && @display == 0
                @draws += 1
                @pos = [0, 0, 0, 0, 0, 0, 0, 0, 0]
            end
        end
        @temp = 0

        if @tempXWins != @xWins
            @display = 1000000
        elsif @tempOWins != @oWins
            @display = 1000000
        end
        @tempXWins = @xWins
        @tempOWins = @oWins
    end

    def update
        @mouse_x = mouse_x
        @mouse_y = mouse_y
        game_over()

        if Gosu.button_down? Gosu::MS_LEFT
            if @xTurn
                if @pos[squareNumber(@mouse_x, @mouse_y)] == 0
                    @pos[squareNumber(@mouse_x, @mouse_y)] = 1
                    @xTurn = false
                end

            elsif !@xTurn
                if @pos[squareNumber(@mouse_x, @mouse_y)] == 0
                    @pos[squareNumber(@mouse_x, @mouse_y)] = 2
                    @xTurn = true
                end
            end
        end 
        while @display != 0
            if @display == 1
                @pos = [0, 0, 0,  0, 0, 0, 0, 0, 0]
            end
            @display -= 1
        end
    end

    def squareNumber(x, y)
        if x.between?(60, 190) && y.between?(30, 190)
            sqrnum = 0
        elsif x.between?(230, 410) && y.between?(30, 190)
            sqrnum = 1
        elsif x.between?(430, 610) && y.between?(30, 190)
            sqrnum = 2
        elsif x.between?(60, 190) && y.between?(195, 350)
            sqrnum = 3
        elsif x.between?(230, 410) && y.between?(195, 350)
            sqrnum = 4
        elsif x.between?(430, 610) && y.between?(195, 350)
            sqrnum = 5
        elsif x.between?(60, 190) && y.between?(355, 450)
            sqrnum = 6
        elsif x.between?(230, 410) && y.between?(355, 450)
            sqrnum = 7
        elsif x.between?(430, 610) && y.between?(355, 450)
            sqrnum = 8
        else 
            sqrnum = 9
        end
        return sqrnum
    end

    def draw
        @background_image.draw(0,0,ZOrder::BACKGROUND, scale_x=1.1, scale_y =0.8)
        # @font.draw_text("#{@pos[0]}, #{@pos[1]}, #{@pos[2]}, #{@pos[3]}, #{@pos[4]}, #{@pos[5]}, #{@pos[6]}, #{@pos[7]}, #{@pos[8]}", 20, 20, ZOrder::LETTERS, 1, 1, Gosu::Color::RED)
        # @font.draw_text("#{@xTurn}", 20, 70, ZOrder::LETTERS, 1, 1, Gosu::Color::RED)
        @pos.size.times do |x|
            y = x*2
            if @pos[x] == 1 
                @font.draw_text("X", @drwspts[y], @drwspts[(y+1)], ZOrder::LETTERS, 9, 9, Gosu::Color::BLACK)
            elsif @pos[x] == 2
                @font.draw_text("O", @drwspts[y], @drwspts[(y + 1)], ZOrder::LETTERS, 9, 9, Gosu::Color::BLACK)
            end
        end
        @font.draw_text("X: #{@xWins}", 20, 20, ZOrder::UI, 1, 1, Gosu::Color::BLACK)
        @font.draw_text("O: #{@oWins}", 60, 20, ZOrder::UI, 1, 1, Gosu::Color::BLACK)
        @font.draw_text("Draws: #{@draws}", 100, 20, ZOrder::UI, 1, 1, Gosu::Color::BLACK)
    end
end

Tutorial.new.show