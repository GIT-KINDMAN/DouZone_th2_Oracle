--------------------------------------------------------
--  ������ ������ - ������-2��-15-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DEPARTMENT
--------------------------------------------------------

  CREATE TABLE "DEPARTMENT2" 
   (	"DEPTNO" NUMBER(3,0), 
	"DNAME" VARCHAR2(25 BYTE), 
	"PART" NUMBER(3,0), 
	"BUILD" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into DEPARTMENT
SET DEFINE OFF;
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (101,'��ǻ�Ͱ��а�',100,'������');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (102,'��Ƽ�̵����а�',100,'��Ƽ�̵���');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (103,'����Ʈ������а�',100,'����Ʈ�����');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (201,'���ڰ��а�',200,'���������');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (202,'�����а�',200,'�������');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (203,'ȭ�а��а�',200,'ȭ�нǽ���');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (301,'���������а�',300,'�ι���');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (100,'��ǻ�������к�',10,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (200,'��īƮ�δн��к�',10,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (300,'�ι���ȸ�к�',20,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (10,'��������',null,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (20,'�ι�����',null,null);
--------------------------------------------------------
--  DDL for Index SYS_C007769
--------------------------------------------------------

  CREATE UNIQUE INDEX "KINGSMILE"."SYS_C007769" ON "KINGSMILE"."DEPARTMENT" ("DEPTNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table DEPARTMENT
--------------------------------------------------------

  ALTER TABLE "KINGSMILE"."DEPARTMENT" ADD PRIMARY KEY ("DEPTNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "KINGSMILE"."DEPARTMENT" MODIFY ("DNAME" NOT NULL ENABLE);
