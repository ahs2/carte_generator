class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :fullname
      t.string :code
      t.string :link

      t.timestamps
    end
  end
end
