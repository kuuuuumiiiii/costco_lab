class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  private

  #新規登録後はマイページへ遷移、ログイン後はトップページの遷移のため各コントローラへafter_sigin_in_pathを使って記入
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :first_name,
        :last_name,
        :first_name_kana,
        :last_name_kana,
        :email,
        :encrypted_password,
        ]
        )
  end
end
