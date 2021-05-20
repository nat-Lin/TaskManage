module ApplicationHelper
  def notice_bootstrap_style
    flash.map do |key, value|
      concat(content_tag(:div, value, class: "alert alert-#{key}"))
    end
  end

  def display_login_or_logout
    if current_user
      content_tag(:span, current_user.name, class: 'navbar-text') +
      link_to('登出', session_path, method: :delete, class: 'nav-link')
    else
      link_to('註冊', new_register_path, class: 'nav-link') +
      link_to('登入', new_session_path, class: 'nav-link')
    end
  end

  def time_format(time)
    time.strftime("%Y/%m/%d %H:%M:%S")
  end
end
