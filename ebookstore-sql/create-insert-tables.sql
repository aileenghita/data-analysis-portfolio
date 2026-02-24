CREATE DATABASE EBookStore
USE EBookStore

--Publishers Table
CREATE TABLE Publishers(
	PublisherID NVARCHAR(10) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	Address NVARCHAR(50) NOT NULL,
	ContactNumber NVARCHAR(15) NOT NULL
)

INSERT INTO Publishers(PublisherID, Name, Address, ContactNumber)
VALUES
('P01', 'Applewood Books', 'Massachusetts', '123456789'),
('P02', 'Book League of America', 'New York', '213678421'),
('P03', 'Chambers', 'London', '3874278564'),
('P04', 'Dove Medical Press', 'England', '1111921234'),
('P05', 'Express Publishing', 'Berkshire', '757579090'),
('P06', 'Four Courts Press', 'Dublin', '565676531'),
('P07', 'Greenery Press', 'California', '8742121234')

SELECT * FROM Publishers

--Books Table
CREATE TABLE Books(
	BookID NVARCHAR(15) PRIMARY KEY,
	PublisherID NVARCHAR(10) FOREIGN KEY REFERENCES Publishers(PublisherID) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Author NVARCHAR(50) NOT NULL,
	Price DECIMAL(10, 2) NOT NULL,
	StockItem INT NOT NULL CHECK (StockItem >= 0),
	Genre NVARCHAR(20) NOT NULL
)

INSERT INTO Books (BookID, PublisherID, Title, Author, Price, StockItem, Genre)
VALUES
('B001', 'P01', 'The Orchard Keeper', 'Cormac McCarthy', 19.99, 50, 'Fiction'),
('B002', 'P01', 'The Apple Tree Mystery', 'Jane Smith', 15.49, 30, 'Mystery'),
('B003', 'P02', 'The Great Gatsby', 'F. Scott Fitzgerald', 22.50, 40, 'Classic'),
('B004', 'P02', 'American Literature Anthology', 'Various Authors', 35.00, 25, 'Literature'),
('B005', 'P03', 'A Tale of Two Cities', 'Charles Dickens', 18.75, 60, 'Classic'),
('B007', 'P04', 'Medical Research Today', 'Dr. Emily White', 55.25, 20, 'Medical'),
('B009', 'P05', 'Learning English', 'Mark Thompson', 30.00, 45, 'Education'),
('B010', 'P05', 'Advanced Grammar Guide', 'Sarah Johnson', 27.50, 50, 'Education'),
('B013', 'P07', 'Sustainable Living', 'Emma Green', 20.99, 65, 'Lifestyle'),
('B014', 'P07', 'The Minimalist Life', 'James Walker', 18.25, 70, 'Lifestyle')

SELECT * FROM Books

--Members Table
CREATE TABLE Members(
	MemberID NVARCHAR(10) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) UNIQUE NOT NULL CHECK (Email LIKE '%@%' AND Email LIKE '%.com'),
	ContactNumber NVARCHAR(15) UNIQUE NOT NULL,
	Address NVARCHAR(50) NOT NULL
)

INSERT INTO Members(MemberID, Name, Email, ContactNumber, Address)
VALUES
('M01', 'Mark Lee', 'marklee@gmail.com', '0121212121', 'Kuala Lumpur'),
('M02', 'Julie Ahn', 'itsjullie@gmail.com', '01165712887', 'Bukit Bintang'),
('M03', 'Belle Shim', 'helloitsbelle@gmail.com', '012113122', 'Bukit Nanas'),
('M04', 'Andy Park', 'spaceadventurer@gmail.com', '01621212', 'Bukit Jalil'),
('M05', 'Jackson Wang', 'jackson@gmail.com', '01111102', 'Chow Kit'),
('M06', 'Eva Olson', 'olsoneva@gmail.com', '011110111', 'Perak'),
('M07', 'Joe Russell', 'jrussell123@gmail.com', '012131341', 'Selangor')

SELECT * FROM Members

--Items in Cart Table
CREATE TABLE CartItems(
	MemberID NVARCHAR(10) NOT NULL,
	BookID NVARCHAR(15) NOT NULL,
	Qty INT NOT NULL CHECK (Qty > 0),
	PRIMARY KEY(MemberID, BookID),
	FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
	FOREIGN KEY (BookID) REFERENCES Books(BookID)
)

INSERT INTO CartItems(MemberID, BookID, Qty)
VALUES
('M01', 'B001', 2),
('M01', 'B003', 1),
('M01', 'B005', 4),

('M02', 'B002', 3),

('M03', 'B007', 1),

('M04', 'B001', 4),
('M04', 'B010', 3),

('M05', 'B013', 5),
('M05', 'B014', 2),
('M05', 'B001', 3)

SELECT * FROM CartItems

--Orders made by Bookstore to Publisher Table
CREATE TABLE PurchaseOrders(
	PurchaseOrderID NVARCHAR(20) PRIMARY KEY,
	PublisherID NVARCHAR(10) FOREIGN KEY REFERENCES Publishers(PublisherID) NOT NULL,
	OrderDate DATE NOT NULL,
	OrderStatus NVARCHAR(20) NOT NULL,
	Total DECIMAL(10, 2) NOT NULL CHECK (Total > 0)
)

CREATE TABLE PurchaseOrderDetails(
	PurchaseOrderID NVARCHAR(20),
	BookID NVARCHAR(15),
	Qty INT NOT NULL CHECK (Qty > 0),
	PRIMARY KEY(PurchaseOrderID, BookID),
	FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
	FOREIGN KEY (BookID) REFERENCES Books(BookID),
)

INSERT INTO PurchaseOrders (PurchaseOrderID, PublisherID, OrderDate, OrderStatus, Total)
VALUES
('PO001', 'P01', '2023-09-01', 'Completed', 500.00),
('PO002', 'P02', '2023-09-05', 'Pending', 750.00),
('PO003', 'P03', '2023-09-10', 'Shipped', 600.00),
('PO004', 'P04', '2023-09-15', 'Completed', 800.00),
('PO005', 'P05', '2023-09-20', 'Pending', 450.00)

INSERT INTO PurchaseOrderDetails (PurchaseOrderID, BookID, Qty)
VALUES
('PO001', 'B001', 10),
('PO001', 'B002', 5),

('PO002', 'B003', 7),
('PO002', 'B004', 6),

('PO003', 'B005', 4),
('PO003', 'B007', 3),

('PO004', 'B014', 8),
('PO004', 'B013', 2),

('PO005', 'B009', 5),
('PO005', 'B010', 3)

SELECT * FROM PurchaseOrders
SELECT * FROM PurchaseOrderDetails

--Orders made by Members to Bookstore Table
CREATE TABLE MemberTransactions(
	MemberTransactionID NVARCHAR(20) PRIMARY KEY,
	MemberID NVARCHAR(10) FOREIGN KEY REFERENCES Members(MemberID) NOT NULL,
	TransactionDate DATE NOT NULL,
	Total DECIMAL(10, 2) NOT NULL CHECK (Total > 0),
	TransactionStatus NVARCHAR(20) NOT NULL
)

CREATE TABLE MemberTransactionDetails(
	MemberTransactionID NVARCHAR(20),
	BookID NVARCHAR(15),
	Qty INT NOT NULL CHECK (Qty > 0),
	Rating DECIMAL(3, 1),
	Comment NVARCHAR(200)
	PRIMARY KEY(MemberTransactionID, BookID)
	FOREIGN KEY (MemberTransactionID) REFERENCES MemberTransactions(MemberTransactionID),
	FOREIGN KEY (BookID) REFERENCES Books(BookID)
)

ALTER TABLE MemberTransactionDetails
ADD CONSTRAINT chk_Rating_Comment
CHECK (
    (Rating IS NULL AND Comment IS NULL)  -- If Rating is NULL, Comment must also be NULL
    OR
    (Rating IS NOT NULL AND Comment IS NULL)  -- If Rating is provided, Comment can be NULL
    OR
    (Rating IS NOT NULL AND Comment IS NOT NULL)  -- If Rating is provided, Comment can be given
)

INSERT INTO MemberTransactions (MemberTransactionID, MemberID, TransactionDate, Total, TransactionStatus)
VALUES
('MT001', 'M01', '2023-10-01', 300.00, 'Delivered'),
('MT002', 'M02', '2023-10-03', 450.50, 'Delivered'),
('MT003', 'M03', '2023-10-05', 200.75, 'Pending'),
('MT004', 'M04', '2023-10-07', 500.00, 'Shipped'),
('MT005', 'M05', '2023-10-10', 150.25, 'Delivered')

INSERT INTO MemberTransactionDetails (MemberTransactionID, BookID, Qty, Rating, Comment)
VALUES
('MT001', 'B001', 2, 7.5, 'Great book! Highly recommended.'),
('MT001', 'B002', 1, 5.0, 'Interesting read, but a bit slow.'),

('MT002', 'B003', 3, 8.0, 'Loved the story!'),
('MT002', 'B004', 2, 9.0, 'Good content and well-written.'),

('MT003', 'B001', 4, NULL, NULL),

('MT004', 'B007', 5, NULL, NULL),
('MT004', 'B001', 2, NULL, NULL),

('MT005', 'B009', 3, 5.0, 'Absolutely fantastic!'),
('MT005', 'B004', 1, 4.3, 'Good but expensive.')

INSERT INTO MemberTransactions (MemberTransactionID, MemberID, TransactionDate, Total, TransactionStatus)
VALUES
('MT006', 'M01', '2023-10-15', 250.00, 'Delivered'),
('MT007', 'M01', '2023-10-20', 180.75, 'Pending'),
('MT008', 'M02', '2023-10-18', 350.00, 'Shipped'),
('MT009', 'M02', '2023-10-22', 275.50, 'Delivered');

INSERT INTO MemberTransactionDetails (MemberTransactionID, BookID, Qty, Rating, Comment)
VALUES
('MT006', 'B005', 2, 6.5, 'Nice book for beginners.'),
('MT007', 'B003', 1, NULL, NULL), -- Pending
('MT008', 'B002', 3, NULL, NULL), -- Shipped
('MT009', 'B001', 1, 4.5, 'Too basic for my needs.'); -- Delivered

SELECT * FROM MemberTransactions
SELECT * FROM MemberTransactionDetails
