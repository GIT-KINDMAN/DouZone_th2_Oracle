/* Droping existing tables (if they exist)*/
-- pause on

DROP TABLE works_on;
DROP TABLE dependent;
DROP TABLE project;
DROP TABLE dept_location;
ALTER TABLE department DROP CONSTRAINT fk_mgrssn CASCADE;
ALTER TABLE employee DROP CONSTRAINT fk_dno CASCADE;
DROP TABLE department;
DROP TABLE employee;


/* Creating tables */
/* Employee Table */
CREATE TABLE employee 
 (fname		VARCHAR2(12),
  minit		CHAR(1),
  lname		VARCHAR2(12),
  ssn		CHAR(9) NOT NULL,
  bdate		DATE,
  address	VARCHAR2(27),
  sex		CHAR(1),
  salary	NUMBER(7) NOT NULL,
  superssn	CHAR(9),
  CONSTRAINT pk_ssn PRIMARY KEY (SSN));

ALTER TABLE employee ADD (dno NUMBER(2) NOT NULL);
alter session set nls_date_format='dd-Mm-yyyy';

INSERT INTO employee VALUES ('John', 'B', 'Smith', '123456789', '05-05-1955', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
INSERT INTO employee VALUES ('Franklin', 'T', 'Wong', '333445555', '09-04-1945', '638 Voss, Houston, TX', 'M', 40000, '888665555',5);
INSERT INTO employee VALUES ('Alicia', 'J', 'Zelaya', '999778888', '06-09-1958', '3321 Castle, Spring, TX', 'F', 25000, '987654321',4);
INSERT INTO employee VALUES ('Jennifer', 'S', 'Wallace', '987654321', '20-06-1931', '291 Berry, Bellaire, TX', 'F', 43000, '888665555',4);
INSERT INTO employee VALUES ('Ramesh', 'K', 'Narayan', '666884444', '15-11-1952', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555',5);
INSERT INTO employee VALUES ('Joyce', 'A', 'English', '453453453', '31-07-1962', '5631 Rice, Houston, TX', 'F', 25000, '333445555',5);
INSERT INTO employee VALUES ('Ahmad', 'V', 'Jabbar', '987987987', '29-03-1959', '908 Dallas, Houston, TX', 'M', 25000, '987654321',4);
INSERT INTO employee VALUES ('James', 'E', 'Borg', '888665555', '10-10-1927', '450 Stone, Houston, TX', 'M', 55000, null,1);

select * from employee;
select * from department;
/* Department Table */
CREATE TABLE department 
 (dname		VARCHAR2(15) NOT NULL,
  dnumber	NUMBER(2) NOT NULL,
  mgrssn	CHAR(9) NOT NULL,
  mgrstartdate	DATE,
  CONSTRAINT pk_dnumber PRIMARY KEY (DNUMBER),
  CONSTRAINT fk_mgrssn FOREIGN KEY (mgrssn) REFERENCES employee (ssn));


INSERT INTO department VALUES ('Research',5 , '333445555', '22-10-1978');
INSERT INTO department VALUES ('Administration',4 , '987654321', '01-06-1985');
INSERT INTO department VALUES ('Headquarters', 1, '888665555', '19-06-1971');

ALTER TABLE employee ADD (CONSTRAINT fk_dno FOREIGN KEY (dno) REFERENCES department(dnumber));

select * from dept_location;
/* Department Location Table */

CREATE TABLE dept_location 
 (dnumber	NUMBER(2),
  dlocation	VARCHAR2(9),
  CONSTRAINT pk_num_loc PRIMARY KEY (dnumber, dlocation),
  CONSTRAINT fk_dnumber FOREIGN KEY (dnumber) REFERENCES department(dnumber));


INSERT INTO dept_location VALUES (1,'Houston');
INSERT INTO dept_location VALUES (4,'Stafford');
INSERT INTO dept_location VALUES (5,'Bellaire');
INSERT INTO dept_location VALUES (5,'Sugarland');
INSERT INTO dept_location VALUES (5,'Houston');

/* Project Table */
CREATE TABLE project
 (pname		VARCHAR2(15),
  pnumber	NUMBER(2) NOT NULL,
  plocation	VARCHAR2(15) ,
  dnum		NUMBER(2),
  CONSTRAINT pk_pnumber PRIMARY KEY (PNUMBER),
  CONSTRAINT fk_dnum FOREIGN KEY (dnum) REFERENCES department(dnumber));


INSERT INTO project VALUES ('ProductX', 1,'Bellaire',5);
INSERT INTO project VALUES ('ProductY', 2,'Sugarland',5);
INSERT INTO project VALUES ('ProductZ', 3,'Houston',5);
INSERT INTO project VALUES ('Computerization', 10,'Stafford',4);
INSERT INTO project VALUES ('Reorganization', 20,'Houston',1);
INSERT INTO project VALUES ('Newbenefits', 30,'Stafford',4);

/* Dependent Table */
CREATE TABLE dependent
 (essn	CHAR(9) NOT NULL,
  dependent_name VARCHAR(9) NOT NULL,
  sex		VARCHAR2(1),
  bdate		DATE,
  relationship	VARCHAR(8),
  CONSTRAINT pk_essn PRIMARY KEY (essn, dependent_name),
  CONSTRAINT fk_essn FOREIGN KEY (essn) REFERENCES employee(ssn) ON DELETE CASCADE);


INSERT INTO dependent VALUES ('333445555','Alice', 'F','05-04-1976','Daughter');
INSERT INTO dependent VALUES ('333445555','Theodore', 'M','10-10-1973','Son');
INSERT INTO dependent VALUES ('333445555','Joy', 'F','03-09-1948','Spouse');
INSERT INTO dependent VALUES ('987654321','Abner', 'M','29-11-1932','Spouse');
INSERT INTO dependent VALUES ('123456789','Michael', 'M','01-12-1978','Son');
INSERT INTO dependent VALUES ('123456789','Alice', 'M','31-12-1978','Daughter');
INSERT INTO dependent VALUES ('123456789','Elizabeth', 'F','05-05-1957','Spouse');

/* Works on Table */
CREATE TABLE works_on
 (essn	CHAR(9) NOT NULL,
  pno	NUMBER(2) NOT NULL,
  hours	NUMBER(3,1),
  CONSTRAINT pk_essn_pno PRIMARY KEY (essn, pno),
  CONSTRAINT fk_pno FOREIGN KEY (pno) REFERENCES project(pnumber));


INSERT INTO works_on VALUES ('123456789',1,32.5);
INSERT INTO works_on VALUES ('123456789',2,7.5);
INSERT INTO works_on VALUES ('666884444',3,40.0);
INSERT INTO works_on VALUES ('453453453',1,20.0);
INSERT INTO works_on VALUES ('453453453',2,20.0);
INSERT INTO works_on VALUES ('333445555',2,10.0);
INSERT INTO works_on VALUES ('333445555',3,10.0);
INSERT INTO works_on VALUES ('333445555',10,10.0);
INSERT INTO works_on VALUES ('333445555',20,10.0);
INSERT INTO works_on VALUES ('999887777',30,30.0);
INSERT INTO works_on VALUES ('999887777',10,10.0);
INSERT INTO works_on VALUES ('987987987',10,35.0);
INSERT INTO works_on VALUES ('987987987',30,5.0);
INSERT INTO works_on VALUES ('987654321',30,20.0);
INSERT INTO works_on VALUES ('987654321',20,15.0);
INSERT INTO works_on VALUES ('888665555',20,null);



