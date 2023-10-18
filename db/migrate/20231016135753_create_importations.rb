class CreateImportations < ActiveRecord::Migration[7.1]
  def change
    create_table :importations do |t|

      t.timestamps
    end
  end
end
