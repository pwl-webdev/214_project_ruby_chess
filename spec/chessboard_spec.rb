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
			subject.display()
		end
	end
end