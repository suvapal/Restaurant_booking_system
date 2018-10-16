class Guest < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :email, uniqueness: true, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i }
	validates :phone, :numericality => true,
                 :length => { :minimum => 10, :maximum => 10 }
end
