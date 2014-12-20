class Api::CustomersController < Api::ApiBaseController
  def edit
    user  = User.find_by(user_id: params[:user_id])
    customer = Customer.find_by(user_id: user.id)

    customer_params = ActionController::Parameters.new(params).permit(:user_id, :name, :mail_address, :memo)
    edit_params  = customer_params.merge(user_id: user.id)

    if customer.present?
      customer.update(edit_params)
    else
      customer = Customer.new(edit_params).save!
    end
    result = 'true'
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.error ">>>>>>>>>>> error! : #{e}"
    result = 'false'
  ensure
    render json: {result: result}
  end
end
