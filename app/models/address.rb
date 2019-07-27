class Address < ApplicationRecord

  belongs_to :user

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  enum nickname: ['home', 'work', 'other']
end
