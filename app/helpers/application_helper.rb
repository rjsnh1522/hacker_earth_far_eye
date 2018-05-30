module ApplicationHelper


	def get_number_of_battles(king_name)
			number_of_battles = Battle.attack_count(king_name) + Battle.defense_count(king_name)
	end
	def battle_won(king_name)
		won_attack = Battle.where(attacker_king: king_name).where(attacker_outcome:'win').count
		won_def    = Battle.where(defender_king:king_name).where.not(attacker_outcome:'win').count
		total_won = won_attack + won_def
	end

	def battle_lost(king_name)
		lost_attack = Battle.where(attacker_king: king_name).where(attacker_outcome:'loss').count
		lost_def    = Battle.where(defender_king:king_name).where(attacker_outcome:'win').count
		total_lost = lost_attack + lost_def

	end

	def get_current_rating(king_name)
		king = King.where(king_name: king_name).first
		rating = king.rating
		rating.present? ? rating : "0"
	end

	def king_current_rating(king)
		king = King.where(king_name:king).first
		rating = king.rating.present? ? king.rating : "400".to_f
	end
	
end
