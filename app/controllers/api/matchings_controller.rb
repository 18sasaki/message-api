class Api::MatchingsController < Api::ApiBaseController
  def reservation
    matching_params = ActionController::Parameters.new(params).permit(:customer_id, :store_id)

    if Matching.find_by(customer_id: matching_params[:customer_id], store_id: matching_params[:store_id], enable_flg: 1).present?
      result  = 'false'
      message = '既に予約済です'
    else
      Matching.new(matching_params.merge({enable_flg: 1})).save!
      result  = 'true'
      message = '予約に成功しました'
    end
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.error ">>>>>>>>>>> error! : #{e}"
    result  = 'false'
    message = '予約に失敗しました'
  ensure
    render json: { result: result, message: message }
  end

  def cancellation
    matching = Matching.find_by(id: params[:id])

    matching.update(enable_flg: 0)
    result  = 'true'
    message = '予約を取り消しました'
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.error ">>>>>>>>>>> error! : #{e}"
    result  = 'false'
    message = '予約の取り消しに失敗しました'
  ensure
    render json: { result: result, message: message }
  end

  def reservation_list
    mt = Matching.arel_table

    case params[:user_type]
    when '0'
      st = Store.arel_table

      condition = mt[:customer_id].eq(params[:user_id])
      join_conditions = mt.join(st).on(st[:id].eq(mt[:store_id])).join_sources
      select_columns = ['*', 'stores.name as name']
    when '1'
      ct = Customer.arel_table

      condition = mt[:store_id].eq(params[:user_id])
      join_conditions = mt.join(ct).on(ct[:id].eq(mt[:customer_id])).join_sources
      select_columns = ['*', 'customers.name as name']
    end

    matchings = Matching.select(*select_columns).where(condition.and(mt[:enable_flg].eq(1))).joins(join_conditions).order(mt[:id].desc)

    ret_data = matchings.map{ |matching| { name: matching.name } }
  rescue => e
    p ">>>>>>>>>>> error! : #{e}"
    Rails.logger.error ">>>>>>>>>>> error! : #{e}"
    ret_data = []
  ensure
    render json: { result: ret_data }
  end
end
