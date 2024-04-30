use mysql;

-- 1) Crea las cuentas de usuario y mediante el comando adecuado demuestra en cada caso que dispone de los privilegios asignados e indica el script. Explica cómo han variado cada una de las tablas de permisos: user, db, tables_priv, columns_priv.

create user 'Gaston_ALL'@localhost;
create user 'Gaston_BD'@localhost;
create user 'Gaston_TB'@localhost;
create user 'Gaston_COL'@localhost;

grant select, insert, update, delete on *.* to 'Gaston_ALL'@localhost with grant option;
grant select on ventas.* to 'Gaston_BD'@localhost;
grant select on empleados.* to 'Gaston_BD'@localhost;
grant select on ventas.comercial to 'Gaston_TB'@localhost;
grant select on empleados.empleado to 'Gaston_TB'@localhost;
grant select(nombre, apellido1, apellido2, nif, codigo_departamento) on empleados.empleado to 'Gaston_COL'@localhost;

select * from user;
select * from db;
select * from tables_priv;
select * from columns_priv;

-- 2) Especifica la sentencia para la que NOMBRE_ALL pueda dar privilegios de manipulación de datos al usuario NOMBRE_TB sobre las tablas pedido y cliente. Comprueba que realiza lo esperado

grant select, insert, update, delete on ventas.pedido to 'Gaston_TB'@localhost;
grant select, insert, update, delete on ventas.cliente to 'Gaston_TB'@localhost;

-- 3) Conectado como TUNOMBRE_ALL, amplia los privilegios de TUNOMBRE_BD para que éste pueda otorgar privilegios a otros

grant grant option on *.* to 'Gaston_BD'@localhost;

-- 4) Conectado como TUNOMBRE_BD, otorga privilegios a TUNOMBRE_TB para insertar datos sobre las tablas comercial y empleados. ¿Se puede? Justifícalo y comprueba la respuesta

grant insert on ventas.comercial to 'Gaston_TB'@localhost;
grant insert on empleados.empleado to 'Gaston_TB'@localhost;
-- No se puede porque un usuario solo puede otorgar los privilegios que ya tiene. Gaston_BD solo tiene privilegios de consulta, no de inserción.

-- 5) Conectado como TUNOMBRE_BD, otorga privilegios a TUNOMBRE_TB para consultas sobre la tabla departamentos. ¿Se puede? Justifícalo y comprueba la respuesta

grant select on empleados.departamento to 'Gaston_TB'@localhost;
-- Sí puede, ya que tiene tanto el privilegio grant option como el privilegio de consulta sobre la tabla departamentos.

-- 6) Elimina el privilegio de otorgar privilegios de TUNOMBRE_ALL.

revoke grant option on *.* from 'Gaston_ALL'@localhost;

-- 7) ¿Podría cederle nuevamente ese privilegio el usuario TUNOMBRE_BD? ¿Qué ámbito tendría? Comprueba si se puede y justifica la respuesta.

grant grant option on *.* to 'Gaston_ALL'@localhost;

-- Siendo que a Gaston_BD se le cedió grant option con ámbito *.*, este usuario puede dar privilegios (solo los que tiene) en todas las bases de datos y tablas. Por tanto, le devolverá a Gaston_ALL el grant option con acceso a todo.