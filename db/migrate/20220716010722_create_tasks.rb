class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :complete, default: false
      t.references :list

      t.timestamps
    end
  end
end
