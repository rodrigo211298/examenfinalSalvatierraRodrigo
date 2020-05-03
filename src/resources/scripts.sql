mysql -u root -p

mysql -u admin -h mysql-sise.cni3eljkljt0.us-east-1.rds.amazonaws.com -P 3306 -p

create database sat;

CREATE TABLE IF NOT EXISTS `multa` (
`id_multa` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `dni` varchar(8) DEFAULT NULL,
  `tipo_multa` varchar(30) DEFAULT NULL,
  `monto` decimal(6,2) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  `punto` int(11) DEFAULT NULL,
  `fec_regi` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;


1. Crear la columna punto entero.
2. Agregar la columna punto en el formulario (en el registro y la tabla)

create table tipo_multa(id_tipo int primary key auto_increment, desc_tipo_multa varchar(40));