class CreateStudentCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :student_courses do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.timestamps
    end
  end
end
