-- MySQL Script generated by MySQL Workbench
-- 12/28/15 16:46:45
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema MeanNMS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MeanNMS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MeanNMS` DEFAULT CHARACTER SET utf8 ;
USE `MeanNMS` ;

-- -----------------------------------------------------
-- Table `MeanNMS`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`sections` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`sections` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `visible` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`kickers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`kickers` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`kickers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`media` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`media` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `filepath` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `filepath_UNIQUE` (`filepath` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`people` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`people` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `RIN` VARCHAR(9) NULL,
  `RCS_ID` VARCHAR(45) NULL,
  `fname` VARCHAR(45) NOT NULL,
  `mname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NOT NULL,
  `preferred_name` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  `phone` VARCHAR(25) NULL,
  `photo` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `RCS_ID_UNIQUE` (`RCS_ID` ASC),
  INDEX `photo_idx` (`photo` ASC),
  UNIQUE INDEX `RIN_UNIQUE` (`RIN` ASC),
  CONSTRAINT `photo`
    FOREIGN KEY (`photo`)
    REFERENCES `MeanNMS`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`organizations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`organizations` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`organizations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`positions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`positions` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`positions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `people_id` INT UNSIGNED NOT NULL,
  `org_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(45) NULL,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `staffbox` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `people_id_idx` (`people_id` ASC),
  INDEX `org_id_idx` (`org_id` ASC),
  CONSTRAINT `people_id`
    FOREIGN KEY (`people_id`)
    REFERENCES `MeanNMS`.`people` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `org_id`
    FOREIGN KEY (`org_id`)
    REFERENCES `MeanNMS`.`organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`bylines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`bylines` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`bylines` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `position_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `position_id_idx` (`position_id` ASC),
  CONSTRAINT `position_id`
    FOREIGN KEY (`position_id`)
    REFERENCES `MeanNMS`.`positions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`issues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`issues` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`issues` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`articles` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`articles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue` INT UNSIGNED NULL,
  `posted_date` DATETIME NOT NULL,
  `section` INT UNSIGNED NULL,
  `kicker` INT UNSIGNED NULL,
  `headline` NVARCHAR(255) NULL,
  `subdeck` TEXT NULL,
  `byline` INT UNSIGNED NULL,
  `body_text` MEDIUMTEXT NULL,
  `media` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `sections_idx` (`section` ASC),
  INDEX `kicker_idx` (`kicker` ASC),
  INDEX `byline_id_idx` (`byline` ASC),
  INDEX `issue_id_idx` (`issue` ASC),
  UNIQUE INDEX `posted_date_UNIQUE` (`posted_date` ASC),
  CONSTRAINT `sections`
    FOREIGN KEY (`section`)
    REFERENCES `MeanNMS`.`sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `kicker`
    FOREIGN KEY (`kicker`)
    REFERENCES `MeanNMS`.`kickers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `byline_id`
    FOREIGN KEY (`byline`)
    REFERENCES `MeanNMS`.`bylines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `issue_id`
    FOREIGN KEY (`issue`)
    REFERENCES `MeanNMS`.`issues` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`photos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`photos` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`photos` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_id` INT UNSIGNED NOT NULL,
  `caption` TEXT NULL,
  `byline` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `  media_id_idx` (`media_id` ASC),
  INDEX `byline_id_idx` (`byline` ASC),
  CONSTRAINT `  media_id`
    FOREIGN KEY (`media_id`)
    REFERENCES `MeanNMS`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `byline_id`
    FOREIGN KEY (`byline`)
    REFERENCES `MeanNMS`.`bylines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`articles_photos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`articles_photos` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`articles_photos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `article_id` INT UNSIGNED NOT NULL,
  `photo_id` INT UNSIGNED NOT NULL,
  `rank` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `article_id_idx` (`article_id` ASC),
  INDEX `photo_id_idx` (`photo_id` ASC),
  CONSTRAINT `article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `MeanNMS`.`articles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `photo_id`
    FOREIGN KEY (`photo_id`)
    REFERENCES `MeanNMS`.`photos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`users` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `people_id` INT UNSIGNED NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `people_id_UNIQUE` (`people_id` ASC),
  CONSTRAINT `people_id`
    FOREIGN KEY (`people_id`)
    REFERENCES `MeanNMS`.`people` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeanNMS`.`issue_personnel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeanNMS`.`issue_personnel` ;

CREATE TABLE IF NOT EXISTS `MeanNMS`.`issue_personnel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `issue_id` INT UNSIGNED NULL,
  `position_id` INT UNSIGNED NULL,
  `people_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `issue_id_idx` (`issue_id` ASC),
  INDEX `position_id_idx` (`position_id` ASC),
  INDEX `people_id_idx` (`people_id` ASC),
  CONSTRAINT `issue_id`
    FOREIGN KEY (`issue_id`)
    REFERENCES `MeanNMS`.`issues` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `position_id`
    FOREIGN KEY (`position_id`)
    REFERENCES `MeanNMS`.`positions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `people_id`
    FOREIGN KEY (`people_id`)
    REFERENCES `MeanNMS`.`people` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
