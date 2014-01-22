require 'rspec'
require_relative 'student.rb'
require_relative 'database_model.rb'
require_relative '../db/students.db'


describe Student  do
  describe "When I search for a student" do
    it 'should have a name' do
      expect(Student.find(1)[:first_name]).to eq 'Lavinia'
    end
  end


end