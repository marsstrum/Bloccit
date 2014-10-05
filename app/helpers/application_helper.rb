module ApplicationHelper
	def my_name  # added for html checkpoint assignment
	"David French"
	end

	def form_group_tag(errors, &block)
		if errors.any?
			content_tag :div, capture(&block), class: 'form-group has-error'
		else 
			content_tag :div, capture(&block), class: 'form-group'
		end
	end

	def errors_class(errors)
		if errors.any?
			'form-group has-error'
		else 
			'form-group'
		end
	end

def up_vote_link_classes(post)
		base = "glyphicon glyphicon-chevron-up "
		vote = current_user.voted(post)
		base += "voted" if vote && vote.up_vote?
		base
	end

	def down_vote_link_classes(post)
		base = "glyphicon glyphicon-chevron-down "
		vote = current_user.voted(post)
		base += "voted" if vote && vote.down_vote?
		base
	end

	def vote_link_classes(post,vdir) #this is not working
		if vdir = 'up'
			 "glyphicon glyphicon-chevron-up #{(current_user.voted(post) && current_user.voted(post).up_vote?) ? 'voted' : '' }"
		else
			"glyphicon glyphicon-chevron-down #{(current_user.voted(post) && current_user.voted(post).down_vote?) ? 'voted' : '' }"
		end
	end
end
