-- MySQL Workbench Forward Engineering
-- Festival Zomerklanken - structuur van de databank
-- (zo ziet het script eruit dat Workbench genereert bij Forward Engineer)

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema festival
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `festival` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `festival` ;

-- -----------------------------------------------------
-- Table `festival`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`genre` (
  `genreID` INT NOT NULL AUTO_INCREMENT,
  `naam` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genreID`),
  UNIQUE INDEX `naam_UNIQUE` (`naam` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `festival`.`artiest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`artiest` (
  `artiestID` INT NOT NULL AUTO_INCREMENT,
  `naam` VARCHAR(60) NOT NULL,
  `land` VARCHAR(45) NOT NULL,
  `genreID` INT NOT NULL,
  PRIMARY KEY (`artiestID`),
  INDEX `fk_artiest_genre_idx` (`genreID` ASC) VISIBLE,
  CONSTRAINT `fk_artiest_genre`
    FOREIGN KEY (`genreID`)
    REFERENCES `festival`.`genre` (`genreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `festival`.`podium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`podium` (
  `podiumID` INT NOT NULL AUTO_INCREMENT,
  `naam` VARCHAR(45) NOT NULL,
  `capaciteit` INT NOT NULL,
  `overdekt` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`podiumID`),
  UNIQUE INDEX `naam_UNIQUE` (`naam` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `festival`.`optreden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`optreden` (
  `optredenID` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `beginuur` TIME NOT NULL,
  `einduur` TIME NOT NULL,
  `artiestID` INT NOT NULL,
  `podiumID` INT NOT NULL,
  PRIMARY KEY (`optredenID`),
  INDEX `fk_optreden_artiest_idx` (`artiestID` ASC) VISIBLE,
  INDEX `fk_optreden_podium_idx` (`podiumID` ASC) VISIBLE,
  CONSTRAINT `fk_optreden_artiest`
    FOREIGN KEY (`artiestID`)
    REFERENCES `festival`.`artiest` (`artiestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_optreden_podium`
    FOREIGN KEY (`podiumID`)
    REFERENCES `festival`.`podium` (`podiumID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `festival`.`campingzone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`campingzone` (
  `campingzoneID` INT NOT NULL AUTO_INCREMENT,
  `naam` VARCHAR(45) NOT NULL,
  `maxTenten` INT NOT NULL,
  PRIMARY KEY (`campingzoneID`),
  UNIQUE INDEX `naam_UNIQUE` (`naam` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `festival`.`bezoeker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`bezoeker` (
  `bezoekerID` INT NOT NULL AUTO_INCREMENT,
  `voornaam` VARCHAR(45) NOT NULL,
  `familienaam` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `geboortedatum` DATE NOT NULL,
  `campingzoneID` INT NULL,
  PRIMARY KEY (`bezoekerID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_bezoeker_campingzone_idx` (`campingzoneID` ASC) VISIBLE,
  CONSTRAINT `fk_bezoeker_campingzone`
    FOREIGN KEY (`campingzoneID`)
    REFERENCES `festival`.`campingzone` (`campingzoneID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `festival`.`favoriet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `festival`.`favoriet` (
  `bezoekerID` INT NOT NULL,
  `artiestID` INT NOT NULL,
  PRIMARY KEY (`bezoekerID`, `artiestID`),
  INDEX `fk_favoriet_artiest_idx` (`artiestID` ASC) VISIBLE,
  INDEX `fk_favoriet_bezoeker_idx` (`bezoekerID` ASC) VISIBLE,
  CONSTRAINT `fk_favoriet_bezoeker`
    FOREIGN KEY (`bezoekerID`)
    REFERENCES `festival`.`bezoeker` (`bezoekerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favoriet_artiest`
    FOREIGN KEY (`artiestID`)
    REFERENCES `festival`.`artiest` (`artiestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
