class StoreMailer < ApplicationMailer
    def welcome_email(store)
      @store = store
      mail(to: @store.owner.email, subject: "Welcome to our platform 🎉")
    end
    def guide_email(store)
        @store = store
        mail(to: @store.owner.email, subject: "Getting Started Guide 🚀")
      end
  end