class Address < ApplicationRecord

  belongs_to :user

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  enum type: ['home', 'work', 'other']
end
