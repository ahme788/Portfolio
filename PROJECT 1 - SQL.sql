-- Business model Customer to Customer (C2C) allows customers to do business with each other. 
-- This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and buyer can buy 
-- it without paying anything. E-Commerce website brings the seller and buyer to the same platform. 

-- Analyzing the user's database will lead to understanding the business perspective.
-- Behaviour of the users can be traced in terms of business with exploration of the user’s database. 

-- Dataset: One .csv file with name users_data with 98913 rows and 27 columns

-- Tasks to be performed

-- 1. Create new schema as ecommerce
-- 2. Import .csv file users_data into MySQL
-- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> 
-- choose options : Create a new table , select delete if exist -> next -> next)
-- 3. Run SQL command to see the structure of table
-- 4. Run SQL command to select first 100 rows of the database
-- 5. How many distinct values exist in table for field country and language
-- 6. Check whether male users are having maximum followers or female users.
-- 7. Calculate the total users those
      -- a. Uses Profile Picture in their Profile
      -- b. Uses Application for Ecommerce platform
      -- c. Uses Android app
      -- d. Uses ios app
-- 8. Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. 
-- (Hint: consider only those users having at least 1 product bought.)
-- 9.Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers.
-- (Hint: consider only those users having at least 1 product sold.)
-- 10. Display name of top 10 countries having maximum products pass rate.
-- 11. Calculate the number of users on an ecommerce platform for different language choices.
-- 12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. 
-- (Hint: use UNION to answer this question.)
-- 13. Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
-- 14. Which country is having maximum number of buyers?
-- 15. List the name of 10 countries having zero number of sellers.
-- 16. Display record of top 110 users who have used ecommerce platform recently.
-- 17. Calculate the number of female users those who have not logged in since last 100 days.
-- 18. Display the number of female users of each country at ecommerce platform.
-- 19. Display the number of male users of each country at ecommerce platform.
-- 20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

-- 1. Create new schema as ecommerce
   CREATE DATABASE ecommerce;

-- 2. Import .csv file users_data into MySQL
-- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> 
-- choose options : Create a new table , select delete if exist -> next -> next)
-- ANSWER: sucessfully imported the csv file 

-- 3. Run SQL command to see the structure of table
   SELECT * FROM users_data;
   
-- 4. Run SQL command to select first 100 rows of the database
   SELECT * FROM users_data LIMIT 100;

-- 5. How many distinct values exist in table for field country and language
   SELECT count(distinct country) country, count(distinct language) language FROM users_data;
   
-- 6. Check whether male users are having maximum followers or female users.
   SELECT gender, SUM(socialNbFollowers) FROM users_data GROUP BY gender;
   
-- 7. Calculate the total users those
      -- a. Uses Profile Picture in their Profile
         SELECT COUNT(hasProfilePicture) users_with_profilepicture FROM users_data WHERE hasProfilePicture = 'TRUE';
         
      -- b. Uses Application for Ecommerce platform
         SELECT COUNT(hasAnyApp) uses_any_app FROM users_data WHERE hasAnyApp = 'TRUE';
         
      -- c. Uses Android app
         SELECT COUNT(hasAndroidApp) uses_android_app FROM users_data WHERE hasAndroidApp = 'TRUE';
         
      -- d. Uses ios app
      SELECT COUNT(hasIosApp) uses_Ios_app FROM users_data WHERE hasIosApp = 'TRUE';
      
-- 8. Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. 
-- (Hint: consider only those users having at least 1 product bought.)
   SELECT * FROM users_data; 
   SELECT country, COUNT(productsBought) Buyers FROM users_data GROUP BY country ORDER BY Buyers DESC;
   
-- 9. Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. 
-- (Hint: consider only those users having at least 1 product sold.)
   SELECT country, COUNT(productsSold) Sellers FROM users_data GROUP BY country ORDER BY Sellers ASC;
   
   -- 10. Display name of top 10 countries having maximum products pass rate.
      SELECT country FROM users_data GROUP BY country HAVING MAX(productsPassRate) LIMIT 10;
      
-- 11. Calculate the number of users on an ecommerce platform for different language choices.
      SELECT language, COUNT(language) FROM users_data GROUP BY language;
      
-- 12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. 
-- (Hint: use UNION to answer this question.)
   SELECT SUM(productsWished) FROM users_data UNION SELECT SUM(socialProductsLiked) FROM users_data WHERE gender = 'F';
   
-- 13. Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
   SELECT SUM(productsSold) FROM users_data UNION SELECT SUM(productsBought) FROM users_data WHERE gender = 'M';
   
-- 14. Which country is having maximum number of buyers?
   SELECT country, MAX(productsSold) max_num_of_buyers FROM users_data GROUP BY country ORDER BY MAX(productsSold) DESC LIMIT 1;
   
-- 15. List the name of 10 countries having zero number of sellers.
   SELECT country, productsSold FROM users_data WHERE productsSold < 1;
   
-- 16. Display record of top 110 users who have used ecommerce platform recently.
   SELECT * FROM users_data GROUP BY daysSinceLastLogin HAVING MIN(daysSinceLastLogin) ORDER BY daysSinceLastLogin ASC LIMIT 110;
   
-- 17. Calculate the number of female users those who have not logged in since last 100 days.
   SELECT COUNT(TYPE) FROM users_data WHERE gender = 'F' AND daysSinceLastLogin LIMIT 100;

-- 18. Display the number of female users of each country at ecommerce platform.
   SELECT country, COUNT(gender) FEMALE_USERS FROM users_data WHERE gender = 'F' GROUP BY country;
   
-- 19. Display the number of male users of each country at ecommerce platform.
   SELECT country, COUNT(gender) MALE_USERS FROM users_data WHERE gender = 'M' GROUP BY country;
   
-- 20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.
   SELECT * FROM users_data;
   SELECT country, AVG(productsSold) PRODUCT_SOLD,  AVG(productsBought) PRODUCT_BOUGHT FROM users_data WHERE gender = 'M' GROUP BY country;

