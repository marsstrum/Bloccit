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

	def markdown(text)
		renderer = Redcarpet::Render::HTML.new
		extensions = {fenced_code_blocks: true}
		redcarpet = Redcarpet::Markdown.new(renderer, extensions)
		(redcarpet.render text).html_safe
	end

end
