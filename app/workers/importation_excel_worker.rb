require "roo"

include Sidekiq::Worker

class ImportationExcelWorker
  def perform(import_card_archive_id)
    cards = []
    current_time = Time.now
    import_card_archive = Importation.find(import_card_archive_id)

    app_url = if Rails.env.production?
      "http://127.0.0.1:3000"
    else
      "http://localhost:3000"
    end

    xlsx = Roo::Spreadsheet.open("#{app_url}/#{import_card_archive.file_url}")

    card_archives = [] # Initialisation de la variable card_archives comme un tableau vide

    xlsx.each_with_pagename do |name, sheet|
      sheet.each_with_index do |hash, index|
        if index != 0
          fullname = hash[0]
          link = hash[1]
          # code = hash[2]

          card_archives << {
            fullname: fullname,
            link: link,
            # code: code,
            created_at: current_time,
            updated_at: current_time
          }
        end
      end
    end

    ActiveRecord::Base.transaction do
      Card.insert_all!(card_archives)
    end
  end
end
