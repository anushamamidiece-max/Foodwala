-- ============================================================
--  FOODWALA - Database setup script (MySQL 8.x / 9.x)
--  Run this whole file in MySQL Workbench (Query tab -> Execute).
--  Creates schema: users, restaurants, menu_items, orders, order_items
--  Seeds: 50 restaurants, 300+ menu items, 1 demo user
--  Demo login: demo@foodwala.com / demo123
-- ============================================================
-- ============================================================
--  FOODWALA - Database setup script (MySQL 8.x / 9.x)
--  Run this whole file in MySQL Workbench (Query tab -> Execute).
--  Creates schema: users, restaurants, menu_items, orders, order_items
--  Seeds: 50 restaurants, 300+ menu items, 1 demo user
--  Demo login: demo@foodwala.com / demo123
-- ============================================================
CREATE DATABASE IF NOT EXISTS foodwala CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE foodwala;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    cuisines VARCHAR(150) NOT NULL,
    address VARCHAR(160) NOT NULL,
    image VARCHAR(300) NOT NULL,
    rating DECIMAL(3,1) NOT NULL DEFAULT 4.0,
    delivery_time INT NOT NULL DEFAULT 30,
    price_for_two INT NOT NULL DEFAULT 300,
    is_pure_veg TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    name VARCHAR(120) NOT NULL,
    description VARCHAR(255),
    price INT NOT NULL,
    is_veg TINYINT(1) NOT NULL DEFAULT 1,
    category VARCHAR(60) NOT NULL DEFAULT 'Menu',
    image VARCHAR(300),
    CONSTRAINT fk_menu_restaurant FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    restaurant_name VARCHAR(120) NOT NULL,
    total_amount INT NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    payment_mode VARCHAR(30) NOT NULL DEFAULT 'Cash on Delivery',
    status VARCHAR(30) NOT NULL DEFAULT 'PLACED',
    ordered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    item_name VARCHAR(120) NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_oitems_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Demo user: demo@foodwala.com / demo123 (password stored as SHA-256 hash)
INSERT INTO users (name, email, password, phone, address) VALUES
('Demo Foodie','demo@foodwala.com','d3ad9315b7be5dd53b31a273b3b3aba5defe700808305aa16a3062b76658a791','9876543210','221B, MG Road, Bengaluru');

-- ================= 50 RESTAURANTS =================
INSERT INTO restaurants (id, name, cuisines, address, image, rating, delivery_time, price_for_two, is_pure_veg) VALUES
(1, 'Biryani Blues','Biryani, North Indian','Koramangala 5th Block, Bengaluru','https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=900&q=60',4.5,30,399,0),
(2, 'Dosa Junction','South Indian, Breakfast','Jayanagar 4th Block, Bengaluru','https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=60',4.3,25,249,1),
(3, 'Burger Bro','Burgers, Fast Food','100 Feet Road, Indiranagar','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=60',4.2,20,349,0),
(4, 'Pizza Paradise','Pizza, Italian','HSR Layout Sector 2, Bengaluru','https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=60',4.1,30,449,0),
(5, 'Momo Magic','Momos, Chinese','Marathahalli, Bengaluru','https://images.unsplash.com/photo-1625398407796-82650a8c135f?auto=format&fit=crop&w=900&q=60',4.4,25,299,0),
(6, 'Roll Express','Rolls, Wraps, Fast Food','BTM Layout, Bengaluru','https://images.unsplash.com/photo-1529006557810-274b9b2fc783?auto=format&fit=crop&w=900&q=60',4.0,22,249,0),
(7, 'Spice Symphony','North Indian, Mughlai','Whitefield, Bengaluru','https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=900&q=60',4.6,35,599,0),
(8, 'Green Bowl','Healthy, Salads, Continental','MG Road, Bengaluru','https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=900&q=60',4.5,28,499,0),
(9, 'Sweet Symphony','Desserts, Bakery','Basavanagudi, Bengaluru','https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=60',4.7,30,399,1),
(10, 'Café Aroma','Cafe, Beverages, Snacks','Church Street, Bengaluru','https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=60',4.3,25,449,0);

INSERT INTO restaurants (id, name, cuisines, address, image, rating, delivery_time, price_for_two, is_pure_veg) VALUES
(11, 'Dragon Wok','Chinese, Asian','Bellandur, Bengaluru','https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=900&q=60',4.2,32,399,0),
(12, 'Tandoor Tales','Kebabs, North Indian, Tandoor','JP Nagar 2nd Phase, Bengaluru','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=60',4.4,35,649,0),
(13, 'Idli Factory','South Indian, Breakfast','Malleshwaram, Bengaluru','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=60',4.2,20,199,1),
(14, 'Pasta Point','Italian, Continental','Sarjapur Road, Bengaluru','https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=900&q=60',4.3,30,499,0),
(15, 'Taco Fiesta','Mexican, Fast Food','Koramangala 6th Block, Bengaluru','https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=900&q=60',4.1,28,449,0),
(16, 'Sushi San','Japanese, Sushi, Asian','Indiranagar, Bengaluru','https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=900&q=60',4.6,40,899,0),
(17, 'Kolkata Kathi Rolls','Rolls, Street Food','Rajajinagar, Bengaluru','https://images.unsplash.com/photo-1600850056064-a8b380df8395?auto=format&fit=crop&w=900&q=60',4.3,24,249,0),
(18, 'Lucknowi Nawab','Mughlai, Biryani','Frazer Town, Bengaluru','https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=900&q=60',4.5,38,549,0),
(19, 'Bombay Chaat Corner','Street Food, Chaat','Commercial Street, Bengaluru','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60',4.2,20,199,1),
(20, 'Kerala Kitchen','Kerala, South Indian','Electronic City, Bengaluru','https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=900&q=60',4.4,33,449,0);

INSERT INTO restaurants (id, name, cuisines, address, image, rating, delivery_time, price_for_two, is_pure_veg) VALUES
(21, 'Punjab Grill House','Punjabi, North Indian','Marathahalli, Bengaluru','https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=900&q=60',4.3,34,499,0),
(22, 'Wok This Way','Chinese, Thai','HSR Layout, Bengaluru','https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=900&q=60',4.1,30,399,0),
(23, 'The Sandwich Club','Sandwiches, Fast Food','Jayanagar, Bengaluru','https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=900&q=60',4.0,22,299,1),
(24, 'Filter Coffee House','Cafe, South Indian','Basavanagudi, Bengaluru','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=60',4.5,21,249,1),
(25, 'Creamy Affairs','Ice Cream, Desserts','Indiranagar, Bengaluru','https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=60',4.6,26,349,1),
(26, 'Andhra Ruchulu','Andhra, Biryani','BTM 2nd Stage, Bengaluru','https://images.unsplash.com/photo-1633945274405-b6c8069047b0?auto=format&fit=crop&w=900&q=60',4.4,31,399,0),
(27, 'Rajasthani Rasoi','Rajasthani, Thali, North Indian','Yelahanka, Bengaluru','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60',4.3,35,349,1),
(28, 'Seafood Saga','Seafood, Coastal','Whitefield, Bengaluru','https://images.unsplash.com/photo-1559742811-822873691df8?auto=format&fit=crop&w=900&q=60',4.5,40,799,0),
(29, 'Paratha Pavilion','North Indian, Parathas','Koramangala, Bengaluru','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60',4.1,27,299,0),
(30, 'Noodle Nation','Chinese, Pan-Asian','Bellandur, Bengaluru','https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=900&q=60',4.2,29,379,0);

INSERT INTO restaurants (id, name, cuisines, address, image, rating, delivery_time, price_for_two, is_pure_veg) VALUES
(31, 'Vada Pav Express','Street Food, Maharashtrian','Kempegowda Layout, Majestic','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60',4.0,18,149,1),
(32, 'Belgian Waffle Co.','Desserts, Waffles, Cafe','UB City, Bengaluru','https://images.unsplash.com/photo-1509365465985-25d11c17e812?auto=format&fit=crop&w=900&q=60',4.4,25,349,1),
(33, 'The Healthy Tiffin','Healthy, Meals, Salads','HSR Layout Sector 1, Bengaluru','https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=60',4.3,30,299,0),
(34, 'Kebabistan','Kebabs, Mughlai','Shivajinagar, Bengaluru','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=900&q=60',4.5,36,599,0),
(35, 'Amritsari Kulcha Co.','North Indian, Punjabi','Rajajinagar, Bengaluru','https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=900&q=60',4.2,26,279,1),
(36, 'Cheesy Does It','Pizza, Snacks','Koramangala, Bengaluru','https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=60',4.0,28,399,0),
(37, 'Madras Mess','South Indian, Meals','Jayanagar East, Bengaluru','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=900&q=60',4.3,24,299,1),
(38, 'Thai Basil','Thai, Asian','Indiranagar, Bengaluru','https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=900&q=60',4.4,37,549,0),
(39, 'Continental Club','Continental, Italian','Lavelle Road, Bengaluru','https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=900&q=60',4.5,38,699,0),
(40, 'Kadak Chai & Snacks','Beverages, Snacks','Brigade Road, Bengaluru','https://images.unsplash.com/photo-1546173159-315724a31696?auto=format&fit=crop&w=900&q=60',4.1,19,199,1);

INSERT INTO restaurants (id, name, cuisines, address, image, rating, delivery_time, price_for_two, is_pure_veg) VALUES
(41, 'Falafel House','Middle Eastern, Healthy','Frazer Town, Bengaluru','https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=900&q=60',4.2,28,399,0),
(42, 'Pancake Story','Cafe, Desserts','MG Road, Bengaluru','https://images.unsplash.com/photo-1598214886806-c87b84b7078b?auto=format&fit=crop&w=900&q=60',4.3,27,349,1),
(43, 'Ramen Ryu','Japanese, Ramen','Church Street, Bengaluru','https://images.unsplash.com/photo-1617093727343-374698b1b08d?auto=format&fit=crop&w=900&q=60',4.6,39,699,0),
(44, 'Gujarati Thali Ghar','Gujarati, Thali','Gandhinagar, Bengaluru','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60',4.4,32,329,1),
(45, 'Awadhi Handi','Mughlai, Biryani','Richmond Town, Bengaluru','https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=900&q=60',4.5,36,599,0),
(46, 'Udupi Grand','South Indian, Udupi','Malleshwaram 8th Cross, Bengaluru','https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=900&q=60',4.4,23,279,1),
(47, 'Wingman','Chicken, Fast Food, Wings','HSR Layout, Bengaluru','https://images.unsplash.com/photo-1600891964092-4316c288032e?auto=format&fit=crop&w=900&q=60',4.2,26,449,0),
(48, 'Smoothie Shack','Beverages, Healthy, Juices','Indiranagar, Bengaluru','https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=900&q=60',4.3,22,299,1),
(49, 'Doner Republic','Middle Eastern, Kebabs','Residency Road, Bengaluru','https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=900&q=60',4.1,31,449,0),
(50, 'Cupcake Lane','Bakery, Desserts','Kammanahalli, Bengaluru','https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=60',4.5,24,329,1);

-- ================= MENU ITEMS =================
INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(1,'Chicken Dum Biryani','Fragrant basmati slow-cooked with juicy chicken and signature spices',249,0,'Biryani','https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=900&q=60'),
(1,'Mutton Dum Biryani','Tender mutton layered with saffron rice, cooked on dum',329,0,'Biryani','https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=900&q=60'),
(1,'Veg Biryani','Garden-fresh veggies and basmati topped with fried onions',189,1,'Biryani','https://images.unsplash.com/photo-1633945274405-b6c8069047b0?auto=format&fit=crop&w=900&q=60'),
(1,'Paneer Tikka Biryani','Smoky paneer tikka layered with aromatic biryani rice',219,1,'Biryani','https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=900&q=60'),
(1,'Chicken 65','Crispy fried chicken tossed in spicy curry-leaf masala',199,0,'Starters','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=60'),
(1,'Double Ka Meetha','Classic Hyderabadi bread dessert soaked in saffron milk',99,1,'Desserts','https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=60'),
(1,'Raita & Mirchi Ka Salan','Cooling raita with tangy salan - the perfect biryani side',59,1,'Sides','https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=900&q=60'),
(2,'Masala Dosa','Golden crisp dosa with classic potato masala',99,1,'Dosas','https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=60'),
(2,'Mysore Masala Dosa','Dosa smeared with spicy red chutney and potato filling',119,1,'Dosas','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=60'),
(2,'Rava Dosa','Lacy semolina dosa served with coconut chutney',109,1,'Dosas','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=900&q=60'),
(2,'Paper Roast Dosa','Extra-long crispy roast dosa finished with ghee',129,1,'Dosas','https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=900&q=60'),
(2,'Idli Vada Combo','2 soft idlis + 1 crisp vada with sambar and chutneys',99,1,'Combos','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60'),
(2,'Thatte Idli (4 pc)','Plate-sized fluffy idlis with chutney and saagu',89,1,'Combos','https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=900&q=60'),
(2,'Filter Coffee','Freshly brewed South Indian filter kaapi',49,1,'Beverages','https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=60'),
(3,'Classic Veg Burger','Crunchy veg patty, lettuce and house sauce in a toasted bun',129,1,'Burgers','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=60'),
(3,'Paneer Crunch Burger','Crispy paneer patty with mint mayo and onions',159,1,'Burgers','https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=60'),
(3,'Chicken Cheese Burger','Juicy chicken patty loaded with melted cheese',179,0,'Burgers','https://images.unsplash.com/photo-1571091655789-405eb7a3a3a8?auto=format&fit=crop&w=900&q=60'),
(3,'BBQ Double Decker','Two grilled patties, smoky BBQ sauce and caramelised onions',229,0,'Burgers','https://images.unsplash.com/photo-1553979459-d2229ba7433b?auto=format&fit=crop&w=900&q=60'),
(3,'Peri Peri Fries','Skin-on fries dusted with fiery peri peri seasoning',99,1,'Sides','https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?auto=format&fit=crop&w=900&q=60'),
(3,'Chocolate Thick Shake','Rich chocolate shake topped with whipped cream',119,1,'Beverages','https://images.unsplash.com/photo-1546173159-315724a31696?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(4,'Margherita Pizza','Classic cheese and tomato with fresh basil',199,1,'Pizzas','https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=60'),
(4,'Farmhouse Pizza','Onion, capsicum, tomato and corn on a cheesy base',279,1,'Pizzas','https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=60'),
(4,'Paneer Tikka Pizza','Tandoori paneer tikka with onions and mint drizzle',299,1,'Pizzas','https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=900&q=60'),
(4,'BBQ Chicken Pizza','Smoky BBQ chicken with jalapenos and mozzarella',339,0,'Pizzas','https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?auto=format&fit=crop&w=900&q=60'),
(4,'Garlic Breadsticks','Buttery garlic breadsticks with cheesy dip',129,1,'Sides','https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=60'),
(4,'Choco Lava Cake','Warm cake with a molten chocolate centre',99,1,'Desserts','https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=60'),
(5,'Veg Steamed Momos (8 pc)','Soft momos stuffed with garden vegetables',119,1,'Momos','https://images.unsplash.com/photo-1625398407796-82650a8c135f?auto=format&fit=crop&w=900&q=60'),
(5,'Chicken Steamed Momos (8 pc)','Juicy minced chicken momos with spicy dip',149,0,'Momos','https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=900&q=60'),
(5,'Veg Fried Momos (8 pc)','Golden-fried momos with schezwan chutney',139,1,'Momos','https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?auto=format&fit=crop&w=900&q=60'),
(5,'Chicken Fried Momos (8 pc)','Crispy fried chicken momos, house special',169,0,'Momos','https://images.unsplash.com/photo-1512152272829-e3139592d56f?auto=format&fit=crop&w=900&q=60'),
(5,'Tandoori Momos','Char-grilled momos coated in tandoori masala',179,0,'Momos','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=900&q=60'),
(5,'Veg Thukpa','Hearty Himalayan noodle soup with veggies',149,1,'Soups','https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=900&q=60'),
(6,'Paneer Tikka Roll','Smoky paneer tikka wrapped in flaky paratha',129,1,'Rolls','https://images.unsplash.com/photo-1529006557810-274b9b2fc783?auto=format&fit=crop&w=900&q=60'),
(6,'Chicken Tikka Roll','Char-grilled chicken tikka with onions and mint chutney',159,0,'Rolls','https://images.unsplash.com/photo-1600850056064-a8b380df8395?auto=format&fit=crop&w=900&q=60'),
(6,'Egg Roll','Classic egg roll with green chutney',109,0,'Rolls','https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=900&q=60'),
(6,'Double Chicken Roll','Double chicken filling for extra hungry folks',199,0,'Rolls','https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?auto=format&fit=crop&w=900&q=60'),
(6,'Aloo Masala Roll','Spiced potato filling with tangy sauces',99,1,'Rolls','https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=900&q=60'),
(6,'Masala Lemonade','Zesty lemonade with a hint of spice',69,1,'Beverages','https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=900&q=60'),
(7,'Paneer Butter Masala','Cottage cheese in rich tomato-butter gravy',249,1,'Main Course','https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=900&q=60'),
(7,'Butter Chicken','Creamy tomato gravy with tender chicken',289,0,'Main Course','https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(7,'Dal Makhani','Slow-cooked black lentils finished with cream',199,1,'Main Course','https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=900&q=60'),
(7,'Kadhai Paneer','Paneer tossed with bell peppers and kadhai masala',239,1,'Main Course','https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=900&q=60'),
(7,'Butter Naan','Tandoor-baked naan brushed with butter',49,1,'Breads','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60'),
(7,'Jeera Rice','Basmati tempered with cumin and ghee',149,1,'Rice','https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=900&q=60'),
(7,'Gulab Jamun (2 pc)','Soft dumplings soaked in rose syrup',79,1,'Desserts','https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=60'),
(8,'Greek Salad Bowl','Feta, olives, cucumber and cherry tomatoes',229,1,'Bowls','https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=60'),
(8,'Quinoa Power Bowl','Quinoa, roasted veggies, hummus and seeds',259,1,'Bowls','https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=900&q=60'),
(8,'Grilled Chicken Salad','Herb-grilled chicken over crunchy greens',279,0,'Bowls','https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=900&q=60'),
(8,'Avocado Sourdough Toast','Smashed avocado on toasted sourdough',199,1,'Toast','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=60'),
(8,'Berry Smoothie Bowl','Thick berry smoothie topped with granola',239,1,'Smoothie Bowls','https://images.unsplash.com/photo-1544787219-7f47ccb76574?auto=format&fit=crop&w=900&q=60'),
(8,'Millet Khichdi Bowl','Comforting millet khichdi with veggies',189,1,'Bowls','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60'),
(8,'Cold-Pressed Green Juice','Spinach, apple, cucumber and ginger',129,1,'Juices','https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=900&q=60'),
(9,'Choco Truffle Pastry','Dark chocolate sponge with truffle cream',149,1,'Cakes & Pastries','https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=60'),
(9,'Tiramisu Jar','Coffee-soaked layers with mascarpone cream',199,1,'Jar Desserts','https://images.unsplash.com/photo-1587314168485-3236d6710814?auto=format&fit=crop&w=900&q=60'),
(9,'Walnut Brownie with Ice Cream','Warm brownie served with vanilla scoop',179,1,'Hot Desserts','https://images.unsplash.com/photo-1550617931-e17a7b70dce2?auto=format&fit=crop&w=900&q=60'),
(9,'Baked Cheesecake','Classic New York style baked cheesecake',219,1,'Cheesecakes','https://images.unsplash.com/photo-1555507036-ab1f4038808a?auto=format&fit=crop&w=900&q=60'),
(9,'Hazelnut Gelato (2 scoops)','Slow-churned Italian gelato',129,1,'Gelato','https://images.unsplash.com/photo-1464305795204-6f5bbfc7fb81?auto=format&fit=crop&w=900&q=60'),
(9,'Hot Chocolate Fudge Sundae','Sundae loaded with hot fudge and nuts',169,1,'Sundaes','https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?auto=format&fit=crop&w=900&q=60'),
(10,'Cappuccino','Double shot espresso with velvety milk foam',149,1,'Coffee','https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=60'),
(10,'Iced Cafe Latte','Chilled espresso and milk over ice',169,1,'Coffee','https://images.unsplash.com/photo-1447933601403-0c6688de566e?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(10,'Cold Brew Coffee','Slow-steeped 18-hour cold brew',179,1,'Coffee','https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=900&q=60'),
(10,'Chicken Club Sandwich','Triple-decker with grilled chicken and cheese',189,0,'Sandwiches','https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=900&q=60'),
(10,'Paneer Grilled Wrap','Tandoori paneer with mint mayo in a wrap',179,1,'Wraps','https://images.unsplash.com/photo-1553909489-cd47e0907980?auto=format&fit=crop&w=900&q=60'),
(10,'Sourdough Garlic Toast','Crispy sourdough with garlic butter',159,1,'Snacks','https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=900&q=60'),
(10,'Chocolate Chip Muffin','Soft-baked muffin loaded with chocolate',99,1,'Bakes','https://images.unsplash.com/photo-1486427944299-d1955d23e34d?auto=format&fit=crop&w=900&q=60'),
(11,'Veg Hakka Noodles','Wok-tossed noodles with crunchy vegetables',159,1,'Noodles & Rice','https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=900&q=60'),
(11,'Chicken Fried Rice','Smoky wok-fried rice with chicken and egg',179,0,'Noodles & Rice','https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=900&q=60'),
(11,'Chilli Paneer','Crispy paneer in sweet-spicy chilli sauce',199,1,'Starters','https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=900&q=60'),
(11,'Chicken Manchurian','Chicken dumplings glazed in manchurian sauce',219,0,'Starters','https://images.unsplash.com/photo-1617093727343-374698b1b08d?auto=format&fit=crop&w=900&q=60'),
(11,'Veg Spring Rolls (4 pc)','Crispy rolls with veggie glass-noodle filling',129,1,'Starters','https://images.unsplash.com/photo-1625398407796-82650a8c135f?auto=format&fit=crop&w=900&q=60'),
(11,'Hot & Sour Soup','Peppery soup with tofu and mushrooms',119,1,'Soups','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60'),
(12,'Chicken Seekh Kebab (6 pc)','Minced chicken skewers from the tandoor',249,0,'Kebabs','https://images.unsplash.com/photo-1600891964092-4316c288032e?auto=format&fit=crop&w=900&q=60'),
(12,'Mutton Seekh Kebab (6 pc)','Juicy mutton kebabs with warm spices',299,0,'Kebabs','https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?auto=format&fit=crop&w=900&q=60'),
(12,'Paneer Tikka Angara','Charred paneer in smoky red marinade',219,1,'Kebabs','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=60'),
(12,'Tandoori Chicken (Half)','Classic tandoori chicken with laccha onions',279,0,'Tandoor','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=900&q=60'),
(12,'Chicken Malai Tikka','Creamy cashew-marinated chicken tikka',269,0,'Kebabs','https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=900&q=60'),
(12,'Rumali Roti','Feather-thin handkerchief roti',39,1,'Breads','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60'),
(12,'Kebab Platter for Two','Chef''s assortment of six house kebabs',449,0,'Platters','https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?auto=format&fit=crop&w=900&q=60'),
(13,'Idli Sambar (4 pc)','Steamed rice cakes dunked in hot sambar',79,1,'Idlis','https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=60'),
(13,'Ghee Podi Idli','Idlis tossed in gunpowder podi and ghee',99,1,'Idlis','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(13,'Sambar Vada','Crispy vada soaked in piping hot sambar',59,1,'Vadas','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=900&q=60'),
(13,'Curd Rice','Cooling curd rice tempered with mustard leaves',89,1,'Rice','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60'),
(13,'Kesari Bath','Saffron semolina dessert with cashews',69,1,'Desserts','https://images.unsplash.com/photo-1484723091739-30a097e8f929?auto=format&fit=crop&w=900&q=60'),
(13,'Filter Coffee','Strong decoction coffee with frothy milk',49,1,'Beverages','https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=900&q=60'),
(14,'Alfredo Fettuccine','Creamy parmesan fettuccine with garlic',249,1,'Pasta','https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=900&q=60'),
(14,'Penne Arrabbiata','Penne in spicy tomato-chilli sauce',229,1,'Pasta','https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=900&q=60'),
(14,'Pesto Spaghetti','Basil pesto spaghetti with pine nuts',259,1,'Pasta','https://images.unsplash.com/photo-1563379926898-05f4575a45d8?auto=format&fit=crop&w=900&q=60'),
(14,'Mac & Cheese','Baked macaroni with three-cheese sauce',219,1,'Pasta','https://images.unsplash.com/photo-1612874742237-6526221588e3?auto=format&fit=crop&w=900&q=60'),
(14,'Garlic Bread','Crusty bread with garlic herb butter',129,1,'Sides','https://images.unsplash.com/photo-1481391319762-47dff72954d9?auto=format&fit=crop&w=900&q=60'),
(14,'Bruschetta','Toasted baguette with tomato-basil salsa',149,1,'Sides','https://images.unsplash.com/photo-1539252554453-80ab65ce3586?auto=format&fit=crop&w=900&q=60'),
(14,'Tiramisu','Classic Italian coffee dessert',179,1,'Desserts','https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=60'),
(15,'Chicken Soft Tacos (2 pc)','Corn tortillas with spiced chicken and salsa',199,0,'Tacos','https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=900&q=60'),
(15,'Veg Bean Tacos (2 pc)','Refried beans, cheese and pico de gallo',169,1,'Tacos','https://images.unsplash.com/photo-1565299585323-38d6b0865b47?auto=format&fit=crop&w=900&q=60'),
(15,'Burrito Bowl','Rice bowl with beans, corn, salsa and crema',249,1,'Bowls','https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&w=900&q=60'),
(15,'Nachos Grande','Loaded nachos with cheese sauce and jalapenos',199,1,'Snacks','https://images.unsplash.com/photo-1512152272829-e3139592d56f?auto=format&fit=crop&w=900&q=60'),
(15,'Cheese Quesadilla','Grilled tortilla with melted cheese and veggies',219,1,'Quesadillas','https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?auto=format&fit=crop&w=900&q=60'),
(15,'Churros with Chocolate Sauce','Golden fried churros dusted in cinnamon sugar',129,1,'Desserts','https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=60'),
(16,'California Roll (8 pc)','Crab stick, avocado and cucumber roll',349,0,'Rolls','https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=900&q=60'),
(16,'Salmon Nigiri (4 pc)','Fresh salmon over seasoned rice',399,0,'Nigiri','https://images.unsplash.com/photo-1553621042-f6e147245754?auto=format&fit=crop&w=900&q=60'),
(16,'Veg Maki Roll (8 pc)','Avocado, cucumber and carrot maki',249,1,'Rolls','https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(16,'Chicken Teriyaki Bowl','Glazed chicken over sticky rice',329,0,'Bowls','https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=900&q=60'),
(16,'Miso Soup','Classic Japanese soup with tofu and wakame',149,1,'Soups','https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=900&q=60'),
(16,'Tempura Crunch Roll (8 pc)','Tempura shrimp roll with spicy mayo',379,0,'Rolls','https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=900&q=60'),
(17,'Kolkata Chicken Kathi Roll','Signature chicken roll with onion and green chilli',149,0,'Kathi Rolls','https://images.unsplash.com/photo-1529006557810-274b9b2fc783?auto=format&fit=crop&w=900&q=60'),
(17,'Mutton Kathi Roll','Spiced mutton wrapped in flaky paratha',189,0,'Kathi Rolls','https://images.unsplash.com/photo-1600850056064-a8b380df8395?auto=format&fit=crop&w=900&q=60'),
(17,'Paneer Kathi Roll','Tandoori paneer with capsicum and mint mayo',129,1,'Kathi Rolls','https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=900&q=60'),
(17,'Egg Double Kathi Roll','Double egg roll with Kolkata-style filling',109,0,'Kathi Rolls','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60'),
(17,'Aloo Dum with Luchi','Bengali aloo dum with two puffed luchis',129,1,'Bengali Specials','https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=900&q=60'),
(17,'Mishti Doi','Sweet fermented curd in clay pot',69,1,'Desserts','https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=60'),
(18,'Mughlai Chicken Biryani','Rich biryani with saffron and fried onions',299,0,'Biryani','https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=900&q=60'),
(18,'Murgh Musallam','Whole chicken braised in royal gravy',349,0,'Royal Mains','https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=60'),
(18,'Chicken Changezi','Creamy tomato-cashew chicken classic',289,0,'Royal Mains','https://images.unsplash.com/photo-1567337710282-00832b415979?auto=format&fit=crop&w=900&q=60'),
(18,'Mutton Rogan Josh','Kashmiri-style slow cooked mutton',329,0,'Royal Mains','https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=60'),
(18,'Sheermal','Saffron-flavoured tandoor flatbread',59,1,'Breads','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60'),
(18,'Shahi Tukda','Royal bread pudding with rabri and nuts',119,1,'Desserts','https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=60'),
(19,'Pani Puri (8 pc)','Crisp puris with spicy tangy pani',79,1,'Chaat','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60'),
(19,'Bhel Puri','Puffed rice tossed with chutneys and sev',89,1,'Chaat','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60'),
(19,'Sev Puri (6 pc)','Puris loaded with potato, chutneys and sev',99,1,'Chaat','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60'),
(19,'Dahi Puri (6 pc)','Puris topped with creamy sweetened curd',99,1,'Chaat','https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=900&q=60'),
(19,'Raj Kachori','The king of chaats stuffed with goodies',129,1,'Chaat','https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(19,'Pav Bhaji','Buttery bhaji with toasted pav',149,1,'Hot Snacks','https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=900&q=60'),
(20,'Kerala Chicken Curry with Appam','Nadan chicken curry with soft appams',269,0,'Kerala Specials','https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=900&q=60'),
(20,'Puttu & Kadala Curry','Steamed rice cakes with black chickpea curry',179,1,'Kerala Specials','https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=900&q=60'),
(20,'Kerala Fish Curry with Rice','Tangy meen curry with matta rice',299,0,'Seafood','https://images.unsplash.com/photo-1559742811-822873691df8?auto=format&fit=crop&w=900&q=60'),
(20,'Veg Ishtu with Appam','Coconut milk vegetable stew with appam',219,1,'Kerala Specials','https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=60'),
(20,'Kerala Parotta with Beef Fry','Flaky parotta with spicy beef fry',289,0,'Kerala Specials','https://images.unsplash.com/photo-1567337710282-00832b415979?auto=format&fit=crop&w=900&q=60'),
(20,'Palada Payasam','Classic rice-flake milk payasam',99,1,'Desserts','https://images.unsplash.com/photo-1587314168485-3236d6710814?auto=format&fit=crop&w=900&q=60'),
(21,'Chole Bhature','Spicy chickpeas with two fluffy bhature',149,1,'Punjabi Classics','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60'),
(21,'Sarson Ka Saag & Makki Roti','Winter special saag with corn rotis',219,1,'Punjabi Classics','https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=60'),
(21,'Paneer Lababdar','Paneer in rich onion-tomato gravy',259,1,'Main Course','https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=900&q=60'),
(21,'Kadhai Chicken','Rustic chicken with crushed coriander',279,0,'Main Course','https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=900&q=60'),
(21,'Lassi Patiala','Thick sweet lassi topped with malai',99,1,'Beverages','https://images.unsplash.com/photo-1497534446932-c925b458314e?auto=format&fit=crop&w=900&q=60'),
(21,'Phulka (2 pc)','Soft whole-wheat phulkas',45,1,'Breads','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60'),
(22,'Veg Hakka Noodles','Wok-tossed noodles with crunchy vegetables',159,1,'Noodles & Rice','https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=900&q=60'),
(22,'Chicken Fried Rice','Smoky wok-fried rice with chicken and egg',179,0,'Noodles & Rice','https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=900&q=60'),
(22,'Chilli Paneer','Crispy paneer in sweet-spicy chilli sauce',199,1,'Starters','https://images.unsplash.com/photo-1617093727343-374698b1b08d?auto=format&fit=crop&w=900&q=60'),
(22,'Chicken Manchurian','Chicken dumplings glazed in manchurian sauce',219,0,'Starters','https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=900&q=60'),
(22,'Veg Spring Rolls (4 pc)','Crispy rolls with veggie glass-noodle filling',129,1,'Starters','https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=900&q=60'),
(22,'Hot & Sour Soup','Peppery soup with tofu and mushrooms',119,1,'Soups','https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=900&q=60'),
(23,'Veg Grilled Sandwich','Classic bombay-style grilled veg sandwich',129,1,'Sandwiches','https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(23,'Cheese Corn Sandwich','Loaded with cheese and sweet corn',149,1,'Sandwiches','https://images.unsplash.com/photo-1553909489-cd47e0907980?auto=format&fit=crop&w=900&q=60'),
(23,'Chicken Club Sandwich','Triple decker grilled chicken club',189,0,'Sandwiches','https://images.unsplash.com/photo-1539252554453-80ab65ce3586?auto=format&fit=crop&w=900&q=60'),
(23,'Paneer Tikka Sandwich','Tandoori paneer with mint chutney',159,1,'Sandwiches','https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=900&q=60'),
(23,'Peri Peri Fries','Crispy fries with peri peri dust',99,1,'Sides','https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=900&q=60'),
(23,'Oreo Shake','Cookies and cream shake',129,1,'Beverages','https://images.unsplash.com/photo-1571934811356-5cc061b6821f?auto=format&fit=crop&w=900&q=60'),
(24,'Filter Coffee','Authentic decoction kaapi in davara-tumbler',49,1,'Beverages','https://images.unsplash.com/photo-1482049016688-2d3e1b311543?auto=format&fit=crop&w=900&q=60'),
(24,'Idli Sambar (3 pc)','Soft idlis with homestyle sambar',79,1,'Breakfast','https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=900&q=60'),
(24,'Mysore Bonda (4 pc)','Fluffy bondas with coconut chutney',69,1,'Breakfast','https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=60'),
(24,'Upma','Ghee-roasted semolina upma with cashews',69,1,'Breakfast','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=60'),
(24,'Ven Pongal','Comforting pepper-jeera pongal',89,1,'Breakfast','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60'),
(24,'Kesari Bath','Sweet saffron semolina',59,1,'Desserts','https://images.unsplash.com/photo-1550617931-e17a7b70dce2?auto=format&fit=crop&w=900&q=60'),
(25,'Belgian Chocolate Scoop','Intense dark chocolate ice cream',99,1,'Scoops','https://images.unsplash.com/photo-1464305795204-6f5bbfc7fb81?auto=format&fit=crop&w=900&q=60'),
(25,'Mango Alphonso Sundae','Seasonal alphonso pulp with vanilla',149,1,'Sundaes','https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?auto=format&fit=crop&w=900&q=60'),
(25,'Brownie Blast Sundae','Warm brownie chunks with two scoops',179,1,'Sundaes','https://images.unsplash.com/photo-1484723091739-30a097e8f929?auto=format&fit=crop&w=900&q=60'),
(25,'Butterscotch Cone','Crunchy praline butterscotch in a waffle cone',79,1,'Cones','https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=60'),
(25,'Royal Falooda','Rose falooda with basil seeds and kulfi',139,1,'Falooda','https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=900&q=60'),
(25,'Waffle with Gelato','Belgian waffle topped with gelato and syrup',199,1,'Waffles','https://images.unsplash.com/photo-1509365465985-25d11c17e812?auto=format&fit=crop&w=900&q=60'),
(26,'Andhra Chicken Biryani','Fiery guntur-chicken biryani',259,0,'Biryani','https://images.unsplash.com/photo-1633945274405-b6c8069047b0?auto=format&fit=crop&w=900&q=60'),
(26,'Gongura Mutton','Tender mutton cooked with tangy gongura',319,0,'Andhra Specials','https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=900&q=60'),
(26,'Kodi Vepudu','Spicy Andhra-style chicken fry',249,0,'Andhra Specials','https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(26,'Natukodi Pulusu','Country chicken in rustic gravy',289,0,'Andhra Specials','https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=900&q=60'),
(26,'Andhra Veg Meals','Unlimited-style rice platter with pappu',199,1,'Meals','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60'),
(26,'Apricot Delight','Hyderabadi apricot dessert with cream',119,1,'Desserts','https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=60'),
(27,'Rajasthani Special Thali','Dal baati, gatte, ker sangri and sweets',259,1,'Thalis','https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?auto=format&fit=crop&w=900&q=60'),
(27,'Mini Thali','Compact thali with dal, sabzi, roti and rice',179,1,'Thalis','https://images.unsplash.com/photo-1512152272829-e3139592d56f?auto=format&fit=crop&w=900&q=60'),
(27,'Dal Baati Churma (3 pc)','Classic baati with panchmel dal and churma',199,1,'Specials','https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?auto=format&fit=crop&w=900&q=60'),
(27,'Gatte Ki Sabzi with Rotis','Gram flour dumplings in yogurt gravy',189,1,'Specials','https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=900&q=60'),
(27,'Sweet Lassi','Thick lassi sweetened with sugar',89,1,'Beverages','https://images.unsplash.com/photo-1546173159-315724a31696?auto=format&fit=crop&w=900&q=60'),
(27,'Rabdi','Slow-reduced sweetened milk with dry fruits',109,1,'Desserts','https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=60'),
(28,'Grilled Pomfret','Fresh pomflet grilled with coastal spices',329,0,'Grills','https://images.unsplash.com/photo-1580476262798-bddd9f4b7369?auto=format&fit=crop&w=900&q=60'),
(28,'Prawn Ghee Roast','Mangalorean prawns in fiery ghee roast masala',349,0,'Curries','https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?auto=format&fit=crop&w=900&q=60'),
(28,'Kane Fish Fry','Lady fish fried crisp with lemon',279,0,'Fries','https://images.unsplash.com/photo-1535140728325-a4d3707eee61?auto=format&fit=crop&w=900&q=60'),
(28,'Seafood Platter','Chef''s mix of grilled catch, prawns and calamari',499,0,'Platters','https://images.unsplash.com/photo-1559742811-822873691df8?auto=format&fit=crop&w=900&q=60'),
(28,'Neer Dosa (4 pc)','Soft rice dosas, perfect with curry',129,1,'Sides','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=900&q=60'),
(28,'Prawn Fry','Coconut-crusted fried prawns',299,0,'Fries','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60'),
(29,'Aloo Paratha with Curd','Stuffed potato paratha with butter and curd',99,1,'Parathas','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60'),
(29,'Paneer Paratha','Spiced paneer stuffed paratha',129,1,'Parathas','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60'),
(29,'Amritsari Kulcha with Chole','Crispy kulcha with spicy chole',119,1,'Kulchas','https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=60'),
(29,'Mix Veg Paratha','Seasonal vegetable stuffed paratha',109,1,'Parathas','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60'),
(29,'Sweet Lassi','Chilled thick lassi',89,1,'Beverages','https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(29,'Butter Chicken with Naan','Creamy butter chicken with two naans',289,0,'Combos','https://images.unsplash.com/photo-1567337710282-00832b415979?auto=format&fit=crop&w=900&q=60'),
(30,'Veg Hakka Noodles','Wok-tossed noodles with crunchy vegetables',159,1,'Noodles & Rice','https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=900&q=60'),
(30,'Chicken Fried Rice','Smoky wok-fried rice with chicken and egg',179,0,'Noodles & Rice','https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=900&q=60'),
(30,'Chilli Paneer','Crispy paneer in sweet-spicy chilli sauce',199,1,'Starters','https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=900&q=60'),
(30,'Chicken Manchurian','Chicken dumplings glazed in manchurian sauce',219,0,'Starters','https://images.unsplash.com/photo-1617093727343-374698b1b08d?auto=format&fit=crop&w=900&q=60'),
(30,'Veg Spring Rolls (4 pc)','Crispy rolls with veggie glass-noodle filling',129,1,'Starters','https://images.unsplash.com/photo-1625398407796-82650a8c135f?auto=format&fit=crop&w=900&q=60'),
(30,'Hot & Sour Soup','Peppery soup with tofu and mushrooms',119,1,'Soups','https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=900&q=60'),
(31,'Vada Pav (2 pc)','Mumbai''s favourite potato fritter in pav',59,1,'Street Classics','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60'),
(31,'Pav Bhaji','Buttery bhaji with two pav',149,1,'Street Classics','https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=60'),
(31,'Misal Pav','Spicy misal with farsan and pav',119,1,'Street Classics','https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=900&q=60'),
(31,'Sabudana Vada','Crispy sago vadas with peanut chutney',89,1,'Snacks','https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?auto=format&fit=crop&w=900&q=60'),
(31,'Bhel Puri','Tangy puffed rice snack',89,1,'Snacks','https://images.unsplash.com/photo-1512152272829-e3139592d56f?auto=format&fit=crop&w=900&q=60'),
(31,'Sweet Lassi','Refreshing thick lassi',69,1,'Beverages','https://images.unsplash.com/photo-1544787219-7f47ccb76574?auto=format&fit=crop&w=900&q=60'),
(32,'Belgian Waffle','Classic golden waffle with maple syrup',179,1,'Waffles','https://images.unsplash.com/photo-1598214886806-c87b84b7078b?auto=format&fit=crop&w=900&q=60'),
(32,'Chocolate Overload Waffle','Waffle drowned in chocolate sauce',199,1,'Waffles','https://images.unsplash.com/photo-1509365465985-25d11c17e812?auto=format&fit=crop&w=900&q=60'),
(32,'Waffle Ice Cream Dream','Waffle with two scoops and hot fudge',229,1,'Waffles','https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=900&q=60'),
(32,'Savory Masala Waffle','Cheese and jalapeno savoury waffle',189,1,'Savoury','https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?auto=format&fit=crop&w=900&q=60'),
(32,'Nutella Banana Waffle','Nutella spread with fresh banana slices',219,1,'Waffles','https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=60'),
(32,'Berry Smoothie','Mixed berry smoothie',149,1,'Beverages','https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=900&q=60'),
(33,'Millet Thali Bowl','Ragi jowar bowl with two sabzis and salad',229,1,'Bowls','https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(33,'Grilled Salad Jar','Layered protein-rich salad in a jar',219,1,'Salads','https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=900&q=60'),
(33,'Steamed Chicken Bowl','Herb steamed chicken with brown rice',259,0,'Bowls','https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?auto=format&fit=crop&w=900&q=60'),
(33,'Ragi Idiyappam Bowl','Idiyappam with coconut milk curry',189,1,'Bowls','https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=900&q=60'),
(33,'Peanut Butter Smoothie','Protein-rich peanut butter banana shake',159,1,'Smoothies','https://images.unsplash.com/photo-1497534446932-c925b458314e?auto=format&fit=crop&w=900&q=60'),
(33,'Sprouts Chaat','Zesty sprout salad with lemon dressing',139,1,'Salads','https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=900&q=60'),
(34,'Chicken Seekh Kebab (6 pc)','Minced chicken skewers from the tandoor',249,0,'Kebabs','https://images.unsplash.com/photo-1600891964092-4316c288032e?auto=format&fit=crop&w=900&q=60'),
(34,'Mutton Seekh Kebab (6 pc)','Juicy mutton kebabs with warm spices',299,0,'Kebabs','https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?auto=format&fit=crop&w=900&q=60'),
(34,'Paneer Tikka Angara','Charred paneer in smoky red marinade',219,1,'Kebabs','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=60'),
(34,'Tandoori Chicken (Half)','Classic tandoori chicken with laccha onions',279,0,'Tandoor','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=900&q=60'),
(34,'Chicken Malai Tikka','Creamy cashew-marinated chicken tikka',269,0,'Kebabs','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60'),
(34,'Rumali Roti','Feather-thin handkerchief roti',39,1,'Breads','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60'),
(34,'Kebab Platter for Two','Chef''s assortment of six house kebabs',449,0,'Platters','https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=900&q=60'),
(35,'Aloo Paratha','Classic potato paratha with pickle and curd',99,1,'Parathas','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60'),
(35,'Paneer Paratha','Stuffed paneer paratha with butter',129,1,'Parathas','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60'),
(35,'Amritsari Kulcha Chole','Authentic kulcha with Amritsari chole',119,1,'Kulchas','https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=900&q=60'),
(35,'Mix Veg Paratha','Loaded vegetable paratha',109,1,'Parathas','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60'),
(35,'Chole Bhature','Fluffy bhature with spicy chole',149,1,'Combos','https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=900&q=60'),
(35,'Lassi','Sweet or salted Punjabi lassi',89,1,'Beverages','https://images.unsplash.com/photo-1571934811356-5cc061b6821f?auto=format&fit=crop&w=900&q=60'),
(36,'Cheese Overload Pizza','Four cheese blend on a crispy base',329,1,'Pizzas','https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?auto=format&fit=crop&w=900&q=60'),
(36,'Margherita Classic','Tomato, mozzarella and basil',199,1,'Pizzas','https://images.unsplash.com/photo-1595854341625-f33ee10dbf94?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(36,'Chicken Tikka Pizza','Tandoori chicken chunks with onions',319,0,'Pizzas','https://images.unsplash.com/photo-1601924582970-9238bcb495d9?auto=format&fit=crop&w=900&q=60'),
(36,'Stuffed Crust Paneer Pizza','Cheese-filled crust with paneer topping',359,1,'Pizzas','https://images.unsplash.com/photo-1590947132387-155cc02f3212?auto=format&fit=crop&w=900&q=60'),
(36,'Cheese Garlic Bread','Garlic bread stuffed with mozzarella',129,1,'Sides','https://images.unsplash.com/photo-1516559828984-fb3b99548b21?auto=format&fit=crop&w=900&q=60'),
(36,'BBQ Wings (4 pc)','Smoky BBQ glazed chicken wings',199,0,'Sides','https://images.unsplash.com/photo-1600891964092-4316c288032e?auto=format&fit=crop&w=900&q=60'),
(37,'Curd Rice','Tempered curd rice with pomegranate',99,1,'Meals','https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?auto=format&fit=crop&w=900&q=60'),
(37,'Sambar Rice','Steamed rice mixed with homestyle sambar',109,1,'Meals','https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=60'),
(37,'Rasam Rice','Peppery rasam with ghee rice',105,1,'Meals','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=60'),
(37,'Kootu with Rice','Lentil-vegetable kootu with rice',139,1,'Meals','https://images.unsplash.com/photo-1512152272829-e3139592d56f?auto=format&fit=crop&w=900&q=60'),
(37,'Appalam (2 pc)','Roasted crispy appalam',29,1,'Sides','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=900&q=60'),
(37,'Payasam','Vermicelli payasam with cashews',79,1,'Desserts','https://images.unsplash.com/photo-1587314168485-3236d6710814?auto=format&fit=crop&w=900&q=60'),
(37,'Filter Coffee','Madras filter kaapi',45,1,'Beverages','https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=60'),
(38,'Pad Thai Noodles','Stir-fried rice noodles with tamarind sauce',269,0,'Noodles','https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=900&q=60'),
(38,'Green Curry with Jasmine Rice','Thai green curry with coconut milk',289,0,'Curries','https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=900&q=60'),
(38,'Tom Yum Soup','Hot and sour lemongrass soup',199,0,'Soups','https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=900&q=60'),
(38,'Chicken Satay (4 pc)','Grilled skewers with peanut sauce',229,0,'Starters','https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?auto=format&fit=crop&w=900&q=60'),
(38,'Thai Chicken Fried Rice','Jasmine rice wok-fried with thai basil',239,0,'Rice','https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=900&q=60'),
(38,'Mango Sticky Rice','Sweet coconut sticky rice with mango',169,1,'Desserts','https://images.unsplash.com/photo-1550617931-e17a7b70dce2?auto=format&fit=crop&w=900&q=60'),
(39,'Herb Grilled Chicken','Grilled chicken with mash and sauteed veggies',349,0,'Mains','https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=60'),
(39,'Alfredo Fettuccine','Creamy parmesan pasta',279,1,'Pasta','https://images.unsplash.com/photo-1598866594230-a7c12756260f?auto=format&fit=crop&w=900&q=60'),
(39,'Pesto Spaghetti','Fresh basil pesto with parmesan',269,1,'Pasta','https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(39,'Cottage Cheese Steak','Grilled paneer steak with pepper sauce',249,1,'Mains','https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=900&q=60'),
(39,'Caesar Salad','Romaine, croutons and caesar dressing',239,1,'Salads','https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=900&q=60'),
(39,'Mushroom Risotto','Creamy arborio rice with porcini',289,1,'Risotto','https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=900&q=60'),
(39,'Tiramisu','Coffee mascarpone classic',199,1,'Desserts','https://images.unsplash.com/photo-1464305795204-6f5bbfc7fb81?auto=format&fit=crop&w=900&q=60'),
(40,'Masala Chai','Kadak chai brewed with spices',49,1,'Chai','https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=900&q=60'),
(40,'Bun Maska','Soft bun with generous salted butter',59,1,'Snacks','https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=60'),
(40,'Vada Pav','Street-style vada pav',49,1,'Snacks','https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?auto=format&fit=crop&w=900&q=60'),
(40,'Samosa (2 pc)','Crispy samosas with chutneys',60,1,'Snacks','https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=900&q=60'),
(40,'Kanda Bhaji','Onion fritters with green chutney',79,1,'Snacks','https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=900&q=60'),
(40,'Cold Coffee','Chilled creamy coffee',109,1,'Beverages','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=60'),
(41,'Falafel Wrap','Crispy falafel with hummus and veggies in pita',169,1,'Wraps','https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=900&q=60'),
(41,'Hummus & Pita Platter','Silky hummus with warm pita and olive oil',199,1,'Platters','https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=900&q=60'),
(41,'Chicken Doner Plate','Sliced doner chicken with rice and salad',259,0,'Plates','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=60'),
(41,'Doner Wrap','Juicy doner meat wrapped with garlic sauce',209,0,'Wraps','https://images.unsplash.com/photo-1529006557810-274b9b2fc783?auto=format&fit=crop&w=900&q=60'),
(41,'Mediterranean Bowl','Falafel, hummus, tabbouleh and pickles',239,1,'Bowls','https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?auto=format&fit=crop&w=900&q=60'),
(41,'Baklava (2 pc)','Flaky pistachio pastry soaked in honey syrup',129,1,'Desserts','https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?auto=format&fit=crop&w=900&q=60'),
(42,'Classic Pancake Stack','Fluffy stack with maple syrup and butter',179,1,'Pancakes','https://images.unsplash.com/photo-1598214886806-c87b84b7078b?auto=format&fit=crop&w=900&q=60'),
(42,'Chocolate Pancakes','Cocoa pancakes with chocolate drizzle',199,1,'Pancakes','https://images.unsplash.com/photo-1509365465985-25d11c17e812?auto=format&fit=crop&w=900&q=60'),
(42,'Berry Pancakes','Pancakes topped with fresh berries and cream',209,1,'Pancakes','https://images.unsplash.com/photo-1484723091739-30a097e8f929?auto=format&fit=crop&w=900&q=60'),
(42,'French Toast','Brioche french toast with cinnamon sugar',169,1,'French Toast','https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(42,'Hot Chocolate','Belgian hot chocolate with marshmallows',139,1,'Beverages','https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=60'),
(42,'Maple Waffle','Golden waffle with maple syrup',189,1,'Waffles','https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=900&q=60'),
(43,'Shoyu Chicken Ramen','Soy-based broth with noodles and chashu',329,0,'Ramen','https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=900&q=60'),
(43,'Spicy Miso Ramen','Rich miso broth with chilli oil',349,0,'Ramen','https://images.unsplash.com/photo-1617093727343-374698b1b08d?auto=format&fit=crop&w=900&q=60'),
(43,'Veg Ramen','Mushroom and tofu ramen in kombu broth',289,1,'Ramen','https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=900&q=60'),
(43,'Chicken Gyoza (6 pc)','Pan-seared dumplings with ponzu dip',199,0,'Sides','https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=900&q=60'),
(43,'Karaage Chicken','Japanese fried chicken bites',229,0,'Sides','https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&fit=crop&w=900&q=60'),
(43,'Tempura Vegetables','Light crispy vegetable tempura',179,1,'Sides','https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=900&q=60'),
(44,'Gujarati Thali','Rotli, dal, kadhi, shaak, rice and sweet',249,1,'Thalis','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=900&q=60'),
(44,'Undhiyu with Roti','Winter special mixed vegetable undhiyu',219,1,'Specials','https://images.unsplash.com/photo-1596560548464-f010549b84d7?auto=format&fit=crop&w=900&q=60'),
(44,'Dhokla (4 pc)','Steamed khaman dhokla with tempering',99,1,'Snacks','https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=900&q=60'),
(44,'Khaman','Soft khaman with green chutney',89,1,'Snacks','https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=900&q=60'),
(44,'Chaas','Spiced buttermilk',49,1,'Beverages','https://images.unsplash.com/photo-1546173159-315724a31696?auto=format&fit=crop&w=900&q=60'),
(44,'Basundi','Thickened sweet milk with saffron',119,1,'Desserts','https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=60'),
(45,'Mughlai Chicken Biryani','Rich biryani with saffron and fried onions',299,0,'Biryani','https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=900&q=60'),
(45,'Murgh Musallam','Whole chicken braised in royal gravy',349,0,'Royal Mains','https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=60'),
(45,'Chicken Changezi','Creamy tomato-cashew chicken classic',289,0,'Royal Mains','https://images.unsplash.com/photo-1567337710282-00832b415979?auto=format&fit=crop&w=900&q=60'),
(45,'Mutton Rogan Josh','Kashmiri-style slow cooked mutton',329,0,'Royal Mains','https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=60'),
(45,'Sheermal','Saffron-flavoured tandoor flatbread',59,1,'Breads','https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=60'),
(45,'Shahi Tukda','Royal bread pudding with rabri and nuts',119,1,'Desserts','https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(46,'Benne Dosa','Butter roast dosa Udupi style',119,1,'Dosas','https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=900&q=60'),
(46,'Udupi Sambar with Rice','Sambar rice with ghee and papad',89,1,'Meals','https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=900&q=60'),
(46,'Neer Dosa (4 pc)','Soft neer dosa with coconut chutney',99,1,'Dosas','https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=60'),
(46,'Goli Baje (4 pc)','Fluffy fried bajes with chutney',69,1,'Snacks','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=60'),
(46,'Udupi Veg Combo','Idli, vada and mini masala dosa',149,1,'Combos','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=900&q=60'),
(46,'Udupi Filter Coffee','Classic filter coffee',49,1,'Beverages','https://images.unsplash.com/photo-1447933601403-0c6688de566e?auto=format&fit=crop&w=900&q=60'),
(47,'Peri Peri Wings (6 pc)','Fiery peri peri dusted wings',229,0,'Wings','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=900&q=60'),
(47,'BBQ Glazed Wings (6 pc)','Sticky smoky BBQ glazed wings',239,0,'Wings','https://images.unsplash.com/photo-1600891964092-4316c288032e?auto=format&fit=crop&w=900&q=60'),
(47,'Buffalo Wings (6 pc)','Tangy hot buffalo sauce wings',249,0,'Wings','https://images.unsplash.com/photo-1565299507177-b0ac66763828?auto=format&fit=crop&w=900&q=60'),
(47,'Wings Bucket (12 pc)','Mix and match bucket with two dips',399,0,'Wings','https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?auto=format&fit=crop&w=900&q=60'),
(47,'Loaded Nacho Fries','Fries with cheese sauce, jalapenos and salsa',149,1,'Sides','https://images.unsplash.com/photo-1551782450-a2132b4ba21d?auto=format&fit=crop&w=900&q=60'),
(47,'Chicken Popcorn','Bite-sized crispy chicken',179,0,'Sides','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=60'),
(48,'Mango Smoothie','Thick alphonso mango smoothie',159,1,'Smoothies','https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=900&q=60'),
(48,'Berry Blast Smoothie','Strawberry, blueberry and yogurt blend',179,1,'Smoothies','https://images.unsplash.com/photo-1544787219-7f47ccb76574?auto=format&fit=crop&w=900&q=60'),
(48,'Peanut Butter Banana Shake','Protein-packed classic shake',189,1,'Shakes','https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=900&q=60'),
(48,'Oats Fruit Bowl','Overnight oats with seasonal fruits',199,1,'Bowls','https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=900&q=60'),
(48,'Watermelon Cooler','Fresh pressed watermelon with mint',129,1,'Juices','https://images.unsplash.com/photo-1497534446932-c925b458314e?auto=format&fit=crop&w=900&q=60'),
(48,'Protein Power Shake','Banana, oats and whey blend',199,1,'Shakes','https://images.unsplash.com/photo-1571934811356-5cc061b6821f?auto=format&fit=crop&w=900&q=60'),
(49,'Chicken Doner Wrap','Shaved chicken doner with garlic sauce',209,0,'Wraps','https://images.unsplash.com/photo-1600850056064-a8b380df8395?auto=format&fit=crop&w=900&q=60'),
(49,'Mutton Doner Plate','Doner mutton over turmeric rice',289,0,'Plates','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=60');

INSERT INTO menu_items (restaurant_id, name, description, price, is_veg, category, image) VALUES
(49,'Veg Falafel Wrap','Falafel, hummus and salad wrap',169,1,'Wraps','https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=900&q=60'),
(49,'Doner Kebab Platter','Mixed doner platter for two',349,0,'Platters','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=900&q=60'),
(49,'Pita & Hummus','Warm pita bread with creamy hummus',159,1,'Sides','https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=60'),
(49,'Doner Rice Bowl','Chicken doner over fragrant rice',249,0,'Bowls','https://images.unsplash.com/photo-1600891964092-4316c288032e?auto=format&fit=crop&w=900&q=60'),
(50,'Red Velvet Cupcake','Cream cheese frosted red velvet',99,1,'Cupcakes','https://images.unsplash.com/photo-1555507036-ab1f4038808a?auto=format&fit=crop&w=900&q=60'),
(50,'Chocolate Truffle Cupcake','Dark chocolate ganache cupcake',99,1,'Cupcakes','https://images.unsplash.com/photo-1486427944299-d1955d23e34d?auto=format&fit=crop&w=900&q=60'),
(50,'Vanilla Dream Cupcake','Classic vanilla with buttercream swirl',89,1,'Cupcakes','https://images.unsplash.com/photo-1481391319762-47dff72954d9?auto=format&fit=crop&w=900&q=60'),
(50,'Macarons Box (6 pc)','Assorted French macarons',199,1,'Macarons','https://images.unsplash.com/photo-1516559828984-fb3b99548b21?auto=format&fit=crop&w=900&q=60'),
(50,'Butter Croissant','Flaky all-butter croissant',119,1,'Bakes','https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=900&q=60'),
(50,'Cinnamon Roll','Gooey cinnamon roll with glaze',129,1,'Bakes','https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=60');

-- Done! 50 restaurants, 310 menu items seeded.
