class Address < ApplicationRecord

  belongs_to :user

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

	validates_uniqueness_of :address

  enum nickname: %w(Home Work School Other)
end
