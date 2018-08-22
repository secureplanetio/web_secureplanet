class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image,
                    styles: {thumb: '100x100>'},
                    path: ":image_file_dir/:basename.:extension",
                    default_url: nil
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  Paperclip.interpolates :image_file_dir do |attachment, style|
    attachment.instance.image_file_dir
  end

  def store_dir
    "data/user/#{self.user.id}/profile_image"
  end

  def image_file_dir
    "#{Dir.home}/#{Settings.path.project_root}/#{store_dir}"
  end
end
