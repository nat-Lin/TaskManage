module ApplicationHelper
  def notice_bootstrap_style
    flash.map do |key, value|
      concat(content_tag(:div, value, class: "alert alert-#{key}"))
    end
  end
end
