
  CREATE TABLESPACE "USERS2" DATAFILE 
  'D:\APP\USER\ORADATA\FOREX2\USERS02.DBF' SIZE 5242880
  AUTOEXTEND ON NEXT 1310720 MAXSIZE 32767M
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT 
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;
   ALTER DATABASE DATAFILE 
  'D:\APP\USER\ORADATA\FOREX2\USERS02.DBF' RESIZE 30948720640;
