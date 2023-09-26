class DropCodingQuestionsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :codingquestions
  end
end
