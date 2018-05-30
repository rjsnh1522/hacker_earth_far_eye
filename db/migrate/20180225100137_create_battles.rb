class CreateBattles < ActiveRecord::Migration[5.1]
  def change
    create_table :battles do |t|

		t.string  :name
		t.integer :year
		t.integer :battle_number 
		t.string  :attacker_king 
		t.string  :defender_king
		t.string  :attacker_1
		t.string  :attacker_2
		t.string  :attacker_3 
		t.string  :attacker_4 
		t.string  :defender_1 
		t.string  :defender_2 
		t.string  :defender_3 
		t.string  :defender_4 
		t.string  :attacker_outcome 
		t.string  :battle_type 
		t.integer :major_death 
		t.integer :major_capture 
		t.string  :attacker_size 
		t.string  :defender_size  
		t.string  :attacker_commander
		t.string  :defender_commander
		t.string  :summer
		t.string  :location
		t.string  :region
		t.text	  :note
		t.integer :rating, default: 0
		t.timestamps
    end
  end
end
