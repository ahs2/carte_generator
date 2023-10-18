class Importation < ApplicationRecord
  has_one_attached :file
  validates :file, presence: true

  def file_url
    self.file.attached? ? Rails.application.routes.url_helpers.rails_blob_path(self.file, only_path: true) : ''
  end
end
