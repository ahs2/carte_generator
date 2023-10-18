class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :firstname
      t.string :lastname
      t.string :link

      t.timestamps
    end
  end
end
