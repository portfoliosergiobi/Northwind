Proyecto: Análisis de Ventas (Usando Northwind Database)

Descripción: Analizar las ventas de productos utilizando la base de datos Northwind para identificar patrones de compra y tendencias de ventas.

Tareas Realizadas:

- Importar datos de ventas, productos y clientes desde la base de datos Northwind.
- Realizar consultas SQL para calcular las ventas totales por producto y región.
- Utilizar joins para combinar datos de ventas con datos de clientes y productos.
- Identificar productos más vendidos y áreas geográficas con mayores ventas.

  

--Top 5 de los Productos más caros
SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--Promedio de precios de los productos por categoría
SELECT CategoryName, AVG(UnitPrice) AS Precio_Promedio
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName;

--Clientes que han realizado más compras
SELECT Customers.CustomerID, Customers.ContactName, COUNT(Orders.OrderID) AS Total_Pedidos
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.ContactName
ORDER BY Total_Pedidos DESC;

--Empleados que han manejado más pedidos
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS Total_Pedidos
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY Total_Pedidos DESC;

--Empleados que han manejado pedidos por más de 10 clientes distintos.
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(DISTINCT Customers.CustomerID) AS Cliente_Unico
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING COUNT(DISTINCT Customers.CustomerID) > 10;

