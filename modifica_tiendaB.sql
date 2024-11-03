-- Renombra la tabla STOCK por PRODXTIENDAS.
ALTER TABLE stock RENAME TO PRODXTIENDAS;

-- Elimina la tabla FAMILIA y su contenido si lo tuviera.
-- eliminar la foreign key producto_familia_fk
ALTER TABLE producto DROP CONSTRAINT producto_familia_fk;
DROP TABLE familia;

-- Estos passos no se pueden ejecutar en este script. Necesitamos privilegios de SYS
-- ------------------------------------------------------------------------------
-- Crea un usuario llamado C##INVITADO siguiendo los pasos de la unidad 1 y dale 
-- todos los privilegios sobre la tabla PRODUCTO.
-- CONNECT sys AS sysdba;
CREATE USER c##invitado IDENTIFIED BY invitado DEFAULT TABLESPACE users;

-- Dale todos los privilegios sobre la tabla PRODUCTO
GRANT ALL ON c##eugene.producto to c##invitado;

-- Retira los permisos de modificar la estructura de la tabla y borrar contenido de la tabla PRODUCTO al usuario anterior.
REVOKE ALL ON c##eugene.producto FROM c##invitado;

-- -- Borrar contenido de la tabla PRODUCTO al usuario anterior.
TRUNCATE TABLE c##eugene.producto;
