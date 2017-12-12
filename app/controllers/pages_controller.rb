class PagesController < ApplicationController
  skip_before_action :authenticate_registration!, only: [:home]

  def home
  end
end
