require 'rails_helper'

RSpec.describe "Store1s API", type: :request do
  let(:user) { User.create(email: "test@test.com", password: "123456") }

  describe "POST /store1s" do
    context "when user is logged in" do
      it "creates a store with owner" do
        # simulate login
        post "/login", params: { email: user.email, password: "123456" }

        post "/store1s", params: {
          store1: { title: "Test Store", address: "Delhi" }
        }

        expect(response).to have_http_status(:ok)

        store = Store1.last
        expect(store.title).to eq("Test Store")
        expect(store.owner_id).to eq(user.id)  # 🔥 important
      end
    end

    context "when user is not logged in" do
      it "returns unauthorized" do
        post "/store1s", params: {
          store1: { title: "Test Store", address: "Delhi" }
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /store1s (pagination)" do
    before do
      # login
      post "/login", params: { email: user.email, password: "123456" }

      # create stores
      5.times do |i|
        user.store1s.create(title: "Store #{i}", address: "Delhi")
      end
    end

    it "returns paginated stores" do
      get "/store1s", params: { page: 1, per_page: 2 }

      json = JSON.parse(response.body)

      expect(json["stores"].length).to eq(2)
      expect(json["meta"]["total_count"]).to eq(5)
      expect(json["meta"]["current_page"]).to eq(1)
    end

    it "returns only current user's stores" do
      other_user = User.create(email: "other@test.com", password: "123456")
      other_user.store1s.create(title: "Other Store", address: "Mumbai")

      get "/store1s", params: { page: 1, per_page: 10 }

      json = JSON.parse(response.body)

      titles = json["stores"].map { |s| s["title"] }

      expect(titles).not_to include("Other Store") # 🔥 security test
    end
  end
end