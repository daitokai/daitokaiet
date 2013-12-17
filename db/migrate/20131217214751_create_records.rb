class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user
      t.date :target_date
      t.decimal :weight

      t.timestamps
    end
  end
end
