class AddAttachmentImageToInformation < ActiveRecord::Migration
  def self.up
    change_table :information do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :information, :image
  end
end
