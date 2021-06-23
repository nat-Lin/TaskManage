module UserHelper
  def display_come_back_to_admin_root
    if current_user.try('admin?')
      link_to '使用者管理', admin_root_path, class: 'btn btn-outline-secondary mx-1'
    end
  end

  def options_for_roles
    User.roles.keys.map { |key|
      [User.human_attribute_name(key), key]
    }
  end
end