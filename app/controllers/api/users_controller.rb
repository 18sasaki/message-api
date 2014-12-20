class Api::UsersController < Api::ApiBaseController
  def register
    if User.find_by(user_id: params[:user_id])
      result  = 'false'
      message = "'#{params[:user_id]}' was already used ! Please chenge others..."
    else
      salt     = Digest::SHA1.hexdigest("salt-#{Time.now}")
      password = Digest::SHA1.hexdigest("#{salt}--#{params[:password]}--}")

      user = User.new(user_id: params[:user_id], password: password, salt: salt, user_type: params[:user_type])
      user.save!
      result = 'true'
    end
  rescue
    result  = 'false'
    message = 'raise some error !'
  ensure
    render json: {result: result, message: message}
  end

  def login
    user = User.find_by(user_id: params[:user_id])
    if user.password == Digest::SHA1.hexdigest("#{user.salt}--#{params[:password]}--}")
      result = 'true'
    else
      result = 'false'
    end
  rescue
    result = 'false'
  ensure
    render json: {result: result}
  end
end
