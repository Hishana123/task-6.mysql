
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);
INSERT INTO Customer VALUES
(1, 'John'),
(2, 'Priya'),
(3, 'Rahul'),
(4, 'Anu'),
(5, 'David');
INSERT INTO Product VALUES
(1, 'Laptop'),
(2, 'Mobile'),
(3, 'Headphones'),
(4, 'Keyboard'),
(5, 'Mouse');
CREATE TABLE Review (
    Review_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Rating INT NOT NULL,
    Review_Text VARCHAR(500),
    Review_Date DATE NOT NULL,
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(customer_id),
    FOREIGN KEY (Product_ID)
    REFERENCES Product(product_id),
    CHECK (Rating BETWEEN 1 AND 5)
);
INSERT INTO Review VALUES
('R101', 1, 1, 5, 'Excellent performance', '2026-11-01'),
('R102', 2, 2, 4, 'Good battery life', '2026-11-02'),
('R103', 3, 1, 5, 'Very useful product', '2026-11-03'),
('R104', 4, 3, 3, 'Average quality', '2026-11-04'),
('R105', 5, 2, 2, 'Poor performance', '2026-11-05'),
('R106', 1, 4, 4, 'Good keyboard', '2026-11-06'),
('R107', 2, 5, 5, 'Excellent quality', '2026-11-07');
SELECT * FROM Review;
UPDATE Review
SET Review_Text = 'Excellent battery performance'
WHERE Review_ID = 'R102';
DELETE FROM Review
WHERE Review_ID = 'R105';

SELECT Product.product_name,
       Review.Rating,
       Review.Review_Text
FROM Product
JOIN Review
ON Product.product_id = Review.Product_ID;
SELECT Customer.customer_name,
       Review.Review_Text,
       Review.Rating
FROM Customer
JOIN Review
ON Customer.customer_id = Review.Customer_ID;

SELECT Product.product_name,
       COUNT(Review.Review_ID) AS Total_Reviews
FROM Product
JOIN Review
ON Product.product_id = Review.Product_ID
GROUP BY Product.product_id, Product.product_name
ORDER BY Total_Reviews DESC
LIMIT 1;

SELECT *
FROM Review
ORDER BY Review_Date DESC;


SELECT *
FROM Review
WHERE Rating > 4;


SELECT Product_ID,
       AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID;
SELECT Product_ID,
       COUNT(Review_ID) AS Total_Reviews
FROM Review
GROUP BY Product_ID;

SELECT Product_ID,
       AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
ORDER BY Average_Rating DESC;

SELECT Product_ID,
       AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) > 4;

SELECT Product.product_name,
       COUNT(Review.Review_ID) AS Total_Reviews,
       ROUND(AVG(Review.Rating), 2) AS Average_Rating
FROM Product
LEFT JOIN Review
ON Product.product_id = Review.Product_ID
GROUP BY Product.product_id, Product.product_name;

SELECT Product.product_name,
       COUNT(Review.Review_ID) AS Total_Reviews
FROM Product
LEFT JOIN Review
ON Product.product_id = Review.Product_ID
GROUP BY Product.product_id, Product.product_name
ORDER BY Total_Reviews DESC;

SELECT Product.product_name,
       AVG(Review.Rating) AS Average_Rating
FROM Product
JOIN Review
ON Product.product_id = Review.Product_ID
GROUP BY Product.product_id, Product.product_name
HAVING AVG(Review.Rating) >= 4;
SELECT Product.product_name,
       AVG(Review.Rating) AS Average_Rating
FROM Product
JOIN Review
ON Product.product_id = Review.Product_ID
GROUP BY Product.product_id, Product.product_name
HAVING AVG(Review.Rating) < 3;

SELECT COUNT(*) AS Five_Star_Ratings
FROM Review
WHERE Rating = 5;

SELECT COUNT(*) AS Four_Star_Ratings
FROM Review
WHERE Rating = 4;


SELECT COUNT(*) AS Low_Rated_Products
FROM (
    SELECT Product_ID
    FROM Review
    GROUP BY Product_ID
    HAVING AVG(Rating) < 3
) AS Low_Rated;

SELECT * FROM Review;

SELECT Product.product_name,
       COUNT(Review.Review_ID) AS Total_Reviews,
       ROUND(AVG(Review.Rating), 2) AS Average_Rating
FROM Product
LEFT JOIN Review
ON Product.product_id = Review.Product_ID
GROUP BY Product.product_id, Product.product_name;
