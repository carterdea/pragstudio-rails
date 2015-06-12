class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.decimal :amount
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
