module PagesHelper
  def page_title(title)
    base_title = "Your Site Name"
    title.empty? ? base_title : "#{title} | #{base_title}"
  end
end
