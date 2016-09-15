-- MySQL Script generated by MySQL Workbench
-- Mon Mar 16 15:52:01 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema foxha
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS `foxha` ;

-- -----------------------------------------------------
-- Schema foxha
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `foxha` DEFAULT CHARACTER SET latin1 ;

USE `foxha` ;

-- -----------------------------------------------------
-- Table `foxha`.`repl_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foxha`.`repl_groups` ;

CREATE TABLE IF NOT EXISTS `foxha`.`repl_groups` (
  `group_name` VARCHAR(64) NOT NULL COMMENT 'Identifica o grupo da replicação',
  `description` VARCHAR(256) NOT NULL COMMENT 'Descrição do grupo',
  `vip_address` VARCHAR(256) NOT NULL COMMENT 'FQDN do VIP',
  `mysql_adm_user` TEXT NOT NULL COMMENT 'mysql user for administration',
  `mysql_adm_pass` TEXT NOT NULL COMMENT 'mysql user for administration',
  `mysql_repl_user` TEXT NOT NULL COMMENT 'mysql user for replication',
  `mysql_repl_pass` TEXT NOT NULL COMMENT 'mysql user for replication',
  PRIMARY KEY (`group_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `foxha`.`repl_nodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foxha`.`repl_nodes` ;

CREATE TABLE IF NOT EXISTS `foxha`.`repl_nodes` (
  `group_name` VARCHAR(64) NOT NULL,
  `servername` VARCHAR(200) NOT NULL COMMENT 'Hostname do node',
  `node_ip` VARCHAR(200) NOT NULL COMMENT 'Ip da instância Mysql em execução no node',
  `node_port` INT(11) NOT NULL COMMENT 'Porta da instância Mysql do node em questão',
  `mode` VARCHAR(60) NOT NULL DEFAULT 'read_only' COMMENT 'read_only ou read_write',
  `status` VARCHAR(60) NOT NULL DEFAULT 'enabled' COMMENT 'enabled, disabled, failed',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`node_ip`, `node_port`),
  UNIQUE INDEX `unique_index` (`group_name` ASC, `servername` ASC),
  INDEX `fk_repl_nodes_repl_groups_idx` (`group_name` ASC),
  CONSTRAINT `fk_repl_nodes_repl_groups`
    FOREIGN KEY (`group_name`)
    REFERENCES `foxha`.`repl_groups` (`group_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
