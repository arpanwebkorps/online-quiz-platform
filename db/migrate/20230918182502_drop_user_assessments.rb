class DropUserAssessments < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_assessments
  end
end
