DROP DATABASE aplicar;
CREATE DATABASE aplicar;
USE aplicar;

SHOW TABLES;
DESC cities;

CREATE TABLE IF NOT EXISTS `aplicar`.`cities` (
  `idcities` INT NOT NULL,
  `cities` VARCHAR(45) NULL,
  PRIMARY KEY (`idcities`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`countries` (
  `idcountries` INT NOT NULL,
  `countries` VARCHAR(45) NULL,
  PRIMARY KEY (`idcountries`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`skills` (
  `idskills` INT NOT NULL,
  `skills` VARCHAR(45) NULL,
  PRIMARY KEY (`idskills`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`type` (
  `idtype` INT NOT NULL,
  `types` VARCHAR(45) NULL,
  PRIMARY KEY (`idtype`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`domains` (
  `iddomains` INT NOT NULL,
  `domains` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddomains`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`organization` (
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NULL,
  `contact` VARCHAR(15) NULL,
  `city` INT NULL,
  `country` INT NULL,
  `type` INT NULL,
  `mission` BLOB NULL,
  `profile` BLOB NULL,
  PRIMARY KEY (`email`),
  INDEX `city_idx` (`city` ASC) VISIBLE,
  INDEX `country_idx` (`country` ASC) VISIBLE,
  INDEX `types_idx` (`type` ASC) VISIBLE,
  CONSTRAINT `city`
    FOREIGN KEY (`city`)
    REFERENCES `aplicar`.`cities` (`idcities`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `country`
    FOREIGN KEY (`country`)
    REFERENCES `aplicar`.`countries` (`idcountries`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `types`
    FOREIGN KEY (`type`)
    REFERENCES `aplicar`.`type` (`idtype`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`organization_has_domains` (
  `organization_email` VARCHAR(45) NOT NULL,
  `domains_iddomains` INT NOT NULL,
  PRIMARY KEY (`organization_email`, `domains_iddomains`),
  INDEX `fk_organization_has_domains_domains1_idx` (`domains_iddomains` ASC) VISIBLE,
  INDEX `fk_organization_has_domains_organization1_idx` (`organization_email` ASC) VISIBLE,
  CONSTRAINT `fk_organization_has_domains_organization1`
    FOREIGN KEY (`organization_email`)
    REFERENCES `aplicar`.`organization` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_has_domains_domains1`
    FOREIGN KEY (`domains_iddomains`)
    REFERENCES `aplicar`.`domains` (`iddomains`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`volunteer` (
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `city` INT NULL,
  `country` INT NULL,
  `address` VARCHAR(255) NULL,
  `skills` INT NULL,
  `profile` BLOB NULL,
  PRIMARY KEY (`email`),
  INDEX `city_idx` (`city` ASC) VISIBLE,
  INDEX `country_idx` (`country` ASC) VISIBLE,
  CONSTRAINT `city`
    FOREIGN KEY (`city`)
    REFERENCES `aplicar`.`cities` (`idcities`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `country`
    FOREIGN KEY (`country`)
    REFERENCES `aplicar`.`countries` (`idcountries`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB



CREATE TABLE IF NOT EXISTS `aplicar`.`volunteer_has_skills` (
  `volunteer_email` VARCHAR(45) NOT NULL,
  `skills_idskills` INT NOT NULL,
  INDEX `fk_volunteer_has_skills_skills1_idx` (`skills_idskills` ASC) VISIBLE,
  INDEX `fk_volunteer_has_skills_volunteer1_idx` (`volunteer_email` ASC) VISIBLE,
  PRIMARY KEY (`volunteer_email`, `skills_idskills`),
  CONSTRAINT `fk_volunteer_has_skills_volunteer1`
    FOREIGN KEY (`volunteer_email`)
    REFERENCES `aplicar`.`volunteer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_volunteer_has_skills_skills1`
    FOREIGN KEY (`skills_idskills`)
    REFERENCES `aplicar`.`skills` (`idskills`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`projects` (
  `idProjects` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `sub_title` VARCHAR(60) NULL,
  `time_duration` VARCHAR(45) NULL,
  `domain` INT NULL,
  `description` BLOB NULL,
  `project_img` BLOB NULL,
  `applications` INT NULL,
  PRIMARY KEY (`idProjects`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`projects_has_skills` (
  `projects_idProjects` INT NOT NULL,
  `skills_idskills` INT NOT NULL,
  PRIMARY KEY (`projects_idProjects`, `skills_idskills`),
  INDEX `fk_projects_has_skills_skills1_idx` (`skills_idskills` ASC) VISIBLE,
  INDEX `fk_projects_has_skills_projects1_idx` (`projects_idProjects` ASC) VISIBLE,
  CONSTRAINT `fk_projects_has_skills_projects1`
    FOREIGN KEY (`projects_idProjects`)
    REFERENCES `aplicar`.`projects` (`idProjects`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_skills_skills1`
    FOREIGN KEY (`skills_idskills`)
    REFERENCES `aplicar`.`skills` (`idskills`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`project_tasks` (
  `projects_idProjects` INT NOT NULL AUTO_INCREMENT,
  `proect_tasks_title` VARCHAR(60) NOT NULL,
  `proect_tasks_desc` BLOB NOT NULL,
  INDEX `fk_proect_tasks_projects1_idx` (`projects_idProjects` ASC) VISIBLE,
  CONSTRAINT `fk_proect_tasks_projects1`
    FOREIGN KEY (`projects_idProjects`)
    REFERENCES `aplicar`.`projects` (`idProjects`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`project_requirements` (
  `projects_idProjects` INT NOT NULL AUTO_INCREMENT,
  `project_requirements_title` VARCHAR(45) NOT NULL,
  `project_requirements_desc` BLOB NOT NULL,
  INDEX `fk_project_requirements_projects1_idx` (`projects_idProjects` ASC) VISIBLE,
  CONSTRAINT `fk_project_requirements_projects1`
    FOREIGN KEY (`projects_idProjects`)
    REFERENCES `aplicar`.`projects` (`idProjects`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`organization_has_projects` (
  `organization_email` VARCHAR(45) NOT NULL,
  `projects_idProjects` INT NOT NULL,
  PRIMARY KEY (`organization_email`, `projects_idProjects`),
  INDEX `fk_organization_has_projects_projects1_idx` (`projects_idProjects` ASC) VISIBLE,
  INDEX `fk_organization_has_projects_organization1_idx` (`organization_email` ASC) VISIBLE,
  CONSTRAINT `fk_organization_has_projects_organization1`
    FOREIGN KEY (`organization_email`)
    REFERENCES `aplicar`.`organization` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_has_projects_projects1`
    FOREIGN KEY (`projects_idProjects`)
    REFERENCES `aplicar`.`projects` (`idProjects`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`volunteer_has_projects` (
  `volunteer_email` VARCHAR(45) NOT NULL,
  `projects_idProjects` INT NOT NULL,
  PRIMARY KEY (`volunteer_email`, `projects_idProjects`),
  INDEX `fk_volunteer_has_projects_projects1_idx` (`projects_idProjects` ASC) VISIBLE,
  INDEX `fk_volunteer_has_projects_volunteer1_idx` (`volunteer_email` ASC) VISIBLE,
  CONSTRAINT `fk_volunteer_has_projects_volunteer1`
    FOREIGN KEY (`volunteer_email`)
    REFERENCES `aplicar`.`volunteer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_volunteer_has_projects_projects1`
    FOREIGN KEY (`projects_idProjects`)
    REFERENCES `aplicar`.`projects` (`idProjects`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`volunteer_has_domains` (
  `volunteer_email` VARCHAR(45) NOT NULL,
  `domains_iddomains` INT NOT NULL,
  PRIMARY KEY (`volunteer_email`, `domains_iddomains`),
  INDEX `fk_volunteer_has_domains_domains1_idx` (`domains_iddomains` ASC) VISIBLE,
  INDEX `fk_volunteer_has_domains_volunteer1_idx` (`volunteer_email` ASC) VISIBLE,
  CONSTRAINT `fk_volunteer_has_domains_volunteer1`
    FOREIGN KEY (`volunteer_email`)
    REFERENCES `aplicar`.`volunteer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_volunteer_has_domains_domains1`
    FOREIGN KEY (`domains_iddomains`)
    REFERENCES `aplicar`.`domains` (`iddomains`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `aplicar`.`projects_has_skills` (
  `projects_idProjects` INT NOT NULL,
  `skills_idskills` INT NOT NULL,
  PRIMARY KEY (`projects_idProjects`, `skills_idskills`),
  INDEX `fk_projects_has_skills_skills1_idx` (`skills_idskills` ASC) VISIBLE,
  INDEX `fk_projects_has_skills_projects1_idx` (`projects_idProjects` ASC) VISIBLE,
  CONSTRAINT `fk_projects_has_skills_projects1`
    FOREIGN KEY (`projects_idProjects`)
    REFERENCES `aplicar`.`projects` (`idProjects`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_skills_skills1`
    FOREIGN KEY (`skills_idskills`)
    REFERENCES `aplicar`.`skills` (`idskills`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB