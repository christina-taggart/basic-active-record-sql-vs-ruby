class Cohort < Database::Model
  self.attribute_names =  [:id, :name, :created_at, :updated_at]
  attr_reader :attributes, :old_attributes

  def students
    Student.where('cohort_id = ?', self[:id])
  end

  def add_students(students)
    students.each do |student|
      student.cohort = self
    end
    students
  end
end
