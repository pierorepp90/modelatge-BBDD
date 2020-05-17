-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`suppliers` (
  `NIF` VARCHAR(45) NOT NULL,
  `name_supplier` VARCHAR(50) NOT NULL,
  `phone_supplier` INT NULL,
  `fax_supplier` INT NULL,
  PRIMARY KEY (`NIF`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`adresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`adresses` (
  `id_adress` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NOT NULL,
  `postal_code` INT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_adress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`glasses` (
  `id_glasses` VARCHAR(99) NOT NULL,
  `graduation_left_glasses` DECIMAL(4) NULL,
  `graduation_right_glasses` DECIMAL(4) NULL,
  `frame_glasses` VARCHAR(1) NULL COMMENT 'Floating=F\nPaste=P\nMetallic=M',
  PRIMARY KEY (`id_glasses`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`brands` (
  `name_brand` VARCHAR(50) NOT NULL,
  `glasses_id_glasses` VARCHAR(99) NOT NULL,
  `suppliers_NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name_brand`),
  INDEX `fk_brands_glasses1_idx` (`glasses_id_glasses` ASC),
  INDEX `fk_brands_suppliers1_idx` (`suppliers_NIF` ASC),
  CONSTRAINT `fk_brands_glasses1`
    FOREIGN KEY (`glasses_id_glasses`)
    REFERENCES `mydb`.`glasses` (`id_glasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_brands_suppliers1`
    FOREIGN KEY (`suppliers_NIF`)
    REFERENCES `mydb`.`suppliers` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `email_customer` VARCHAR(255) NOT NULL,
  `name_customer` VARCHAR(99) NOT NULL,
  `phone_customer` INT NOT NULL,
  `registration_date` DATE NOT NULL,
  `email_customer_rec` VARCHAR(45) NULL,
  PRIMARY KEY (`email_customer`, `email_customer_rec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`suppliers_adresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`suppliers_adresses` (
  `suppliers_NIF` VARCHAR(45) NOT NULL,
  `adresses_id_adress` INT NOT NULL,
  INDEX `fk_suppliers_adresses_suppliers1_idx` (`suppliers_NIF` ASC),
  INDEX `fk_suppliers_adresses_adresses1_idx` (`adresses_id_adress` ASC),
  CONSTRAINT `fk_suppliers_adresses_suppliers1`
    FOREIGN KEY (`suppliers_NIF`)
    REFERENCES `mydb`.`suppliers` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suppliers_adresses_adresses1`
    FOREIGN KEY (`adresses_id_adress`)
    REFERENCES `mydb`.`adresses` (`id_adress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers_adresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers_adresses` (
  `customers_email_customer` VARCHAR(255) NOT NULL,
  `adresses_id_adress` INT NOT NULL,
  INDEX `fk_customers_adresses_customers1_idx` (`customers_email_customer` ASC),
  INDEX `fk_customers_adresses_adresses1_idx` (`adresses_id_adress` ASC),
  CONSTRAINT `fk_customers_adresses_customers1`
    FOREIGN KEY (`customers_email_customer`)
    REFERENCES `mydb`.`customers` (`email_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_adresses_adresses1`
    FOREIGN KEY (`adresses_id_adress`)
    REFERENCES `mydb`.`adresses` (`id_adress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`recomendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recomendation` (
  `customers_email_customer` VARCHAR(255) NOT NULL,
  `customers_email_customer_rec` VARCHAR(45) NOT NULL,
  INDEX `fk_recomendation_customers1_idx` (`customers_email_customer` ASC, `customers_email_customer_rec` ASC),
  CONSTRAINT `fk_recomendation_customers1`
    FOREIGN KEY (`customers_email_customer` , `customers_email_customer_rec`)
    REFERENCES `mydb`.`customers` (`email_customer` , `email_customer_rec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employees` (
  `id_employee` INT NOT NULL AUTO_INCREMENT,
  `name_employee` VARCHAR(99) NULL,
  PRIMARY KEY (`id_employee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sales` (
  `glasses_id_glasses` VARCHAR(99) NOT NULL,
  `employees_id_employee` INT NOT NULL,
  INDEX `fk_sales_glasses1_idx` (`glasses_id_glasses` ASC),
  INDEX `fk_sales_employees1_idx` (`employees_id_employee` ASC),
  CONSTRAINT `fk_sales_glasses1`
    FOREIGN KEY (`glasses_id_glasses`)
    REFERENCES `mydb`.`glasses` (`id_glasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_employees1`
    FOREIGN KEY (`employees_id_employee`)
    REFERENCES `mydb`.`employees` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
