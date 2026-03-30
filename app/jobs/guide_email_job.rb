# class GuideEmailJob < ApplicationJob
    
#     queue_as :low_priority
  
#     def perform(store_id)

#         store = Store1.find_by(id: store_id)
  
#         return unless store   # ✅ safe (deleted case handle)
  
#         StoreMailer.guide_email(store).deliver_now
      
#     end
# end

class GuideEmailJob < ApplicationJob
    queue_as :low_priority
  
    def perform(store_id = nil)
      if store_id
        # 👉 send email
        store = Store1.find_by(id: store_id)
        return unless store
  
        Rails.logger.info "📧 Sending email to #{store.owner.email}"
  
        StoreMailer.guide_email(store).deliver_now
  
      else
        # 👉 cron logic
        Rails.logger.info "🔥 CRON JOB RUNNING"
  
        stores = Store1.where.not(guide_email_at: nil)
                       .where("guide_email_at <= ?", Time.current)
  
        stores.find_each do |store|
          GuideEmailJob.perform_later(store.id)  # ✅ now safe
          store.update(guide_email_at: nil)
        end
      end
    end
  end