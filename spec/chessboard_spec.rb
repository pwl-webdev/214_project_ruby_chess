require 'spec_helper'
require 'chessboard'

describe Chessboard do
	subject do
		Chessboard.new()
	end
	context "After creating Chessboard object board is initialized and filled with pawns" do
		it "White pawns are in position" do
			expect(subject.board["A1"]).to eql("\u2656".encode("utf-8"))
			expect(subject.board["H1"]).to eql("\u2656".encode("utf-8"))
			expect(subject.board["B1"]).to eql("\u2658".encode("utf-8"))
			expect(subject.board["G1"]).to eql("\u2658".encode("utf-8"))
			expect(subject.board["C1"]).to eql("\u2657".encode("utf-8"))
			expect(subject.board["F1"]).to eql("\u2657".encode("utf-8"))
			expect(subject.board["D1"]).to eql("\u2655".encode("utf-8"))
			expect(subject.board["E1"]).to eql("\u2654".encode("utf-8"))
			("A".."H").each do |l|
				expect(subject.board["#{l}2"]).to eql("\u2659".encode("utf-8"))
			end
		end
		it "black pawns are in position" do
			expect(subject.board["A8"]).to eql("\u265C".encode("utf-8"))
			expect(subject.board["H8"]).to eql("\u265C".encode("utf-8"))
			expect(subject.board["B8"]).to eql("\u265E".encode("utf-8"))
			expect(subject.board["G8"]).to eql("\u265E".encode("utf-8"))
			expect(subject.board["C8"]).to eql("\u265D".encode("utf-8"))
			expect(subject.board["F8"]).to eql("\u265D".encode("utf-8"))
			expect(subject.board["D8"]).to eql("\u265B".encode("utf-8"))
			expect(subject.board["E8"]).to eql("\u265A".encode("utf-8"))
			("A".."H").each do |l|
				expect(subject.board["#{l}7"]).to eql("\u265F".encode("utf-8"))
			end	
		end
		it "empty places on chessboard are initialized as 'X'" do
			("A".."H").each do |l|
				(3..6).each do |n|
					expect(subject.board["#{l}#{n}"]).to eql("X")
				end
			end
		end
		it "displays chessboard correctly" do
			puts ""
			subject.display()
		end
	end
	context "Allowed pawn moves are performed and marked on board" do
		puts "Allowed pawn moves are performed and marked on board"
		it "moves pawn on board" do
			expect(subject.makeMove("E7-E6")).to be_truthy
			expect(subject.board["E6"]).to eql("\u265F".encode("utf-8"))
			expect(subject.board["E7"]).to eql("X")
			subject.display()
			
			expect(subject.makeMove("D2-D3")).to be_truthy
			expect(subject.board["D3"]).to eql("\u2659".encode("utf-8"))
			expect(subject.board["D2"]).to eql("X")	
			subject.display()

			expect(subject.makeMove("E6-E5")).to be_truthy
			expect(subject.board["E5"]).to eql("\u265F".encode("utf-8"))
			expect(subject.board["E6"]).to eql("X")
			subject.display()

			expect(subject.makeMove("D3-D4")).to be_truthy
			expect(subject.board["D4"]).to eql("\u2659".encode("utf-8"))
			expect(subject.board["D3"]).to eql("X")	
			subject.display()

			expect(subject.makeMove("E5-D4")).to be_truthy
			expect(subject.board["D4"]).to eql("\u265F".encode("utf-8"))
			expect(subject.board["E5"]).to eql("X")
			subject.display()
		end
	end
	context "Not Allowed pawn moves are not performed" do
		puts "Not Allowed pawn moves are not performed"
		it "does not allow incorrect pawn moves" do
			expect(subject.makeMove("E7-C6")).to be_falsey
			expect(subject.board["E7"]).to eql("\u265F".encode("utf-8"))
			expect(subject.board["C6"]).to eql("X")
			subject.display()

			expect(subject.makeMove("D2-D1")).to be_falsey
			expect(subject.board["D2"]).to eql("\u2659".encode("utf-8"))
			expect(subject.board["D1"]).to eql("\u2655".encode("utf-8"))
			subject.display()
		end
	end
	context "Allowed knight moves are performed" do
		it "moves knight on board" do
			expect(subject.makeMove("G7-G6")).to be_truthy
			subject.display()
			expect(subject.makeMove("G6-G5")).to be_truthy
			subject.display()
			expect(subject.makeMove("G8-H6")).to be_truthy
			expect(subject.board["H6"]).to eql("\u265E".encode("utf-8"))
			expect(subject.board["G8"]).to eql("X")
			subject.display()
			expect(subject.makeMove("H6-F5")).to be_truthy
			expect(subject.board["F5"]).to eql("\u265E".encode("utf-8"))
			expect(subject.board["H6"]).to eql("X")
			subject.display()

			expect(subject.makeMove("B2-B3")).to be_truthy
			subject.display()
			expect(subject.makeMove("B3-B4")).to be_truthy
			subject.display()
			expect(subject.makeMove("B1-C3")).to be_truthy
			expect(subject.board["C3"]).to eql("\u2658".encode("utf-8"))
			expect(subject.board["B1"]).to eql("X")
			subject.display()
			expect(subject.makeMove("C3-E4")).to be_truthy
			expect(subject.board["E4"]).to eql("\u2658".encode("utf-8"))
			expect(subject.board["C3"]).to eql("X")
			subject.display()
			expect(subject.makeMove("E4-G5")).to be_truthy
			expect(subject.board["G5"]).to eql("\u2658".encode("utf-8"))
			expect(subject.board["E4"]).to eql("X")
			subject.display()			
		end
	end
	context "Inorrect knight moves are not performed" do
		it "does not allow incorrect knight moves" do
			expect(subject.makeMove("G7-G6")).to be_truthy
			subject.display()
			expect(subject.makeMove("G6-G5")).to be_truthy
			subject.display()
			expect(subject.makeMove("G8-H6")).to be_truthy
			expect(subject.board["H6"]).to eql("\u265E".encode("utf-8"))
			expect(subject.board["G8"]).to eql("X")
			subject.display()

			expect(subject.makeMove("H6-H4")).to be_falsey
			subject.display()
			expect(subject.makeMove("H6-F7")).to be_falsey
			subject.display()

			expect(subject.makeMove("F7-F6")).to be_truthy
			expect(subject.makeMove("H6-F5")).to be_falsey
			expect(subject.makeMove("H6-G8")).to be_truthy
			subject.display()
		end
	end
end