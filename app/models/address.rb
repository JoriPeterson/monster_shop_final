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

	def shipped_orders
    orders.where(status: 'shipped').pluck(:address_id)
  end

	def been_shipped_to?(address)
		address.shipped_orders.include?(address.id)
	end
end
