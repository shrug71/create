# app/controllers/admins_controller.rb

=begin
class AdminsController < ApplicationController
  before_action :authenticate_user!

  # Other actions...

  def new_cafe
    @cafe = Cafe.new
  end

  def create_cafe
    @cafe = Cafe.new(cafe_params)

    if @cafe.save
      # Generate a random password for the cafe owner
      password = Devise.friendly_token.first(8)

      # Create a cafe owner (you might need to adjust this based on your setup)
      cafe_owner = User.new(
        email: @cafe.email,
        password: password,
        role: 'CafeOwner'
      )

      if cafe_owner.save
        # Send an email with credentials to the cafe owner
        UserMailer.cafe_owner_credentials(cafe_owner, password).deliver_now

        redirect_to admin_dashboard_path, notice: 'Cafe created successfully, and credentials sent to the cafe owner.'
      else
        render :new_cafe
      end
    else
      render :new_cafe
    end
  end

  # Other actions...

  private

  def cafe_params
    params.require(:cafe).permit(:name, :address, :phone, :email, :pin_code)
  end
end
=end