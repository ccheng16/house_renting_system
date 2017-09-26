SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb_rent` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb_rent` ;

-- -----------------------------------------------------
-- Table `mydb_rent`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_rent`.`Client` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `credit_no` BIGINT NULL,
  `idClient` VARCHAR(18) NULL,
  `gender` TINYINT(1) NULL,
  PRIMARY KEY (`username`));


-- -----------------------------------------------------
-- Table `mydb_rent`.`House`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_rent`.`House` (
  `idHouse` INT NOT NULL,
  `ordered_status` TINYINT(1) NOT NULL,
  `price` FLOAT NOT NULL,
  `type` VARCHAR(45) NULL,
  `year` SMALLINT NULL,
  `locationHouse` VARCHAR(45) NOT NULL,
  `cap` VARCHAR(45) NULL,
  PRIMARY KEY (`idHouse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_rent`.`Agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_rent`.`Agency` (
  `idAgency` INT NOT NULL,
  `telephone` INT(11) NOT NULL,
  `locationAgency` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAgency`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_rent`.`Agency_has_House`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_rent`.`Agency_has_House` (
  `Agency_idAgency` INT NOT NULL,
  `idHouse` TINYINT(1) NOT NULL,
  PRIMARY KEY (`Agency_idAgency`, `idHouse`),
  INDEX `fk_Agency_has_House_House1_idx` (`idHouse` ASC),
  INDEX `fk_Agency_has_House_Agency1_idx` (`Agency_idAgency` ASC),
  CONSTRAINT `fk_Agency_has_House_Agency1`
    FOREIGN KEY (`Agency_idAgency`)
    REFERENCES `mydb_rent`.`Agency` (`idAgency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agency_has_House_House1`
    FOREIGN KEY (`idHouse`)
    REFERENCES `mydb_rent`.`House` (`ordered_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_rent`.`Client_rents_House`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_rent`.`Client_rents_House` (
  `Client_username` VARCHAR(16) NOT NULL,
  `idHouse` TINYINT(1) NOT NULL,
  `idTransaction` BIGINT NOT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `startDate` TIMESTAMP NOT NULL,
  `cost` FLOAT NOT NULL,
  PRIMARY KEY (`Client_username`, `idHouse`),
  INDEX `fk_Client_has_House_House1_idx` (`idHouse` ASC),
  INDEX `fk_Client_has_House_Client1_idx` (`Client_username` ASC),
  CONSTRAINT `fk_Client_has_House_Client1`
    FOREIGN KEY (`Client_username`)
    REFERENCES `mydb_rent`.`Client` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_House_House1`
    FOREIGN KEY (`idHouse`)
    REFERENCES `mydb_rent`.`House` (`ordered_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb_rent`.`Visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_rent`.`Visit` (
  `Client_username` VARCHAR(16) NOT NULL,
  `Agency_idAgency` INT NOT NULL,
  `House_idHouse` INT NOT NULL,
  `dateVisit` TIMESTAMP NOT NULL,
  `locationHouse` VARCHAR(45) NULL,
  PRIMARY KEY (`Client_username`, `Agency_idAgency`, `House_idHouse`),
  INDEX `fk_Client_has_Agency_Agency1_idx` (`Agency_idAgency` ASC),
  INDEX `fk_Client_has_Agency_Client1_idx` (`Client_username` ASC),
  INDEX `fk_Client_has_Agency_House1_idx` (`House_idHouse` ASC),
  CONSTRAINT `fk_Client_has_Agency_Client1`
    FOREIGN KEY (`Client_username`)
    REFERENCES `mydb_rent`.`Client` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Agency_Agency1`
    FOREIGN KEY (`Agency_idAgency`)
    REFERENCES `mydb_rent`.`Agency` (`idAgency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Agency_House1`
    FOREIGN KEY (`House_idHouse`)
    REFERENCES `mydb_rent`.`House` (`idHouse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
