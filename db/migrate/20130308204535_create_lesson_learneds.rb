class CreateLessonLearneds < ActiveRecord::Migration
  def change
    create_table :lesson_learneds do |t|
      t.date :lessonDate
      t.string :projectReference
      t.string :projectEngineer
      t.string :projectArchitect
      t.string :projectOwner
      t.string :division
      t.text :input

      t.timestamps
    end
  end
end
