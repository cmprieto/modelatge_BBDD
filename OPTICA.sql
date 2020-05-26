-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`proveedor` (
  `id_NIF` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Calle` VARCHAR(45) NULL,
  `Número` INT NULL,
  `Piso` VARCHAR(45) NULL,
  `Puerta` VARCHAR(45) NULL,
  `Ciudad` VARCHAR(45) NULL,
  `CP` INT NULL,
  `Pais` VARCHAR(45) NULL,
  `Telefono` INT NULL,
  `Fax` INT NULL,
  PRIMARY KEY (`id_NIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`montura` (
  `idMontura` INT NOT NULL,
  `Montura Pasta` TINYINT(1) NULL,
  `Montura Flotant` TINYINT(1) NULL,
  `Montura Metalica` TINYINT(1) NULL,
  PRIMARY KEY (`idMontura`),
  UNIQUE INDEX `Montura Pasta_UNIQUE` (`Montura Pasta` ASC) VISIBLE,
  UNIQUE INDEX `Montura Flotant_UNIQUE` (`Montura Flotant` ASC) VISIBLE,
  UNIQUE INDEX `Montura Metalica_UNIQUE` (`Montura Metalica` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`marca` (
  `idMarca` INT NOT NULL,
  `Marca` VARCHAR(45) NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  `Datos proveedor_id_NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMarca`),
  INDEX `fk_Marca_Datos proveedor1_idx` (`Datos proveedor_id_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Datos proveedor1`
    FOREIGN KEY (`Datos proveedor_id_NIF`)
    REFERENCES `Optica`.`proveedor` (`id_NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`recomendacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`recomendacion` (
  `idRecomendacion` INT NOT NULL,
  `cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idRecomendacion`),
  INDEX `fk_recomendacion_cliente1_idx` (`cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_recomendacion_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `Optica`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`cliente` (
  `idCliente` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `fecha registro` DATE NULL,
  `recomendacion_idRecomendacion` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_cliente_recomendacion1_idx` (`recomendacion_idRecomendacion` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_recomendacion1`
    FOREIGN KEY (`recomendacion_idRecomendacion`)
    REFERENCES `Optica`.`recomendacion` (`idRecomendacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`empleado` (
  `idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`transaccion` (
  `idTransaccion` INT NOT NULL,
  `fecha` DATE NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idTransaccion`),
  INDEX `fk_Transaccion_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Transaccion_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Transaccion_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Optica`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaccion_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Optica`.`empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`gafas` (
  `idGafas` INT NOT NULL,
  `Graduación_D` INT NULL,
  `Graduación_I` INT NULL,
  `Color Montura` VARCHAR(45) NULL,
  `Color Vidrio_D` VARCHAR(45) NULL,
  `Color Vidrio_I` VARCHAR(45) NULL,
  `Precio` INT NULL,
  `Montura_idMontura` INT NOT NULL,
  `Marca_idMarca` INT NOT NULL,
  `Transaccion_idTransaccion` INT NOT NULL,
  PRIMARY KEY (`idGafas`),
  INDEX `fk_Ulleres_Montura1_idx` (`Montura_idMontura` ASC) VISIBLE,
  INDEX `fk_Ulleres_Marca1_idx` (`Marca_idMarca` ASC) VISIBLE,
  INDEX `fk_Gafas_Transaccion1_idx` (`Transaccion_idTransaccion` ASC) VISIBLE,
  CONSTRAINT `fk_Ulleres_Montura1`
    FOREIGN KEY (`Montura_idMontura`)
    REFERENCES `Optica`.`montura` (`idMontura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ulleres_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `Optica`.`marca` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Transaccion1`
    FOREIGN KEY (`Transaccion_idTransaccion`)
    REFERENCES `Optica`.`transaccion` (`idTransaccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
