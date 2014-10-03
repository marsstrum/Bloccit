class Topic < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	scope :visible_to, -> (user) { user ? all : publicly_viewable }
	#scope :public, -> { where(public: true) }


	def self.publicly_viewable
		where public: true
	end

	def self.privately_viewable
		where public: false
	end

end
