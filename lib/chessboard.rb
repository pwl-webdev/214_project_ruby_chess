class Chessboard
	attr_accessor :board
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
	end
end