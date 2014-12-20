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
    Rails.logger.error ">>>>>>>>>>> error! : #{e}"
    result = 'false'
  ensure
    render json: {result: result}
  end

  def get
    store = Store.find_by(id: params[:id])
    ret_data = store.attributes
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.error ">>>>>>>>>>> error! : #{e}"
    ret_data = {}
  ensure
    render json: { store: ret_data }
  end

  def search
    limit = rand(1..5)
    stores = Store.all.limit(limit)

    ret_data = []
    stores.each do |store|
      ret_hash = {}
      store.attributes.each do |k, v|
        ret_hash[k] = (v || '')
      end
      ret_data << ret_hash
    end

    render json: { stores: ret_data }
  end
end
