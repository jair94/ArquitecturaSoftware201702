-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: basedatosbiblioteca
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `idEstados` int(11) NOT NULL,
  `Tipo_Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idEstados`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'disponible'),(2,'Reserva');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etiquetas`
--

DROP TABLE IF EXISTS `etiquetas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etiquetas` (
  `idEtiquetas` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo_Etiqueta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEtiquetas`),
  UNIQUE KEY `idEtiquetas_UNIQUE` (`idEtiquetas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etiquetas`
--

LOCK TABLES `etiquetas` WRITE;
/*!40000 ALTER TABLE `etiquetas` DISABLE KEYS */;
INSERT INTO `etiquetas` VALUES (1,'Best Sellers'),(2,' libros de referencia'),(3,'Normal');
/*!40000 ALTER TABLE `etiquetas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id_Items` int(11) NOT NULL AUTO_INCREMENT,
  `id_Tipo_Item` int(11) NOT NULL,
  `Titulo_Item` varchar(45) NOT NULL,
  `Autor` varchar(45) NOT NULL,
  `Editorial` varchar(45) NOT NULL,
  `Cantidad_Recurso` varchar(45) NOT NULL,
  `Cantidad_Recurso_Disponible` varchar(45) NOT NULL,
  `Valor_Item` double NOT NULL,
  `Id_Etiqueta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Items`),
  UNIQUE KEY `id_Items_UNIQUE` (`id_Items`),
  KEY `FK_Item_TipoItem_FK_idx` (`id_Tipo_Item`),
  KEY `FK_Item_Etiqueta_FK_idx` (`Id_Etiqueta`),
  CONSTRAINT `FK_Item_Etiqueta` FOREIGN KEY (`Id_Etiqueta`) REFERENCES `etiquetas` (`idEtiquetas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Item_TipoItem` FOREIGN KEY (`id_Tipo_Item`) REFERENCES `tipo_items` (`id_Tipo_Items`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,3,'La torre Oscura','Stephen king','Norma','5','5',25000,1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multas`
--

DROP TABLE IF EXISTS `multas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multas` (
  `idMultas` int(11) NOT NULL AUTO_INCREMENT,
  `Tarjeta_Usuario` int(11) NOT NULL,
  `Fecha_Devolución` varchar(45) DEFAULT NULL,
  `Valor_Multa` double NOT NULL,
  `Estado_Multa` binary(1) NOT NULL,
  PRIMARY KEY (`idMultas`,`Tarjeta_Usuario`),
  UNIQUE KEY `idMultas_UNIQUE` (`idMultas`),
  KEY `FK_Usuario_Multa_idx` (`Tarjeta_Usuario`),
  CONSTRAINT `FK_Usuario_Multa` FOREIGN KEY (`Tarjeta_Usuario`) REFERENCES `usuariobiblioteca` (`Tarjeta_Biblioteca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multas`
--

LOCK TABLES `multas` WRITE;
/*!40000 ALTER TABLE `multas` DISABLE KEYS */;
/*!40000 ALTER TABLE `multas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prestamo` (
  `Idprestamo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Tarjeta_Usuario` int(11) NOT NULL,
  `Cod_Item` int(11) DEFAULT NULL,
  `Fecha_Prestamo` varchar(45) DEFAULT NULL,
  `Fecha_Prestamo_Fin` varchar(45) DEFAULT NULL,
  `Renovado` binary(1) DEFAULT NULL,
  PRIMARY KEY (`Idprestamo`),
  UNIQUE KEY `idprestamo_UNIQUE` (`Idprestamo`),
  KEY `FK_Usuario_Prestamo_idx` (`Tarjeta_Usuario`),
  KEY `FK_Item_Prestamo_idx` (`Cod_Item`),
  CONSTRAINT `FK_Item_Prestamo` FOREIGN KEY (`Cod_Item`) REFERENCES `items` (`id_Items`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Usuario_Prestamo` FOREIGN KEY (`Tarjeta_Usuario`) REFERENCES `usuariobiblioteca` (`Tarjeta_Biblioteca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservas` (
  `idReservas` int(11) NOT NULL AUTO_INCREMENT,
  `Tarjeta_Usuario` int(11) NOT NULL,
  `Id_Item_Reserva` int(11) NOT NULL,
  `Fecha_Reserva` varchar(45) NOT NULL,
  `Id_Estado_Reserva` int(11) NOT NULL,
  PRIMARY KEY (`idReservas`),
  UNIQUE KEY `idReservas_UNIQUE` (`idReservas`),
  KEY `FK_Reserva_usuario_idx` (`Tarjeta_Usuario`),
  KEY `FK_Estado_Reserva_idx` (`Id_Estado_Reserva`),
  KEY `FK_Item_Reserva_idx` (`Id_Item_Reserva`),
  CONSTRAINT `FK_Estado_Reserva` FOREIGN KEY (`Id_Estado_Reserva`) REFERENCES `estados` (`idEstados`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Item_Reserva` FOREIGN KEY (`Id_Item_Reserva`) REFERENCES `items` (`id_Items`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Reserva_usuario` FOREIGN KEY (`Tarjeta_Usuario`) REFERENCES `usuariobiblioteca` (`Tarjeta_Biblioteca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_items`
--

DROP TABLE IF EXISTS `tipo_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_items` (
  `id_Tipo_Items` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo_Item` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_Tipo_Items`),
  UNIQUE KEY `id_Tipo_Items_UNIQUE` (`id_Tipo_Items`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_items`
--

LOCK TABLES `tipo_items` WRITE;
/*!40000 ALTER TABLE `tipo_items` DISABLE KEYS */;
INSERT INTO `tipo_items` VALUES (1,'Libro'),(2,'Revista'),(3,'Archivo Multimedia ');
/*!40000 ALTER TABLE `tipo_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariobiblioteca`
--

DROP TABLE IF EXISTS `usuariobiblioteca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuariobiblioteca` (
  `Tarjeta_Biblioteca` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Usuario` varchar(45) DEFAULT NULL,
  `Apellido_Usuario` varchar(45) DEFAULT NULL,
  `Num_Telefono` varchar(45) DEFAULT NULL,
  `Fecha_Nacimiento` varchar(45) DEFAULT NULL,
  `Fecha_Registro` varchar(45) DEFAULT NULL,
  `Fecha_Retiro` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Tarjeta_Biblioteca`),
  UNIQUE KEY `id_Tarjeta_Biblioteca_UNIQUE` (`Tarjeta_Biblioteca`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariobiblioteca`
--

LOCK TABLES `usuariobiblioteca` WRITE;
/*!40000 ALTER TABLE `usuariobiblioteca` DISABLE KEYS */;
INSERT INTO `usuariobiblioteca` VALUES (2,'jair','Cabra','12345','20/05/1994','13/09/2017','');
/*!40000 ALTER TABLE `usuariobiblioteca` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-13 17:15:05
