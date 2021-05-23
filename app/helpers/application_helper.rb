module ApplicationHelper
  def notice_bootstrap_style
    flash.map do |key, value|
      concat(content_tag(:div, value, class: "alert alert-#{key}"))
    end
  end

  def display_login_or_logout
    if current_user
      content_tag(:div, nil, class: 'nav-item dropdown') do 
        link_to(current_user.name, '#', class: 'nav-link dropdown-toggle', data: {toggle:'dropdown'}) +
        content_tag(:div, nil, class: 'dropdown-menu dropdown-menu-right border-dark border-0' ) do
          link_to('任務管理', tasks_path, class: 'dropdown-item') +
          link_to('Tag 管理', tags_path, class: 'dropdown-item') +
          link_to('登出', session_path, method: :delete, class: 'dropdown-item')
        end
      end
    else
      link_to('註冊', new_register_path, class: 'nav-link') +
      link_to('登入', new_session_path, class: 'nav-link')
    end
  end

  def time_format(time)
    time.strftime("%Y/%m/%d %H:%M:%S")
  end
end
