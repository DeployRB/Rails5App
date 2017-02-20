class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.string  :title
      t.text    :content

      t.timestamps
    end
  end
end
