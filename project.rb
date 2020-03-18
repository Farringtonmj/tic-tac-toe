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

        @xWin = false
        @oWin = false

        @pos = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        @drwspts= [80, 20, 265, 20, 445, 20, 80, 165, 265, 165, 445, 165, 80, 310, 265, 310, 445, 310]
        
    end

    def needs_cursor?
        true
    end
            
    def update
        @mouse_x = mouse_x
        @mouse_y = mouse_y

        if Gosu.button_down? Gosu::MS_LEFT
            if @xTurn == true
                @xTurn = false
                if squareNumber(@mouse_x, @mouse_y) == 1
                    @pos[0] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 2
                    @pos[1] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 3
                    @pos[2] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 4
                    @pos[3] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 5
                    @pos[4] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 6
                    @pos[5] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 7
                    @pos[6] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 8
                    @pos[7] = 1
                elsif squareNumber(@mouse_x, @mouse_y) == 9
                    @pos[8] = 1
                end
            else
                @xTurn = true
            end
        end
    end





    def squareNumber(x, y)
        if x.between?(60, 190) && y.between?(30, 190)
            sqrnum = 1
        elsif x.between?(230, 410) && y.between?(30, 190)
            sqrnum = 2
        elsif x.between?(430, 610) && y.between?(30, 190)
            sqrnum = 3
        elsif x.between?(60, 190) && y.between?(195, 350)
            sqrnum = 4
        elsif x.between?(230, 410) && y.between?(195, 350)
            sqrnum = 5
        elsif x.between?(430, 610) && y.between?(195, 350)
            sqrnum = 6
        elsif x.between?(60, 190) && y.between?(355, 450)
            sqrnum = 7
        elsif x.between?(230, 410) && y.between?(355, 450)
            sqrnum = 8
        elsif x.between?(430, 610) && y.between?(355, 450)
            sqrnum = 9
        else 
            sqrnum = 0
        end
        return sqrnum
    end


    def win 
        if @pos[0] == 1  @pos[1] == 1  @pos[2] == 1
            @xWin = true
        elsif @pos[3] == 1 & @pos[4] == 1 & @pos[5] == 1
            @xWin = true
        elsif @pos[6] == 1 & @pos[7] == 1 & @pos[8] == 1
            @xWin = true
        elsif @pos[0] == 1 & @pos[3] == 1 & @pos[6] == 1
            @xWin = true
        elsif @pos[1] == 1 & @pos[4] == 1 & @pos[7] == 1
            @xWin = true
        elsif @pos[2] == 1 & @pos[5] == 1 & @pos[8] == 1
            @xWin = true
        elsif @pos[0] == 1 & @pos[5] == 1 & @pos[8] == 1
            @xWin = true
        elsif @pos[2] == 1 & @pos[5] == 1 & @pos[7] == 1
            @xWin = true
        elsif @pos[0] == 2 & @pos[1] == 2 & @pos[2] == 2
            @oWin = true
        elsif @pos[3] == 2 & @pos[4] == 2 & @pos[5] == 2
            @oWin = true
        elsif @pos[6] == 2 & @pos[7] == 2 & @pos[8] == 2
            @oWin = true
        elsif @pos[0] == 2 & @pos[3] == 2 & @pos[6] == 21
            @oWin = true
        elsif @pos[1] == 2 & @pos[4] == 2 & @pos[7] == 2
            @oWin = true
        elsif @pos[2] == 2 & @pos[5] == 2 & @pos[8] == 2
            @oWin = true
        elsif @pos[0] == 2 & @pos[5] == 2 & @pos[8] == 2
            @oWin = true
        elsif @pos[2] == 2 & @pos[5] == 2 & @pos[7] == 2
            @oWin = true
        end
    end
            
            





    def draw
        @background_image.draw(0,0,ZOrder::BACKGROUND, scale_x=1.1, scale_y =0.8)
        @font.draw_text("#{@pos[0]}, #{@pos[1]}, #{@pos[2]}, #{@pos[3]}, #{@pos[4]}, #{@pos[5]}, #{@pos[6]}, #{@pos[7]}, #{@pos[8]}", 20, 20, ZOrder::LETTERS, 1, 1, Gosu::Color::RED)
        @pos.size.times do |x|
            y = x*2
            if @pos[x] == 1 
                @font.draw_text("X", @drwspts[y], @drwspts[(y+1)], ZOrder::LETTERS, 9, 9, Gosu::Color::BLACK)
            # elsif @pos[x] == 2
            #     @font.draw_text("O", @drwspts[y], @drwspts[(y + 1)], ZOrder::LETTERS, 9, 9, Gosu::Color::BLACK)
            end
        end
        if @xWin
            @font.draw_text("X WINS!!!", 320, 240, ZOrder::LETTERS, 9, 9, Gosu::Color::BLACK)
        elsif @oWin
            @font.draw_text("O WINS!!!", 320, 240, ZOrder::LETTERS, 9, 9, Gosu::Color::BLACK)
        end        
    end
end



Tutorial.new.show