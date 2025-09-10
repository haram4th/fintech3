CREATE SCHEMA IF NOT EXISTS `univ_lms` DEFAULT CHARACTER SET utf8;
USE `univ_lms`;

-- -----------------------------------------------------
-- Table `univ_lms`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `univ_lms`.`department` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`)
);

-- -----------------------------------------------------
-- Table `univ_lms`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `univ_lms`.`student` (
  `student_id` INT NOT NULL,
  `student_name` VARCHAR(45) NOT NULL,
  `height` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_student_department_idx` (`department_id` ASC),
  CONSTRAINT `fk_student_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `univ_lms`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `univ_lms`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `univ_lms`.`professor` (
  `professor_id` INT NOT NULL,
  `professor_name` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`professor_id`),
  INDEX `fk_professor_department1_idx` (`department_id` ASC),
  CONSTRAINT `fk_professor_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `univ_lms`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `univ_lms`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `univ_lms`.`course` (
  `course_id` INT NOT NULL,
  `course_name` VARCHAR(45) NOT NULL,
  `professor_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_professor1_idx` (`professor_id` ASC),
  CONSTRAINT `fk_course_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `univ_lms`.`professor` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `univ_lms`.`student_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `univ_lms`.`student_course` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  INDEX `fk_student_course_course1_idx` (`course_id` ASC),
  INDEX `fk_student_course_student1_idx` (`student_id` ASC),
  CONSTRAINT `fk_student_course_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `univ_lms`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_course_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `univ_lms`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

use univ_lms;
insert into department values(1, '수학');
insert into department values(2, '국문학');
insert into department values(3, '정보통신학');
insert into department values(4, '모바일공학');

insert into student values(1, '가길동', 177, 1);
insert into student values(2, '나길동', 178, 1);
insert into student values(3, '다길동', 179, 1);
insert into student values(4, '라길동', 180, 2);
insert into student values(5, '마길동', 170, 2);
insert into student values(6, '바길동', 172, 3);
insert into student values(7, '사길동', 166, 4);
insert into student values(8, '아길동', 192, 4);

insert into professor values(1, '가교수', 1);
insert into professor values(2, '나교수', 2);
insert into professor values(3, '다교수', 3);
insert into professor values(4, '빌게이츠', 4);
insert into professor values(5, '스티브잡스', 3);

insert into course values(1, '교양영어', 1, '2016/9/2', '2016/11/30');
insert into course values(2, '데이터베이스 입문', 3, '2016/8/20', '2016/10/30');
insert into course values(3, '회로이론', 2, '2016/10/20', '2016/12/30');
insert into course values(4, '공업수학', 4, '2016/11/2', '2017/1/28');
insert into course values(5, '객체지향프로그래밍', 3, '2016/11/1', '2017/1/30');

insert into student_course values(1,1);
insert into student_course values(2,1);
insert into student_course values(3,2);
insert into student_course values(4,3);
insert into student_course values(5,4);
insert into student_course values(6,5);
insert into student_course values(7,5);

