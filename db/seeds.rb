# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
@brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
@jori = Merchant.create!(name: "Jori's Shop", address: '456 Market St', city: 'Denver', state: 'CO', zip: 80021)

@ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvGxD3T1X_Tj6TmmjO13TUT2cFrwws1XWUr9fzEVkyB6bo0dG2", active: true, inventory: 5 )
@giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
@hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://image.shutterstock.com/image-vector/cute-cartoon-baby-hippo-blue-260nw-249374395.jpg', active: true, inventory: 3 )
@mermaid = @megan.items.create!(name: 'Mermaid', description: "I'm a Mermaid!", price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqcxvYLwWzNuow5CApk94_-i26c27E6Muri6IW4rE8Sz1mWUfjkw', active: true, inventory: 13 )
@dragon = @megan.items.create!(name: 'Dragon', description: "I'm a Dragon", price: 2000, image: 'https://friendlystock.com/wp-content/uploads/2018/05/9-cute-dragon-breathing-fire-cartoon-clipart.jpg', active: true, inventory: 3 )
@fairy = @megan.items.create!(name: 'Fairy', description: "I'm a Fairy", price: 25, image: 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX6856065.jpg', active: true, inventory: 66 )
@warewolf = @brian.items.create!(name: 'Warewolf', description: "I'm a Warewolf", price: 600, image: 'http://www.how-to-draw-cartoons-online.com/image-files/cartoon-werewolf.gif', active: true, inventory: 13 )
@yeti = @brian.items.create!(name: 'Yeti', description: "I'm a Yeti", price: 34, image: 'https://i.pinimg.com/originals/6a/b9/77/6ab977b962e3fbb3c69de762bbb5c2bd.jpg', active: true, inventory: 34 )
@troll = @brian.items.create!(name: 'Troll', description: "I'm a Troll", price: 55, image: 'https://previews.123rf.com/images/memoangeles/memoangeles1404/memoangeles140400032/27907576-crazy-cartoon-troll-with-simple-gradients-all-in-a-single-layer.jpg', active: true, inventory: 20 )
@ghoul = @brian.items.create!(name: 'Ghoul', description: "I'm a Ghoul", price: 99, image: 'https://previews.123rf.com/images/cthoman/cthoman1509/cthoman150900869/44479554-a-cartoon-illustration-of-a-ghoul-with-a-big-mouth-full-of-sharp-teeth-.jpg', active: true, inventory: 3 )
@unicorn = @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 50, image: 'https://previews.123rf.com/images/refluo/refluo1801/refluo180100037/94512197-drunk-cartoon-unicorn-with-a-bottle-of-rainbow.jpg', active: false, inventory: 8 )
@zombie_duck = @jori.items.create!(name: 'Zombie Duck', description: "Brains, yum!", price: 50, image: 'https://i.etsystatic.com/13112868/d/il/de16fd/1780710131/il_340x270.1780710131_tkpn.jpg?version=0', active: false, inventory: 8 )

charter = User.create!(name: "Charter", email: "charter@gmail.com", password: "123", role: 0)
jori = User.create!(name: "Jori", email: "jori@gmail.com", password: "123", role: 1, merchant_id: @jori.id)
odie = User.create!(name: "Odie", email: "odie@gmail.com", password: "123", role: 1, merchant_id: @megan.id)
takota = User.create!(name: "Takota", email: "takota@gmail.com", password: "123", role: 1, merchant_id: @brian.id)
talus = User.create!(name: "Talus", email: "talus@gmail.com", password: "123", role: 2)

@address_1 = charter.addresses.create!(name: 'Charter', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
@address_2 = charter.addresses.create!(name: 'Mom & Dad', address: '888 Market St', city: 'Seattle', state: 'WA', zip: 90012, nickname: 3)
@order_1 = charter.orders.create!(status: "packaged", address_id: @address_1.id)
@order_2 = charter.orders.create!(status: "pending", address_id: @address_1.id)
@order_3 = charter.orders.create!(status: "shipped", address_id: @address_1.id)
@order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 5, fulfilled: true)
@order_item_2 = @order_2.order_items.create!(item: @unicorn, price: @unicorn.price, quantity: 2, fulfilled: true)
@order_item_3 = @order_3.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: false)
