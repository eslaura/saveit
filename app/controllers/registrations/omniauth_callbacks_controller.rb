class Registrations::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    registration = Registration.find_for_facebook_oauth(request.env['omniauth.auth'])
    if registration.persisted?
      sign_in_and_redirect registration, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_registration_registration_url
    end
  end
end
