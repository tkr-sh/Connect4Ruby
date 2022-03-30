win = false
board = ["-"]*42
turn = false
(   
    valid = true
    puts "The board:\n+=======+"
    (0...6).map{|i|puts "|"+board[7*i...7*(i+1)].join+"|"}
    puts "+=======+\nEnter the column for your pown, from 0 to 6:"
    x = gets.to_i
    if x < 0 || x > 6
        valid = false
        puts "This is extra bounds. Your number should be in [0;6]"
    else
        (0..6).map{|i|(['R','Y'].include? board[7*i + x]) ? ( (i==0) ? (puts "Error, this column is already full.";valid=false) : (board[7*i - 7 + x] = "RY"[(turn)?1:0]);break ) : ( (i==6) ? (board[35+x]="RY"[(turn)?1:0];break) : (z=0))}
    end
    
    # Verification for the win
    (0...6).map{|i| # Line
        win |= (board[7*i...7*(i+1)].join.include? ("RY"[(turn)?1:0])*4)?true:false
    }
    (0...7).map{|i| # Column
        win |= ((0...6).map{|j| board[i+7*j]}.join.include? ("RY"[(turn)?1:0])*4)?true:false
    }
    (0...4).map{|i|
        (0...3).map{|j|
            win |= [board[i*7+j],board[(i+1)*7+j+1],board[(i+2)*7+j+2],board[(i+3)*7+j+3]].join.include? ("RY"[(turn)?1:0])*4;
            win |= [board[(i+3)*7+j],board[(i+2)*7+j+1],board[(i+1)*7+j+2],board[i*7+j+3]].join.include? ("RY"[(turn)?1:0])*4;
        }
    }

    if win
        puts "GG. Player "+((turn)? "2":"1") +" won!"
    end

    if (!board.join.include? "-") && !win
        puts "Tie!"
        win = true
    end

    turn = (valid)? !turn:turn
) while !win
