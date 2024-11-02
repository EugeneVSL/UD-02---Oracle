
-- Contiene las familias a las que pertenecen los productos, como por ejemplo ordenadores, impresoras,etc.
CREATE TABLE familia (
    cod_familia NUMBER(3) PRIMARY KEY,
    deno_familia VARCHAR(50) NOT NULL UNIQUE
);

-- contendrá información general sobre los productos que distribuye la empresa a las tiendas.
CREATE TABLE producto (
    cod_producto NUMBER(5) PRIMARY KEY,
    deno_producto VARCHAR(20) NOT NULL,
    description VARCHAR(100),
    precio_base NUMBER(8, 2) NOT NULL CHECK(precio_base > 0),
    porc_reposicion NUMBER(3) CHECK(porc_reposicion > 0),
    unidades_minimas NUMBER(4) NOT NULL CHECK(unidades_minimas > 0),
    -- Clave ajena, referencia a Codfamilia de la tabla FAMILIA. Debe tener contenido.
    cod_familia NUMBER(3) NOT NULL CONSTRAINT cod_familia_FK REFERENCES familia
);

-- contendrá información básica sobre las tiendas que distribuyen los productos.
CREATE TABLE tienda (
    cod_tienda NUMBER(3) PRIMARY KEY,
    deno_tienda VARCHAR(20) NOT NULL,
    telefono VARCHAR(11),
    codigo_postal VARCHAR(5) NOT NULL,
    provincia VARCHAR(5) NOT NULL
);

-- Contendrá para cada tienda el número de unidades disponibles de cada producto. 
-- La clave primaria está formada por la concatenación de los campos Codtienda y Codproducto.
CREATE TABLE stock (
    cod_tienda NUMBER(3) NOT NULL CONSTRAINT cod_tienda_FK REFERENCES tienda(cod_tienda),
    cod_producto NUMBER(5) NOT NULL CONSTRAINT cod_producto_FK REFERENCES producto(cod_producto),
    unidades NUMBER(6) NOT NULL CHECK(unidades >= 0),
    CONSTRAINT stock_PK PRIMARY KEY(cod_tienda, cod_producto)
);
