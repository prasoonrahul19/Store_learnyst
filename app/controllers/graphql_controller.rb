class GraphqlController < ApplicationController
  before_action :authenticate_user!

  def execute
    result = StoreSchema.execute(   # 🔥 FIXED HERE
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: {
        current_user: current_user
      },
      operation_name: params[:operationName]
    )

    render json: result
  end

  private

  def ensure_hash(param)
    case param
    when String
      param.present? ? JSON.parse(param) : {}
    when Hash, ActionController::Parameters
      param
    else
      {}
    end
  end
end