module ApplicationHelper

  def base_title
    'Clobber on Rails'
  end

  def title
    if @title.nil?
      raw base_title
    else
      raw "#{base_title} &raquo; #{@title}"
    end
  end

end
