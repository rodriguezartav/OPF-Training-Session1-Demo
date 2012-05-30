Spine = require('spine')

class Product extends Spine.Model
  @configure "Product" , "name" , "retailPrice" , "available"

  @extend Spine.Model.SelectableModel
  @extend Spine.Model.SocketModel
  
  @autoPush = true;
  
  @updateFromSocket: (message) =>
    for p in @all()
      if @appStarted
        p.available -=1;
        p.save()

  @mock: ->
    names = ["Nike Air Running Shoe", "Rebook Running Shoes" , "Leader Shoes" , "Nice Shirt", "Blue Shirt", "Red Shirt", "Green Long Sleeve Shirt" ,
    "Short Sleeve Shirt" , "BasketBall Shoes" , "Pro Running Shoes" ,"Amateur Running Shoes" , "Long Pants" , "Blue Pants" , "Short Pants" ,
    "Green & Blue Pants" , "Surfing Pants" , "Docker Pants" , "Nicer Shirt" , "Nike Shirt" , "Sportsman Shirt" , "Executive Leader Shoes" 
    , "Fake Leader Shoes" , "Crocodile Leader Shoes" , "Italian Leader Shoes" , "Spanish Vintage Shoes" , "Crocs" , "Havaiana Sandals" , "Normal Sandals"
    , "Woman Crocs"  ]
    for name in names
      Product.create
        name: name
        retailPrice: parseInt( Math.random() * 100 )
        available: parseInt( Math.random() * 100 )
  
  
  
module.exports = Product



 


   