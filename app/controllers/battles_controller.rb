class BattlesController < ApplicationController
	#for code review
	#elo rating system to provide rating for game of thrones kings



	def index
		@kings = King.all
	end

	def show
		if params[:id].present?
			king_name = King.find_by_king_name params[:id]
			@battle = Battle.where(attacker_king:king_name)
		end
	end

	def rate_this_war

		if params[:id].present?
			battle = Battle.where(battle_number:params[:id]).first
			if battle.present?
				elo_rating_algo(battle)
			end
		end
		redirect_back fallback_location: root_path

	end


	def elo_rating_algo(battle)
		n           = 400
		k_factor    = 32

		outcome     = battle.attacker_outcome
		attacker    = battle.attacker_king
		defender    = battle.defender_king

		att_rating  = king_current_rating(attacker)
		def_rating  = king_current_rating(defender)

		trans_formed_attack_rating = 10 ** ((att_rating/n))
		trans_formed_def_rating    = 10 ** ((def_rating/n))

		excpected_score_att = trans_formed_attack_rating/ (trans_formed_attack_rating + trans_formed_def_rating)
		excpected_score_def = trans_formed_def_rating/ (trans_formed_attack_rating + trans_formed_def_rating)

		score_temp     = distribute_score(outcome)

		score_attacker = score_temp["attack"]
		score_defender = score_temp["def"]

		update_rating_attack = att_rating.to_f + k_factor * (score_attacker - excpected_score_att)
		update_rating_def = def_rating.to_f + k_factor * (score_defender - excpected_score_def)

		begin
			update_current_rating(attacker,update_rating_attack)
			update_current_rating(defender,update_rating_def)
			flash[:notice] = "Rating updated"
		rescue Exception => e
			flash[:error] = "something went wrong"
		end
		

	end


	def king_current_rating(king)
		king = King.where(king_name:king).first
		rating = king.rating.present? ? king.rating : "400".to_f
	end

	def distribute_score(outcome)
			hash_val = {}

			if outcome == "win"
				hash_val["attack"] = 1
				hash_val["def"]    = 0
			elsif outcome == "loss"
				hash_val["attack"] = 0
				hash_val["def"]    = 1
			else
				hash_val["attack"] = 0.5
				hash_val["def"]    = 0.5
			end

			return hash_val
	end

	def update_current_rating(king,update_rating)
		king = King.where(king_name:king).first
		king.update_attributes(rating:update_rating)
	end


end









