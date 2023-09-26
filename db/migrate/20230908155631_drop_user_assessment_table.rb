class DropUserAssessmentTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :assessment_tables
  end
end
