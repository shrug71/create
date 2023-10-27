=begin
class Api::V1::Users::SessionsController < Devise::SessionsController
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user, except: [:create]
  before_action :sign_in_user, except: [:create]
  skip_before_action :verify_authenticity_token

  def create
    byebug
    @resource = User.find_by(email: login_params[:email])
    

    if @resource && @resource.valid_password?(login_params[:password])
      sign_in(:user, @resource)
      log_in_success
    else
      log_in_error('Invalid email or password')
    end
  end
   
  def destroy
    byebug
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield if block_given?

    if signed_out
      render json: { message: 'Logged out successfully.' }, status: :ok
    else
      render json: { message: 'Logged out failure.' }, status: :unauthorized
    end
  end

  private

  def log_in_success
    byebug
    render json: { message: 'Logged in successfully.', user: @resource }, status: :ok
  end

  def log_in_error(message)
    render json: { message: message }, status: :unauthorized
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    byebug
    sign_out(current_user)
    render json: { message: 'Logged out successfully.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
=end
class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  attr_reader :resource
  
  def create
      binding.pry
    @resource = User.find_by!(email: login_params[:email])
    @resource.errors.add(:base, 'Wrong Password') unless @resource.try(:valid_password?, login_params[:password])
    return log_in_error unless @resource.errors.blank?

    sign_in(:user, @resource)
    log_in_success
  end

  private

  def log_in_success
    render json: { message: 'Logged.' }, status: :ok
  end

  def log_in_error
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end