class Api::StoresController < Api::ApiBaseController
  def edit
    user  = User.find_by(user_id: params[:user_id])
    store = Store.find_by(user_id: user.id)

    store_params = ActionController::Parameters.new(params).permit(:user_id, :name, :address, :geo_data, :mail_address, :memo)
    edit_params  = store_params.merge(user_id: user.id)

    if store.present?
      store.update(edit_params)
    else
      store = Store.new(edit_params).save!
    end
    result = 'true'
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.warning ">>>>>>>>>>> error! : #{e}"
    result = 'false'
  ensure
    render json: {result: result}
  end
end
