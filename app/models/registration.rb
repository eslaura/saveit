class Registration < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, omniauth_providers: [:facebook]
  has_one :user


  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid) # find the provider on the user!
    registration  = Registration.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if registration # now if there is a registration, update !
      registration.update(email: user_params["email"])
      user_params.delete("email")
      registration.user.update(user_params)
    else # lets create!
      registration = Registration.new(email: user_params["email"])
      registration.password = Devise.friendly_token[0,20]  # Fake password for validation
      registration.save
      User.create!(registration_id: registration.id) # if there was no registration, lets create it and link it to a user!
    end

    return registration
  end
end
