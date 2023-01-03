class ApplicationController < ActionController::API
  def allow_access?
    if current_user.elf? || current_user.dead?
      true
    else
      false
    end
  end
end
