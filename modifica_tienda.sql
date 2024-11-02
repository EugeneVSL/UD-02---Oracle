-- Modificar las tablas creadas en el ejercicio anterior siguiendo las indicaciones. 
-- Los ejercicios se incluirán en un script llamado ModificaTienda.sql. 
-- Cada uno de ellos, como en el ejercicio anterior, irá precedido de un comentario con el enunciado.

-- Añadir a la tabla STOCK
-- -- Una columna de tipo fecha llamada FechaUltimaEntrada que por defecto tome el valor de la fecha actual.
-- -- Una columna llamada Beneficio que contendrá el tipo de porcentaje de beneficio que esa tienda aplica 
-- -- en ese producto. Se debe controlar que el valor que almacene sea 1,2, 3, 4 o 5. 
ALTER TABLE stock ADD (
    fecha_ultima_entrada DATE DEFAULT SYSDATE,
    beneficio NUMBER(2) CHECK(beneficio BETWEEN 1 AND 5)
);

-- En la tabla PRODUCTO - Eliminar de la tabla producto la columna Descripción.
ALTER TABLE producto DROP COLUMN description;

-- En la tabla PRODUCTO - Añadir una columna llamada perecedero que únicamente acepte los valores: S o N.
ALTER TABLE producto ADD (
    perecedero CHAR CHECK(perecedero IN ('S', 'N'))   
);

-- En la tabla PRODUCTO - Modificar el tamaño de la columna Denoproducto a 50.
ALTER TABLE producto MODIFY (
    deno_producto VARCHAR(50)
);

-- En la tabla FAMILIA - Añadir una columna llamada IVA, que represente el porcentaje de IVA y 
-- únicamente pueda contener los valores 21,10,ó 4.
ALTER TABLE familia ADD (
    iva NUMBER(2) NOT NULL CHECK(iva IN (4, 10, 21))
);

-- En la tabla tienda
-- -- La empresa desea restringir el número de tiendas con las que trabaja, de forma que no pueda haber 
-- -- más de una tienda en una misma zona (la zona se identifica por el código postal). Definir mediante DDL las 
-- -- restricciones necesarias para que se cumpla en el campo correspondiente.
ALTER TABLE tienda MODIFY (
    codigo_postal UNIQUE
);

-- Renombra la tabla STOCK por PRODXTIENDAS.
RENAME stock TO PRODXTIENDAS;

-- Elimina la tabla FAMILIA y su contenido si lo tuviera.
-- eliminar la foreign key cod_familia_FK
ALTER TABLE producto DROP CONSTRAINT cod_familia_FK;
DROP TABLE familia;

-- Estos passos no se pueden ejecutar en este script. Necesitamos privilegios de SYS

-- Crea un usuario llamado C##INVITADO siguiendo los pasos de la unidad 1 y dale 
-- todos los privilegios sobre la tabla PRODUCTO.
-- CONNECT sys AS sysdba;
-- CREATE USER c##invitado IDENTIFIED BY invitado DEFAULT TABLESPACE users;
-- GRANT CONNECT TO c##invitado;
-- GRANT ALL PRIVILEGES ON TABLE producto TO c##invitado;

