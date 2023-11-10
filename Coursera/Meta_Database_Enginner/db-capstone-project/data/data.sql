-- Insert dummy data into CustomerDetails
INSERT INTO `LittleLemonDB`.`CustomerDetails` (`Name`, `ContactDetail`)
VALUES
('John Doe', 'john.doe@example.com'),
('Jane Doe', 'jane.doe@example.com'),
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('David', 'david@example.com'),
('Emily', 'emily@example.com'),
('Frank', 'frank@example.com'),
('Grace', 'grace@example.com'),
('Hannah', 'hannah@example.com');

-- Insert dummy data into StaffInformation
INSERT INTO `LittleLemonDB`.`StaffInformation` (`Name`, `Role`, `Salary`)
VALUES
('Sarah', 'Manager', 55000),
('Tom', 'Waiter', 30000),
('Linda', 'Chef', 40000),
('Robert', 'Cashier', 31000),
('Daniel', 'Waiter', 32000),
('Susan', 'Hostess', 28000),
('Chris', 'Manager', 60000),
('Jessica', 'Chef', 38000),
('Brian', 'Waiter', 29000),
('Kim', 'Hostess', 27000);

-- Insert dummy data into Menus
INSERT INTO `LittleLemonDB`.`Menus` (`Name`, `Type`, `Price`)
VALUES
('Cheese Burger', 'Main', 10),
('Veggie Burger', 'Main', 9),
('French Fries', 'Side', 3),
('Caesar Salad', 'Main', 8),
('Chicken Wings', 'Appetizer', 6),
('Coca Cola', 'Drink', 2),
('Pasta', 'Main', 11),
('Rice', 'Side', 4),
('Margarita', 'Drink', 5),
('Ice Cream', 'Dessert', 4);

-- Insert dummy data into Bookings
INSERT INTO `LittleLemonDB`.`Bookings` (`CustomerID`, `StaffID`, `Date`, `TableNumber`)
VALUES
(1, 1, '2023-09-01 12:00:00', 10),
(2, 2, '2023-09-01 12:30:00', 12),
(3, 3, '2023-09-02 13:00:00', 14),
(4, 4, '2023-09-02 14:00:00', 16),
(5, 5, '2023-09-03 15:00:00', 18),
(6, 6, '2023-09-03 16:00:00', 20),
(7, 7, '2023-09-04 17:00:00', 22),
(8, 8, '2023-09-04 18:00:00', 24),
(9, 9, '2023-09-05 19:00:00', 26),
(10, 10, '2023-09-05 20:00:00', 28);

-- Insert dummy data into Orders
INSERT INTO `LittleLemonDB`.`Orders` (`CustomerID`, `MenuItemID`, `StaffID`, `Date`, `Quantity`, `TotalCost`)
VALUES
(1, 1, 1, '2023-09-01 12:00:00', 2, 171),
(2, 2, 2, '2023-09-01 12:30:00', 1, 174),
(3, 3, 3, '2023-09-02 13:00:00', 3, 358),
(4, 4, 4, '2023-09-02 14:00:00', 1, 265),
(5, 5, 5, '2023-09-03 15:00:00', 4, 252),
(6, 6, 6, '2023-09-03 16:00:00', 2, 465),
(7, 7, 7, '2023-09-04 17:00:00', 1, 65),
(8, 8, 8, '2023-09-04 18:00:00', 2, 437),
(9, 9, 9, '2023-09-05 19:00:00', 3, 484),
(10, 10, 10, '2023-09-05 20:00:00', 1, 111);

-- Insert dummy data into OrderDeliveryStatuses
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatuses` (`OrderID`, `Date`, `Status`)
VALUES
(1, '2023-09-01 12:15:00', 'Delivered'),
(2, '2023-09-01 12:45:00', 'Preparing'),
(3, '2023-09-02 13:15:00', 'Preparing'),
(4, '2023-09-02 14:15:00', 'Out for delivery'),
(5, '2023-09-03 15:15:00', 'Out for delivery'),
(6, '2023-09-03 16:15:00', 'Delivered'),
(7, '2023-09-04 17:15:00', 'Preparing'),
(8, '2023-09-04 18:15:00', 'Delivered'),
(9, '2023-09-05 19:15:00', 'Delivered'),
(10, '2023-09-05 20:15:00', 'Delivered');
