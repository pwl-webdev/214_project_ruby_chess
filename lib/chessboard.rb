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
		when "\u2658", "\u265E"
			moveValid = validateKnight(input)
		when "\u2655", "\u265B"
			moveValid = validateQueen(input)
		when "\u2657", "\u265D"
			moveValid = validateBishop(input)
		when "\u2656", "\u265C"
			moveValid = validateRook(input)
		when "\u2654", "\u265A"
			moveValid = validateKing(input)
		end
		if moveValid
			updateBoard(input)
		end		
		return moveValid
	end
	def validatePawn(input)
		move = input.split("-")
		if move[0][0] == move[1][0]
			if (board[move[0]] == "\u2659" && move[1][1].to_i - move[0][1].to_i == 1) || (board[move[0]] == "\u265F" && move[1][1].to_i - move[0][1].to_i == -1)
				if board[move[1]] == "X"
					return true
				end
			end
		elsif (move[1][0].ord - move[0][0].ord).abs == 1
			if (board[move[0]] == "\u2659") && (move[1][1].to_i - move[0][1].to_i) == 1 && black_figures.include?(board[move[1]])
				return true
			elsif board[move[0]] == "\u265F" && (move[1][1].to_i - move[0][1].to_i) == -1 && white_figures.include?(board[move[1]])
				return true
			end	
		end
		return false
	end
	def validateKnight(input)
		move = input.split("-")
		x = move[0][0].ord
		y = move[0][1].to_i
		dx = (move[1][0].ord - move[0][0].ord)
		dy = (move[1][1].to_i - move[0][1].to_i)
		if (dx.abs == 2 && dy.abs == 1)
			if (board["#{(x + dx/2).chr}#{y.to_s}"] == "X" && board["#{(x + dx).chr}#{y.to_s}"] == "X") || (board["#{(x).chr}#{(y+dy).to_s}"] == "X" && board["#{(x+dx/2).chr}#{(y+dy).to_s}"] == "X")
				if board[move[0]] == "\u2658" && (black_figures.include?(board[move[1]]) || board[move[1]] == "X")	
					return true
				elsif board[move[0]] == "\u265E" && (white_figures.include?(board[move[1]]) || board[move[1]] == "X")
					return true
				end
			end
		elsif (dx.abs == 1 && dy.abs == 2)
			if (board["#{(x + dx).chr}#{y.to_s}"] == "X" && board["#{(x + dx).chr}#{(y+dy).to_s}"] == "X") || (board["#{(x).chr}#{(y+dy/2).to_s}"] == "X" && board["#{(x).chr}#{(y+dy).to_s}"] == "X")
				if board[move[0]] == "\u2658" && (black_figures.include?(board[move[1]]) || board[move[1]] == "X")	
					return true
				elsif board[move[0]] == "\u265E" && (white_figures.include?(board[move[1]]) || board[move[1]] == "X")
					return true
				end
			end
		end
		return false
	end
	def validateQueen (input)
		move = input.split("-")
		x = move[0][0].ord
		y = move[0][1].to_i
		dx = (move[1][0].ord - move[0][0].ord)
		dy = (move[1][1].to_i - move[0][1].to_i)
		valid = true
		if dx == 0
			#puts "dx == 0"
			(dy.abs-1).times do |l|
				#puts "dy #{dy} board: #{x.chr}#{(y+l+1).to_s} board2: #{x.chr}#{(y-l-1).to_s}"
				if board["#{x.chr}#{(y+l+1).to_s}"] != "X" && dy > 0
					valid = false
				elsif board["#{x.chr}#{(y-l-1).to_s}"] != "X" && dy < 0
					valid = false
				end	
			end
		elsif dy == 0
			#puts "dy == 0, dx #{dx} dx.abs #{(dx.abs)-1}"
			(dx.abs-1).times do |l|
				if board["#{(x+l+1).chr}#{(y).to_s}"] != "X" && dx > 0
					valid = false
				elsif board["#{(x-l-1).chr}#{(y).to_s}"] != "X" && dx < 0
					valid = false
				end	
			end
		elsif dx.abs == dy.abs
			#puts "dx == dy"
			(dy.abs - 1).times do |l|
				if board["#{(x+l+1).chr}#{(y+l+1).to_s}"] != "X" && dy > 0 && dx > 0
					valid = false
				elsif board["#{(x-l-1).chr}#{(y+l+1).to_s}"] != "X" && dy > 0 && dx < 0
					valid = false
				elsif board["#{(x-l-1).chr}#{(y-l-1).to_s}"] != "X" && dy < 0 && dx < 0
					valid = false
				elsif board["#{(x+l+1).chr}#{(y-l-1).to_s}"] != "X" && dy < 0 && dx > 0
					valid = false
				end	
			end
		else
			valid = false
		end	
		if valid
			if board[move[1]] == "X" || (board[move[0]] == "\u2655" && (black_figures.include?(board[move[1]])))
				return true
			elsif board[move[1]] == "X" || (board[move[0]] == "\u265B" && (white_figures.include?(board[move[1]])))
				return true
			end
		else
			return false
		end	
	end
	def validateBishop(input)
		move = input.split("-")
		x = move[0][0].ord
		y = move[0][1].to_i
		dx = (move[1][0].ord - move[0][0].ord)
		dy = (move[1][1].to_i - move[0][1].to_i)
		valid = true
		if dx.abs == dy.abs
			#puts "dx == dy"
			(dy.abs - 1).times do |l|
				if board["#{(x+l+1).chr}#{(y+l+1).to_s}"] != "X" && dy > 0 && dx > 0
					valid = false
				elsif board["#{(x-l-1).chr}#{(y+l+1).to_s}"] != "X" && dy > 0 && dx < 0
					valid = false
				elsif board["#{(x-l-1).chr}#{(y-l-1).to_s}"] != "X" && dy < 0 && dx < 0
					valid = false
				elsif board["#{(x+l+1).chr}#{(y-l-1).to_s}"] != "X" && dy < 0 && dx > 0
					valid = false
				end	
			end
		else
			valid = false
		end	
		if valid
			if board[move[1]] == "X" || (board[move[0]] == "\u2657" && (black_figures.include?(board[move[1]])))
				return true
			elsif board[move[1]] == "X" || (board[move[0]] == "\u265D" && (white_figures.include?(board[move[1]])))
				return true
			end
		else
			return false
		end	
	end
	def validateRook(input)
		move = input.split("-")
		x = move[0][0].ord
		y = move[0][1].to_i
		dx = (move[1][0].ord - move[0][0].ord)
		dy = (move[1][1].to_i - move[0][1].to_i)
		valid = true
		if dx == 0
			#puts "dx == 0"
			(dy.abs-1).times do |l|
				#puts "dy #{dy} board: #{x.chr}#{(y+l+1).to_s} board2: #{x.chr}#{(y-l-1).to_s}"
				if board["#{x.chr}#{(y+l+1).to_s}"] != "X" && dy > 0
					valid = false
				elsif board["#{x.chr}#{(y-l-1).to_s}"] != "X" && dy < 0
					valid = false
				end	
			end
		elsif dy == 0
			#puts "dy == 0, dx #{dx} dx.abs #{(dx.abs)-1}"
			(dx.abs-1).times do |l|
				if board["#{(x+l+1).chr}#{(y).to_s}"] != "X" && dx > 0
					valid = false
				elsif board["#{(x-l-1).chr}#{(y).to_s}"] != "X" && dx < 0
					valid = false
				end	
			end
		else
			valid = false
		end
		if valid
			if board[move[1]] == "X" || (board[move[0]] == "\u2656" && (black_figures.include?(board[move[1]])))
				return true
			elsif board[move[1]] == "X" || (board[move[0]] == "\u265C" && (white_figures.include?(board[move[1]])))
				return true
			end
		else
			return false
		end		
	end
	def validateKing(input)
		move = input.split("-")
		if (move[1][0].ord - move[0][0].ord).abs <= 1 && (move[1][1].to_i - move[0][1].to_i).abs <= 1
			if (board[move[0]] == "\u2654") && (black_figures.include?(board[move[1]]) || board[move[1]] == "X")
				return true
			elsif (board[move[0]] == "\u265A") && (white_figures.include?(board[move[1]]) || board[move[1]] == "X")
				return true
			end	
		end
		return false
	end
	def check?(input)
		check = false
		move = input.split("-")
		hypotetical_move = ""
		black_king = board.key("\u265A".encode("utf-8"))
		white_king = board.key("\u2654".encode("utf-8"))
		if black_figures.include?(board[move[1]])
			hypotetical_move = "#{move[1]}-#{white_king}"
		elsif white_figures.include?(board[move[1]])
			hypotetical_move = "#{move[1]}-#{black_king}"
		end
		case board[move[1]]
		when "\u2659", "\u265F"
			check = validatePawn(hypotetical_move)
		when "\u2658", "\u265E"
			check = validateKnight(hypotetical_move)
		when "\u2655", "\u265B"
			check = validateQueen(hypotetical_move)
		when "\u2657", "\u265D"
			check = validateBishop(hypotetical_move)
		when "\u2656", "\u265C"
			check = validateRook(hypotetical_move)
		when "\u2654", "\u265A"
			check = validateKing(hypotetical_move)
		end
		if check
			puts "check! #{hypotetical_move}"
		end
		return check
	end
	def mate?
		#puts board.key("\u265A".encode("utf-8"))
		#puts board.key("\u2654".encode("utf-8"))
		if board.key("\u265A".encode("utf-8")) == nil
			puts "Mate! Blacks lost"
			return true
		elsif board.key("\u2654".encode("utf-8")) == nil
			puts "Mate! Whites lost"
			return true
		else
			return false
		end
	end
	private
	def updateBoard(input)
		move = input.split("-")
		symbol = board[move[0]]
		board[move[1]] = symbol
		board[move[0]] = "X"
	end
end