class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.datetime :published_at
      t.text :body
      t.string :author_name
    end

    add_index :announcements, :published_at
  end
end
