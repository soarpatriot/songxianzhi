class Photo < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true

  
  include Rails.application.routes.url_helpers
  mount_uploader :image, ImageUploader


  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
        "id"   => id,
        "name" => image.filename,
        "size" => image.size,
        "url" => image.url,
        "type" => image.content_type,
        "thumbnailUrl" => image.thumb.url,
        "deleteUrl" => "#{Settings.host}/photos/#{id}",
        "deleteType" => "DELETE"
    }
  end
end
