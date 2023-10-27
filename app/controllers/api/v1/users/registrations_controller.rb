=begin
module Api
  module V1
    module Users
      class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
        skip_before_action :verify_authenticity_token
        respond_to :json
        
      
        def create
           byebug
          build_resource(sign_up_params)

          if resource.save
            sign_in(resource_name, resource)
            render json: { message: 'User registration successful.', user: resource }
          else
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end  

        private

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
=end
class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: 'Signed up.' }
  end

  def register_failed
    render json: { message: 'Signed up failure.' }
  end
end
