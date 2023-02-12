Create schema if not exists Ecommerce;
use ecommerce;

Create table Categorias (
Id_Categoria INT auto_increment not null primary key,
Nombre Varchar(50) not null,
Descripcion Varchar(100) not null
);

Create table Proveedores (
Id_Proveedor INT auto_increment not null primary key,
Nombre Varchar(50) not null,
Direccion Varchar(50) not null,
Telefono INT not null
);

Create table Productos (
Id_Producto INT auto_increment not null primary key,
Id_Proveedor INT not null,
Id_Categoria INT not null,
Precio INT not null,
P_Nombre Varchar(50) not null,
Stock INT not null,
foreign key (Id_Proveedor) references proveedores(Id_Proveedor),
foreign key (Id_Categoria) references Categorias(Id_Categoria) 
);

Create table Clientes (
Id_Cliente INT auto_increment not null primary key,
Nombre Varchar(50) not null,
Apellido Varchar(50) not null,
Direccion Varchar(50) not null,
Telefono INT not null
);

Create table pedidos (
Id_Pedido INT auto_increment not null primary key,
Id_Cliente INT not null,
Id_Producto INT not null,
F_Pedido date not null,
E_Pedido Varchar(50) not null,
Cantidad Int not null,
foreign key (Id_Cliente) references Clientes(Id_Cliente),
foreign key (Id_Producto) references Productos(Id_Producto) 
);

insert into Categorias (Id_Categoria, Nombre, Descripcion) Values
(1, 'Indumentaria', 'Articulos de vestimenta'),
(2, 'Cosmeticos', 'Accesorios para el cuidado estetico y personal'),
(3, 'Perfumeria', 'Fragancias para el uso cotidiano'),
(4, 'Gafas', 'Lentes para la proteccion de la vista'),
(5, 'Bolsos', 'Carteras y bolsos de mano para el transporte de pertenencias');

insert into Proveedores (Id_Proveedor, Nombre, Direccion, telefono) Values
(1, 'Casa Mia', 'Avenida Rivadavia 9800', 1133876545),
(2, 'Calzados Sofia', 'Avenida Avellaneda 2762', 1176850943),
(3, 'AirGlasses', 'Aguirre 670', 1187430972),
(4, 'Prendastilo', 'Avenida Cordoba 4960', 1138574587),
(5, 'Julietas', 'Thames 2450', 1139204371);

insert into Clientes (Id_Cliente, Nombre, Apellido, Direccion, telefono) Values
(1, 'Agustina', 'Lopez', 'Avenida Jose Maria Moreno 370', 1151286483),
(2, 'Tomas', 'Garcia', 'Aguero 1064', 1178261946),
(3, 'Clara', 'Gutierrez', 'Avenida Del Libertador 5948', 1179553248),
(4, 'Brenda', 'Villar', 'Sinclair 3067', 1188865214),
(5, 'Julian', 'Piernabuena', 'Blanco Encalada 2256', 1139204371);

insert into Productos (Id_Producto, Id_Proveedor,Id_Categoria, Precio, P_Nombre, stock) Values
(1, 2, 1, 20000, 'Sandalias Urbanas', 10),
(2, 4, 5, 27200,'Bandolera', 4),
(3, 4, 1, 500, 'Blusa Primavera', 12),
(4, 3, 4, 32000, 'Aviadores', 3),
(5, 5, 3, 15400, 'Light Blue', 7),
(6, 1, 2, 8700, 'Labial', 14);

insert into Pedidos (Id_Pedido, Id_Cliente,Id_Producto, F_Pedido, E_Pedido, cantidad) Values
(1, 3, 1, '2023-01-22', 1, 4),
(2, 3, 5, '2023-01-31', 0, 2),
(3, 4, 1, '2023-01-18', 1, 5),
(4, 2, 4, '2023-01-20', 1, 2),
(5, 5, 3, '2023-01-30', 0, 1),
(6, 1, 2, '2023-01-22', 1, 3);

 /* Funcion que permite cual fue el producto mas vendido*/

Delimiter //

CREATE FUNCTION Producto_Mas_Vendido (Fecha_Inicio DATE, Fecha_final DATE)
RETURNS VARCHAR(100)
deterministic	
BEGIN
DECLARE Producto_Mas_Vendido VARCHAR(100);
SELECT p.P_Nombre INTO Producto_Mas_Vendido
FROM productos p
JOIN (SELECT Id_producto, SUM(cantidad) AS Total_Vendido
      FROM pedidos
      WHERE F_Pedido BETWEEN Fecha_Inicio AND Fecha_final
      GROUP BY Id_producto
      ORDER BY Total_Vendido DESC
      LIMIT 1) AS Top_Producto ON p.Id_producto = Top_Producto.Id_producto;
RETURN Producto_Mas_Vendido;
END;

//

 /* Funcion que permite visualizar al cliente que mayor cantidad de unidades compro */

Delimiter //

CREATE FUNCTION Mejor_Cliente (Fecha_Inicio DATE, Fecha_final DATE)
RETURNS VARCHAR(100)
deterministic	
BEGIN
DECLARE Mejor_Cliente VARCHAR(100);
SELECT concat(c.Nombre, ' ', c.apellido) INTO Mejor_Cliente
FROM clientes as c
JOIN (SELECT Id_cliente, SUM(cantidad) AS Total_Vendido
      FROM pedidos
      WHERE F_Pedido BETWEEN Fecha_Inicio AND Fecha_final
      GROUP BY Id_cliente
      ORDER BY Total_Vendido DESC
      LIMIT 1) AS Top_Producto ON c.Id_cliente = Top_Producto.Id_cliente;
RETURN Mejor_Cliente;
END;

//




