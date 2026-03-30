class AddGuideEmailAtToStore1s < ActiveRecord::Migration[8.1]
  def change
    add_column :store1s, :guide_email_at, :datetime
  end
end
