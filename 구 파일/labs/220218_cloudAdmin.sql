select * from tab;  -- �ش� ������ ���� �ִ� ���̺� ����Ʈ ����
-- ����� ���� ����
create user smile
  identified by xxxxxxAt22cc
  default tablespace data
  temporary tablespace temp
  quota 10G on data;
  
-- 12c ~ 19c �������� ����ó�� �Ǿ� ���� �����ؾ��ϴ� ��Ȳ ����.  c##������
create user c##������ identified by ��й�ȣ;

create user ������ identified by ��й�ȣ;
alter user ������ account unlock;
-- ==>
create user ������ identified by ��й�ȣ  account unlock;

-- ���� �ο�
grant connect, resource to kingsmile;
-- ����� ���� ����
drop user smile;

