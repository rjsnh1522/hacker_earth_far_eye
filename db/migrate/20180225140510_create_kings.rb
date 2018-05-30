class CreateKings < ActiveRecord::Migration[5.1]
  def change
    create_table :kings do |t|
    	t.string  :king_name
    	t.decimal :rating, precision: 10, scale: 2
      t.timestamps
    end
  end
end
