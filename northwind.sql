--Top 5 de los Productos m�s caros
SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--Promedio de precios de los productos por categor�a
SELECT CategoryName, AVG(UnitPrice) AS Precio_Promedio
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName;

--Clientes que han realizado m�s compras
SELECT Customers.CustomerID, Customers.ContactName, COUNT(Orders.OrderID) AS Total_Pedidos
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.ContactName
ORDER BY Total_Pedidos DESC;

--Empleados que han manejado m�s pedidos
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS Total_Pedidos
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY Total_Pedidos DESC;

--Empleados que han manejado pedidos por m�s de 10 clientes distintos.
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(DISTINCT Customers.CustomerID) AS Cliente_Unico
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING COUNT(DISTINCT Customers.CustomerID) > 10;
