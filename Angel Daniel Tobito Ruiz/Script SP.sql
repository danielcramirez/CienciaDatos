create database dbcrud;

go 

use dbcrud;

create table Empleado(
	IdEmpleado int primary key identity,
	NombreCompleto varchar(50),
	Correo varchar(50),
	Sueldo decimal(10,2),
	FechaContrato date
)

go

insert into Empleado(NombreCompleto,Correo,Sueldo,FechaContrato)
values ('Johan Caicedo', 'johanscaicedo@ucundinamarca.edu.co', 4500, '2024-02-10')

select * from Empleado;

create proc sp_listaEmpleados
as
begin
	select
		IdEmpleado,
		NombreCompleto,
		Correo,
		Sueldo,
		CONVERT(char(10),FechaContrato,103)[FechaContrato]
	from Empleado
end

go
create proc sp_obtenerEmpleados(
	@IdEmpleado int
)
as
begin
	select
		IdEmpleado,
		NombreCompleto,
		Correo,
		Sueldo,
		CONVERT(char(10),FechaContrato,103)[FechaContrato]
	from Empleado where IdEmpleado = @IdEmpleado
end

create proc sp_crearEmpleado(
	@NombreCompleto varchar(50),
	@Correo varchar(50),
	@Sueldo decimal(10,2),
	@FechaContrato varchar(10)
)
as
begin
	set dateformat dmy
	insert into Empleado(
		NombreCompleto,
		Correo,
		Sueldo,
		FechaContrato
	)
	values (
		@NombreCompleto,
		@Correo,
		@Sueldo,
		CONVERT(date,@FechaContrato)
	)
end

go

create proc sp_editarEmpleado(
	@IdEmpleado int,
	@NombreCompleto varchar(50),
	@Correo varchar(50),
	@Sueldo decimal(10,2),
	@FechaContrato varchar(10)
)
as
begin
	set dateformat dmy
	update Empleado
		set
		NombreCompleto = @NombreCompleto,
		Correo = @Correo,
		Sueldo = @Sueldo,
		FechaContrato = CONVERT(date,@FechaContrato)
		where IdEmpleado = @IdEmpleado
end

create proc sp_eliminarEmpleado(
	@IdEmpleado int
)
as
begin
		delete from Empleado where IdEmpleado = @IdEmpleado
end