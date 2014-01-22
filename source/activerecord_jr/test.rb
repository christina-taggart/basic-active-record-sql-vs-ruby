require_relative 'app'



describe Cohort do
  describe "#where" do
    it "should return an object of class Cohort" do
      cohort = Cohort.where('name = ?', 'Alpha').first
      cohort.class.should eq(Cohort)
      cohort.attributes[:name].should eq('Alpha')
    end
  end

  describe "#all" do
    it "should return an array of cohorts" do
      student_array = Cohort.all
      (student_array.empty?).should eq(false)
      student_array.count.should eq (10)
    end
  end

  describe "#save" do
    it "should save changes to the database" do
      cohort = Cohort.find(2)
      old_name = cohort[:name]
      cohort[:name] = 'Some Other Cohort'
      cohort.save
      Cohort.find(2)[:name].should eq ('Some Other Cohort')
      cohort[:name] = old_name
      cohort.save
    end
  end
end



describe Student do
  describe "#where" do
    it "should return a student of class Student" do
      student = Student.where('first_name = ?', 'Axel')
      student.class.should eq(Array)
    end
  end

  describe "#all" do
    it "should return an array of student objects" do
      students = Student.all
      (students.empty?).should eq(false)
      p students.count.should eq (2001)
    end
  end


  describe "#find" do
    it "should return the student if found in the database" do
      student = Student.find(1)
      student[:first_name].should eq ('Axel')
    end
  end

  describe "#save" do
    it "should save student information in the database" do
      student = Student.all.first
      old_first_name = student[:first_name]
      student[:first_name] = 'Ezekiel'
      student.save
      Student.find(student[:id])[:first_name].should eq ('Ezekiel')
      student[:first_name] = old_first_name
      student.save
      student[:first_name].should eq('Axel')
    end
  end
end

