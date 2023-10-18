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
          firstname = hash[0]
          lastname = hash[1]
          link = hash[2]

          card_archives << {
            firstname: firstname,
            lastname: lastname,
            link: link,
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
