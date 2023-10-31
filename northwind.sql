# Proyecto: Análisis de Ventas (Usando la base de datos de Northwind)

# Descripción: Analizar las ventas de productos utilizando la base de datos Northwind para identificar patrones de compra y tendencias de ventas.

# Tareas Realizadas:

### Importar datos de ventas, productos y clientes
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
  
### Realizar consultas SQL para calcular las ventas totales por producto y región.
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
### Identificar productos más vendidos y áreas geográficas con mayores ventas.
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
### Areas geográficas con mayores ventas.
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
### 
SELECT 
    YEAR(o.OrderDate) AS 'Año',
    MONTH(o.OrderDate) AS 'Mes',
    SUM(od.Quantity * od.UnitPrice) AS 'Ventas Totales'
FROM 
    Orders o
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY 
    YEAR(o.OrderDate), MONTH(o.OrderDate);
### Segmentación de Clientes
SELECT 
    c.CustomerID,
    c.CompanyName,
    SUM(od.Quantity * od.UnitPrice) AS 'Ventas Totales'
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CompanyName
ORDER BY 
    SUM(od.Quantity * od.UnitPrice) DESC;
### Análisis de Rentabilidad
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity * od.UnitPrice) AS 'Ventas Totales',
    SUM(od.Quantity * p.UnitPrice) AS 'Costos Totales',
    SUM(od.Quantity * od.UnitPrice) - SUM(od.Quantity * p.UnitPrice) AS 'Rentabilidad'
FROM 
    Products p
JOIN 
    [Order Details] od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    SUM(od.Quantity * od.UnitPrice) DESC;
### Análisis de Productos Relacionados
SELECT 
    od1.ProductID AS 'Producto 1',
    p1.ProductName AS 'Nombre Producto 1',
    od2.ProductID AS 'Producto 2',
    p2.ProductName AS 'Nombre Producto 2',
    COUNT(*) AS 'Frecuencia'
FROM 
    [Order Details] od1
JOIN 
    [Order Details] od2 ON od1.OrderID = od2.OrderID AND od1.ProductID < od2.ProductID
JOIN 
    Products p1 ON od1.ProductID = p1.ProductID
JOIN 
    Products p2 ON od2.ProductID = p2.ProductID
GROUP BY 
    od1.ProductID, od2.ProductID, p1.ProductName, p2.ProductName
ORDER BY 
    COUNT(*) DESC;
