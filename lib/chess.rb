require_relative 'chessboard'

class Chess
	attr_accessor :chessboard
	def initialize
		@chessboard = Chessboard.new()
	end

	def gameLoop()
		white_turn = true
		while !chessboard.mate? do
			chessboard.display
			if white_turn
				puts "Whites: Make move in format A1-B2. Type 'load'/'save' if you wish"
				input = gets.chomp.upcase
				if inputValid?(input, white_turn)
					if chessboard.makeMove(input)
						white_turn = false
					end
					chessboard.check?(input)
				elsif input = "LOAD"
					loadGame
				elsif input = "SAVE"
					saveGame
				end
			else
				puts "Blacks: MMake move in format A1-B2. Type 'load'/'save' if you wish"
				input = gets.chomp.upcase
				if inputValid?(input, white_turn)
					if chessboard.makeMove(input)
						white_turn = true
					end
					chessboard.check?(input)
				elsif input = "LOAD"
					loadGame
				elsif input = "SAVE"
					saveGame
				end
			end
		end
	end

	def inputValid?(input, white_turn)
		valid = false
		move = input.split("-")
		if chessboard.board.key?(move[0]) && chessboard.board.key?(move[0])
			if white_turn && chessboard.white_figures.include?(chessboard.board[move[0]])
				valid = true
			elsif !white_turn && chessboard.black_figures.include?(chessboard.board[move[0]])
				valid = true
			end
		end
		return valid
	end

	def loadGame
	end
	def saveGame
	end
end

x = Chess.new()
x.gameLoop()