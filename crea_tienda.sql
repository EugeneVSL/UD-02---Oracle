

CREATE TABLE familia (
    cod_familia  NUMBER(3) NOT NULL,
    deno_familia VARCHAR(50 BYTE) NOT NULL
);

ALTER TABLE familia ADD CONSTRAINT familia_PK PRIMARY KEY (cod_familia);
ALTER TABLE familia ADD CONSTRAINT familia_UN UNIQUE (deno_familia );

CREATE TABLE producto (
    cod_producto        NUMBER(5) NOT NULL,
    deno_producto       VARCHAR(20 BYTE) NOT NULL,
    description         VARCHAR(100 BYTE),
    precio_base         NUMBER(8, 2) NOT NULL,
    porc_reposicion     NUMBER(3),
    unidades_minimas    NUMBER(4) NOT NULL,
    familia_cod_familia NUMBER(3) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_PK PRIMARY KEY (cod_producto);
ALTER TABLE producto ADD CONSTRAINT producto_familia_FK FOREIGN KEY (familia_cod_familia) REFERENCES familia (cod_familia);
ALTER TABLE producto ADD CONSTRAINT precio_base_CHK CHECK (precio_base > 0);
ALTER TABLE producto ADD CONSTRAINT porc_reposicion_CHK CHECK (porc_reposicion > 0);
ALTER TABLE producto ADD CONSTRAINT unidades_minimas_CHK CHECK (unidades_minimas > 0);

-- contendrá información básica sobre las tiendas que distribuyen los productos.
CREATE TABLE tienda (
    cod_tienda NUMBER(3) NOT NULL,
    deno_tienda VARCHAR(20) NOT NULL,
    telefono VARCHAR(11),
    codigo_postal VARCHAR(5) NOT NULL,
    provincia VARCHAR(5) NOT NULL
);

ALTER TABLE tienda ADD CONSTRAINT tienda_PK PRIMARY KEY (cod_tienda);

-- Contendrá para cada tienda el número de unidades disponibles de cada producto. 
-- La clave primaria está formada por la concatenación de los campos Codtienda y Codproducto.
CREATE TABLE stock (
    cod_tienda NUMBER(3) NOT NULL,
    cod_producto NUMBER(5) NOT NULL,
    unidades NUMBER(6) NOT NULL
);

ALTER TABLE stock ADD CONSTRAINT stock_PK PRIMARY KEY (cod_tienda, cod_producto);
ALTER TABLE stock ADD CONSTRAINT stock_tienda_FK FOREIGN KEY (cod_tienda) REFERENCES tienda (cod_tienda);
ALTER TABLE stock ADD CONSTRAINT stock_producto_FK FOREIGN KEY (cod_producto) REFERENCES producto (cod_producto);
ALTER TABLE stock ADD CONSTRAINT unidades_CHK CHECK (unidades >= 0);