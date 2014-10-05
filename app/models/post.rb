class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	belongs_to :user
	belongs_to :topic
	mount_uploader :image, ImageUploader

	#after_create :create_vote

	def up_votes
		votes.where(value: 1).count
	end

	def down_votes
		votes.where(value: -1).count
	end

	def points
		votes.sum(:value).to_i
	end

	default_scope { order('rank DESC')}
	scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

	validates :title, length: { minimum: 5 }, presence: true
	validates :body, length: { minimum: 20 }, presence: true
	validates :topic, presence: true
	validates :user, presence: true

	def markdown_title
		render_as_markdown title
	end

	def markdown_body
		render_as_markdown body
	end

	def update_rank
		age = (created_at - Time.new(1970,1,1)) / (60*60*24) # 1 day in seconds
		new_rank = points + age

		update_attribute(:rank, new_rank)
	end

	def create_vote
		user.votes.create( value: 1, post: self )
	end

	private

	def render_as_markdown(text)
		renderer = Redcarpet::Render::HTML.new
		extensions = {fenced_code_blocks: true}
		redcarpet = Redcarpet::Markdown.new(renderer, extensions)
		(redcarpet.render text).html_safe
	end

	

end
