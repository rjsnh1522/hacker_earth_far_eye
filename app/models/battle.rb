class Battle < ApplicationRecord
	self.primary_key = 'battle_number'

	belongs_to :king

	scope :attack_count, -> (king_name) {where(attacker_king: king_name).count}
	scope :defense_count, -> (king_name) {where(defender_king: king_name).count}

end
