class Income < ApplicationRecord
	has_many :comments, :as => :commentable
end
