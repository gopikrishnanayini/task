class Expense < ApplicationRecord
	has_many :comments, :as => :commentable
end
