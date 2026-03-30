class Store1sController < ApplicationController

  def create
    store = current_user.store1s.create(
      store_params.merge(guide_email_at: 1.minute.from_now)
    )
   


    #cron sheduler way : 
    

    # 🔥 Added this line (delayed job)
    # GuideEmailJob.set(wait: 1.hour).perform_later(store.id)

    render json: store, status: :ok
  end

  def index
    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:per_page].present? ? params[:per_page].to_i : 10
  
    stores = current_user.store1s
                         .offset((page - 1) * per_page)
                         .limit(per_page)
              
    Rails.logger.info "Response : #{stores.to_json}"
    render json: {
      stores: stores,
      meta: {
        total_count: current_user.store1s.count,
        current_page: page
      }
    }
  end

  private

  def store_params
    params.require(:store1).permit(:title, :address , :guide_email_at)
  end
end