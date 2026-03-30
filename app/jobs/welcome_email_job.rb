class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(store_id)
    store = Store1.find(store_id)
    StoreMailer.welcome_email(store).deliver_now
  end
end