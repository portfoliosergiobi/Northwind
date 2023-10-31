# Proyecto: Análisis de Ventas (Usando la base de datos de Northwind)

# Descripción: Analizar las ventas de productos utilizando la base de datos Northwind para identificar patrones de compra y tendencias de ventas.

# Tareas Realizadas:

# Importar datos de ventas, productos y clientes
SELECT 
    o.OrderID AS 'ID de Venta',
    o.OrderDate AS 'Fecha de Venta',
    c.CustomerID AS 'ID de Cliente',
    c.CompanyName AS 'Nombre de la Empresa Cliente',
    p.ProductID AS 'ID de Producto',
    p.ProductName AS 'Nombre del Producto',
    od.Quantity AS 'Cantidad Vendida',
    od.UnitPrice AS 'Precio Unitario'
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID;
  
# Realizar consultas SQL para calcular las ventas totales por producto y región.
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity * od.UnitPrice) AS 'Ventas Totales'
FROM 
    Products p
JOIN 
    [Order Details] od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    SUM(od.Quantity * od.UnitPrice) DESC;

# Identificar productos más vendidos y áreas geográficas con mayores ventas.
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS 'Cantidad Vendida'
FROM 
    Products p
JOIN 
    [Order Details] od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    SUM(od.Quantity) DESC;

SELECT 
    r.RegionID,
    r.RegionDescription,
    SUM(od.Quantity) AS 'Cantidad Vendida'
FROM 
    Region r
JOIN 
    Territories t ON r.RegionID = t.RegionID
JOIN 
    EmployeeTerritories et ON t.TerritoryID = et.TerritoryID
JOIN 
    Orders o ON et.EmployeeID = o.EmployeeID
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    r.RegionID, r.RegionDescription
ORDER BY 
    SUM(od.Quantity) DESC;




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

