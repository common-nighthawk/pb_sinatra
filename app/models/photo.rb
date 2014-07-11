class Photo < ActiveRecord::Base
  mount_uploader :filepath, Uploader
end
