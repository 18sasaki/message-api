class Api::UsersController < Api::ApiBaseController
  def register
    if User.find_by(user_id: params[:user_id])
      result  = 'false'
      message = "'#{params[:user_id]}' was already used ! Please chenge others..."
    else
      salt     = Digest::SHA1.hexdigest("salt-#{Time.now}")
      password = Digest::SHA1.hexdigest("#{salt}--#{params[:password]}--}")

      user_params = ActionController::Parameters.new(params).permit(:user_id, :user_type)

      user = User.new(user_params.merge({ password: password, salt: salt}))
      user.save!
      result = 'true'
    end
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.warning ">>>>>>>>>>> error! : #{e}"
    result  = 'false'
    message = 'raise some error !'
  ensure
    render json: {result: result, message: message}
  end

  def login
    user = User.find_by(user_id: params[:user_id])
    if user.password == Digest::SHA1.hexdigest("#{user.salt}--#{params[:password]}--}")
      result = 'true'
      user_type = user.user_type
    else
      result = 'false'
    end
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.warning ">>>>>>>>>>> error! : #{e}"
    result = 'false'
  ensure
    render json: {result: result, user_type: user_type}
  end
end
