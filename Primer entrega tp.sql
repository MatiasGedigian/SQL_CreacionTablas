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
foreign key (Id_Cliente) references Clientes(Id_Cliente),
foreign key (Id_Producto) references Productos(Id_Producto) 
);



