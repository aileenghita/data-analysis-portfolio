--TOP 5 Books with Highest Engagement
SELECT TOP 5
	Books.BookID, Books.Title, COUNT(MemberTransactionDetails.Rating) AS TotalFeedback
FROM Books
FULL JOIN MemberTransactionDetails
ON MemberTransactionDetails.BookID = Books.BookID
GROUP BY Books.BookID, Books.Title
ORDER BY TotalFeedback DESC;

--Books with Stock Above Average
SELECT BookID, StockItem FROM Books
WHERE StockItem > (SELECT AVG(StockItem) FROM Books)
GROUP BY StockItem, BookID

--Total Published Books by each publisher
SELECT Publishers.PublisherID, Publishers.Name, COUNT(Books.Title) AS 'Total Published Books'
FROM Publishers
FULL JOIN Books
ON Publishers.PublisherID = Books.PublisherID
GROUP BY Publishers.PublisherID, Publishers.Name

--Total Books by Genre
SELECT Genre, COUNT(BookID) AS 'Total Books' FROM Books
GROUP BY Genre

--Members with no transaction
SELECT Members.MemberID, Name, Email, ContactNumber, Address FROM Members
FULL JOIN MemberTransactions
ON Members.MemberID = MemberTransactions.MemberID
WHERE MemberTransactions.MemberID IS NULL

--Genre with the most number of quantity in stock
WITH GenreStock AS (
    SELECT Genre, SUM(StockItem) AS TotalStock
    FROM Books
    GROUP BY Genre
)
SELECT Genre, TotalStock AS 'Total Stock'
FROM GenreStock
WHERE TotalStock = (SELECT MAX(TotalStock) FROM GenreStock)

--Transactions not delivered
SELECT Members.MemberID, Members.Address, Members.ContactNumber,
Books.BookID, Books.Title,
MemberTransactionDetails.Qty,
MemberTransactions.TransactionDate, MemberTransactions.TransactionStatus
FROM MemberTransactionDetails
JOIN MemberTransactions
ON MemberTransactions.MemberTransactionID = MemberTransactionDetails.MemberTransactionID
JOIN Members
ON MemberTransactions.MemberID = Members.MemberID
JOIN Books
ON Books.BookID = MemberTransactionDetails.BookID
WHERE MemberTransactions.TransactionStatus != 'Delivered'

--Members with > 2 Orders
SELECT MemberTransactions.MemberID, Members.Name,
COUNT(MemberTransactions.MemberID) AS 'Total Transactions'
FROM MemberTransactions
JOIN Members
ON Members.MemberID = MemberTransactions.MemberID
GROUP by MemberTransactions.MemberID, Members.Name
HAVING COUNT(MemberTransactions.MemberID) > 2

--TOP 5 Members by Revenue
SELECT TOP 5 MemberID, Total FROM MemberTransactions
