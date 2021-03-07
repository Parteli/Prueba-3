/*Murilo*/

CREATE DATABASE prueba3;

USE prueba3;  

CREATE TABLE centros (
	numce INT(4) NOT NULL,
	nomce VARCHAR(25),
	dirce VARCHAR(25),
	CONSTRAINT PK_CENTROS PRIMARY KEY(numce)
);
INSERT INTO centros VALUES
	(10,'sede central', 'c/ atocha, 820, madrid'),
	(20,'relación con clientes', 'c/ atocha, 405, madrid');

CREATE TABLE departamentos(
	numde INT(3) NOT NULL,
	numce INT(4),
	direc INT(3),
	tidir CHAR(1),
	presu FLOAT(3,1),
	depde INT(3),
	nomde VARCHAR(20),
	CONSTRAINT PK_DEP PRIMARY KEY(numde),
	CONSTRAINT FK_DEP_CENTRO FOREIGN KEY(numce) REFERENCES centros(numce),
	CONSTRAINT FK_DEP_DEP FOREIGN KEY(depde) REFERENCES departamentos(numde)
);
INSERT INTO departamentos VALUES
	(100,10,260,'P',72,NULL,'dirección general'),
	(110,20,180,'P',90,100,'direcc.comercial'),
	(111,20,180,'F',66,110,'sector industrial'),
	(112,20,270,'P',54,110,'sector servicios'),
	(120,10,150,'F',18,100,'organización'),
	(121,10,150,'P',12,120,'personal'),
	(122,10,350,'P',36,120,'proceso de datos'),
	(130,10,310,'P',12,100,'finanzas');

CREATE TABLE empleados(
	numem INT(3) NOT NULL,
	extel INT(3),
	fecna DATE,
	fecin DATE,
	salar INT(5),
	comis INT(3),
	numhi INT(1),
	nomem VARCHAR(10),
	numde INT(3),
	CONSTRAINT PK_EMP PRIMARY KEY(numem),
	CONSTRAINT FK_EMP_DEP FOREIGN KEY(numde) REFERENCES departamentos(numde)
);

INSERT INTO empleados VALUES
	(110,350,'1970-11-10','1985-02-15',1800,NULL,3,'cesar',121),
	(120,840,'1968-06-09','1988-10-01',1900, 110,1,'mario',112),
	(130,810,'1965-09-09','1981-02-01',1500, 110,2,'luciano',112),
	(150,340,'1972-08-10','1997-01-15',2600,NULL,0,'julio',121),
	(160,740,'1980-07-09','2005-11-11',1800, 110,2,'aureo',111),
	(180,508,'1974-10-18','1996-03-18',2800,  50,2,'marcos',110),
	(190,350,'1972-05-12','1992-02-11',1750,NULL,4,'juliana',121),
	(210,200,'1970-09-28','1999-01-22',1910,NULL,2,'pilar',100),
	(240,760,'1967-02-26','1989-02-24',1700, 100,3,'lavinha',111),
	(250,250,'1976-10-27','1997-03-01',2700,NULL,0,'adriana',100),
	(260,220,'1973-12-03','2001-07-12', 720,NULL,6,'antonio',100),
	(270,800,'1975-05-21','2003-09-10',1910,  80,3,'octavio',112),
	(280,410,'1978-01-10','2010-10-08',1500,NULL,5,'dorotea',130);

/*1-*/
SELECT nomde FROM departamentos WHERE tidir LIKE('F') ORDER BY nomde;

/*2- Quieres saber de 1 departamento específico o una ordenacion general?*/
SELECT extel, nomem FROM empleados WHERE numde = 110 ORDER BY extel; 
SELECT numde, extel, nomem FROM empleados ORDER BY numde, extel;

/*3-*/
SELECT comis, nomem, salar FROM empleados WHERE numhi = 3 ORDER BY comis, nomem;

/*4-*/
SELECT numde FROM empleados WHERE salar < 1500;

/*5-*/
SELECT nomem 'Nombre', salar*12 'Salario 2014', (salar*12*1.02) 'Salario 2015', (salar*12*1.02*1.02) 'Salario 2016'
	FROM empleados WHERE numhi > 4 ORDER BY nomem;

/*6-*/
SELECT nomem 'Nombre', (salar+comis) 'Salario Total' FROM empleados
	WHERE numde = 112 ORDER BY (salar+comis) DESC, nomem ASC;

/*7-*/
SELECT numde 'Departamento', COUNT(numde) 'Nº empleados' FROM empleados GROUP BY numde;

/*8-*/
SELECT d.numde 'Departamento', COUNT(e.numde) 'Nº empleados', SUM(e.salar) 'Suma Salario'
	FROM departamentos d, empleados e WHERE d.numde = e.numde AND e.salar > 1500
    GROUP BY d.numde;

/*9-*/
SELECT d.numde 'Departamento', COUNT(e1.extel) 'Nº extensiones', AVG(e1.salar) 'Medio Dep'
	FROM departamentos d, empleados e1 WHERE d.numde = e1.numde GROUP BY e1.numde
    HAVING AVG(e1.salar) > (SELECT AVG(e2.salar) FROM empleados e2);

/*10-*/ 
SELECT e.nomem 'Apellido', d.nomde 'Departamento' FROM empleados e
 	INNER JOIN departamentos d ON e.numde = d.numde;