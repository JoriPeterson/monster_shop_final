class Address < ApplicationRecord

  belongs_to :user
  has_many :orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  enum nickname: %w(Home Work School Other)

	def display
		"#{self.nickname}: #{self.name} #{self.address} #{self.city} #{self.state} #{self.zip}"
	end
end
