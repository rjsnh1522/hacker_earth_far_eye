class King < ApplicationRecord
	self.primary_key = "king_name"

	has_many :battles
end
