class DropTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :answers
    drop_table :questions
  end
end
