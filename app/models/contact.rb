require 'csv'

class Contact < ActiveRecord::Base
  validates_presence_of :name, :phone

  def self.to_csv
    CSV.generate(col_sep: "\t") do |csv|
        csv << ["name", "phone"]
        all.each do |contact|
          csv << [contact.name, contact.phone]
        end
    end
  end
end
