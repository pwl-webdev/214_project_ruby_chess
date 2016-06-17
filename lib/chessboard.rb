class Chessboard
	attr_accessor :board, :white_figures, :black_figures
	def initialize()
		@board = Hash.new()
		#initializing whites
		board["A1"] = "\u2656".encode("utf-8")
		board["H1"] = "\u2656".encode("utf-8")
		board["B1"] = "\u2658".encode("utf-8")
		board["G1"] = "\u2658".encode("utf-8")
		board["C1"] = "\u2657".encode("utf-8")
		board["F1"] = "\u2657".encode("utf-8")
		board["D1"] = "\u2655".encode("utf-8")
		board["E1"] = "\u2654".encode("utf-8")
		("A".."H").each do |l|
			board["#{l}2"] = "\u2659".encode("utf-8")
		end
		@white_figures = ["\u2656","\u2658","\u2657","\u2655","\u2654","\u2659"]
		#initializing blacks
		board["A8"] = "\u265C".encode("utf-8")
		board["H8"] = "\u265C".encode("utf-8")
		board["B8"] = "\u265E".encode("utf-8")
		board["G8"] = "\u265E".encode("utf-8")
		board["C8"] = "\u265D".encode("utf-8")
		board["F8"] = "\u265D".encode("utf-8")
		board["D8"] = "\u265B".encode("utf-8")
		board["E8"] = "\u265A".encode("utf-8")
		("A".."H").each do |l|
			board["#{l}7"] = "\u265F".encode("utf-8")
		end
		@black_figures = ["\u265C","\u265E","\u265D","\u265B","\u265A","\u265F"]
		# initializing blank spaces
		("A".."H").each do |l|
			(3..6).each do |n|
				board["#{l}#{n}"] = "X"
			end
		end
	end
	def display
		puts "   A B C D E F G H"
		(8).downto(1) do |n|
			print "#{n}  "
			("A".."H").each do |l|

				print board["#{l}#{n.to_s}"]
				print " "
			end
			print "  #{n}"
			puts ""
		end
		puts "   A B C D E F G H"
		puts ""
	end
	def makeMove(input)
		move = input.split("-")
		moveValid = false
		case board[move[0]]
		when "\u2659", "\u265F"
			moveValid = validatePawn(input)
		end
		return moveValid
	end
	def validatePawn(input)
		move = input.split("-")
		if move[0][0] == move[1][0]
			if (board[move[0]] == "\u2659" && move[1][1].to_i - move[0][1].to_i == 1) || (board[move[0]] == "\u265F" && move[1][1].to_i - move[0][1].to_i == -1)
				if board[move[1]] == "X"
					symbol = board[move[0]]
					board[move[1]] = symbol
					board[move[0]] = "X"
					return true
				end
			end
		elsif (move[1][0].ord - move[0][0].ord).abs == 1
			if (board[move[0]] == "\u2659") && (move[1][1].to_i - move[0][1].to_i) == 1 && black_figures.include?(board[move[1]])
				symbol = board[move[0]]
				board[move[1]] = symbol
				board[move[0]] = "X"
				return true
			elsif board[move[0]] == "\u265F" && (move[1][1].to_i - move[0][1].to_i) == -1 && white_figures.include?(board[move[1]])
				symbol = board[move[0]]
				board[move[1]] = symbol
				board[move[0]] = "X"
				return true
			end	
		end
		return false
	end
end