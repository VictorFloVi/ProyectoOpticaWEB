
go
use PISW_OPTICA_WEB
go
--REGISTROS EN TABLA PERFIL
INSERT INTO PERFIL(Descripcion) VALUES ('ADMINISTRADOR'),('EMPLEADO')

GO
--REGISTROS EN TABLA MENU
INSERT INTO MENU(Nombre,Icono) VALUES
('Mantenimiento','fas fa-tools'),
('Clientes','fas fa-user-friends'),
('Compras','fas fa-cart-arrow-down'),
('Ventas','fas fa-cash-register'),
('Reportes','far fa-clipboard')
GO



--REGISTROS EN TABLA SUBMENU
INSERT INTO SUBMENU(IdMenu,Nombre,Controlador,Vista,Icono) VALUES
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenimiento'),'Perfil','Rol','Crear','fas fa-user-tag'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenimiento'),'Asignar Permisos','Permisos','Crear','fas fa-user-lock'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenimiento'),'Usuarios','Usuario','Crear','fas fa-users-cog'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenimiento'),'Categorias','Categoria','Crear','fab fa-wpforms'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenimiento'),'Productos','Producto','Crear','fas fa-box-open'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Clientes'),'Clientes','Cliente','Crear','fas fa-user-shield'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Proveedores','Proveedor','Crear','fas fa-shipping-fast'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Asignar producto a Sucursal','Producto','Asignar','fas fa-dolly'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Registrar Compra','Compra','Crear','fas fa-cart-arrow-down'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Consultar Compra','Compra','Consultar','far fa-list-alt'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'),'Sucursales','Tienda','Crear','fas fa-store-alt'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'),'Registrar Venta','Venta','Crear','fas fa-cash-register'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'),'Consultar Venta','Venta','Consultar','far fa-clipboard'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Reportes'),'Productos por sucursal','Reporte','Producto','fas fa-boxes'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Reportes'),'Ventas','Reporte','Ventas','fas fa-shopping-basket')

GO


--REGISTROS EN TABLA SUCURSAL
INSERT INTO SUCURSAL(Nombre,RUC,Direccion,Telefono) VALUES ('Sucursal 001','25689789654','AV.GRANDE 123','963852896')

GO
--REGISTROS USUARIO
insert into usuario(Nombres,Apellidos,Correo,Clave,IdSucursal,IdPerfil)
values('Administrador','Thopsom','admin@gmail.com','7932b2e116b076a54f452848eaabd5857f61bd957fe8a218faf216f24c9885bb',(select TOP 1 IdSucursal from SUCURSAL where Nombre = 'Sucursal 001'),(select TOP 1 IdPerfil from PERFIL where Descripcion = 'ADMINISTRADOR'))
go
insert into usuario(Nombres,Apellidos,Correo,Clave,IdSucursal,IdPerfil)
values('Sucursal','azgun','sucursal@gmail.com','29cfa0f8e37e40a1a7a723aa88eca2cc050f270417969bfbe753f6bc0919aefe',(select TOP 1 IdSucursal from SUCURSAL where Nombre = 'Sucursal 001'),(select TOP 1 IdPerfil from PERFIL where Descripcion = 'EMPLEADO'))


GO
--REGISTROS EN TABLA PERMISOS
INSERT INTO PERMISOS(IdPerfil,IdSubMenu)
SELECT (select TOP 1 IdPerfil from PERFIL where Descripcion = 'ADMINISTRADOR'), IdSubMenu FROM SUBMENU
go
INSERT INTO PERMISOS(IdPerfil,IdSubMenu,Activo)
SELECT (select TOP 1 IdPerfil from PERFIL where Descripcion = 'EMPLEADO'), IdSubMenu, 0 FROM SUBMENU 
go

update p set p.Activo = 1 from PERMISOS p
inner join SUBMENU sm on sm.IdSubMenu = p.IdSubMenu
where sm.Controlador in ('Venta') and p.IdPerfil = (select TOP 1 IdPerfil from PERFIL where Descripcion = 'EMPLEADO')
GO


--REGISTRO EN TABLA CATEGORIA
INSERT INTO CATEGORIA(Descripcion) VALUES
('Gafas oftálmicas'),
('Gafas de sol'),
('Monturas'),
('Lentes de contacto')

GO
--REGISTRO EN TABLA PRODUCTO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
values
(
RIGHT('000000' + convert(varchar(max),(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO)),6),
(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO),
'Tomato Glasses TJCC4',
'Los marcos son flexibles',
(select top 1 IdCategoria from CATEGORIA where Descripcion = 'Gafas oftálmicas')
)
GO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
values
(
RIGHT('000000' + convert(varchar(max),(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO)),6),
(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO),
'Material Marco: Acetato',
'Forma Lente: Clubmaster',
(select top 1 IdCategoria from CATEGORIA where Descripcion = 'Gafas de sol')
)
GO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
values
(
RIGHT('000000' + convert(varchar(max),(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO)),6),
(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO),
'Tomato Glasses TJCC4',
'Estética minimalista y sofisticada',
(select top 1 IdCategoria from CATEGORIA where Descripcion = 'Monturas')
)
GO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
values
(
RIGHT('000000' + convert(varchar(max),(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO)),6),
(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO),
'Material	Senofilcon A',
'Tipo de afección visual: Miopia e Hipermetropia',
(select top 1 IdCategoria from CATEGORIA where Descripcion = 'Lentes de contacto')
)
GO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
values
(
RIGHT('000000' + convert(varchar(max),(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO)),6),
(select isnull(max(ValorCodigo),0) + 1 from PRODUCTO),
'EASYTWIST TURBO FLEX',
'Marco metálico flexible tamaño 56-18 145',
(select top 1 IdCategoria from CATEGORIA where Descripcion = 'Gafas oftálmicas')
)


go
Insert into cliente(tipodocumento,numerodocumento,nombre,direccion,telefono) values 
('DNI','34231223','Jose Perez','av. Test 123','12345342'),
('DNI','56567878','Maria Paz','av. Test 124','12345343'),
('DNI','78907878','Thalia Quiñon','av. Test 125','12345344'),
('DNI','56346767','Belem Madara','av. Test 126','12345345'),
('DNI','34234234','Teresa espinoza','av. Test 127','12345346'),
('DNI','67788978','Arturo Sanchez','av. Test 128','12345347'),
('DNI','34311232','Pere Calvo','av. Test 129','12345348'),
('DNI','23234545','Naima Prat','av. Test 130','12345349'),
('DNI','45234545','Nicole Barreiro','av. Test 131','12345350'),
('DNI','23231212','Iratxe Ahmed','av. Test 132','12345351'),
('DNI','67678990','Monserrat Ballester','av. Test 133','12345352'),
('DNI','45455666','Alfonsa Mendoza','av. Test 135','12345354'),
('DNI','65765888','Alex Ramon','av. Test 136','12345355'),
('DNI','89768677','Pablo Rosell','av. Test 137','12345356'),
('DNI','67676789','Sebastian Palomino','av. Test 138','12345357'),
('DNI','76867878','Hamza Grau','av. Test 139','12345358'),
('DNI','89934233','Faustino Romo','av. Test 140','12345359')

go

insert into PROVEEDOR(ruc,RazonSocial,Telefono,Correo,Direccion) values
('25689789654','TIENDA ÓPTICA DISTRIBUCIONES','345234234','topticd@tod.com','Av. Los Visionarios'),
('45623412312','VINTAGE FRAMES COMPANY','123123456','vframesco@vfc.com','Av. Los Hérores')

