﻿SET DEFINE OFF;
--SQL Statement which produced this data:
--
--  SELECT * FROM FIRE_ADM.KOORDINAT;
--
Insert into KOORDINAT
   (OBJECTID, REGISTRERINGFRA, REGISTRERINGTIL, SAGSEVENTID, SRID, 
    SZ, T, TRANSFORMERET, Z, PUNKTID)
 Values
   (1, TO_TIMESTAMP_TZ('19/09/2017 20:59:45.000000 +01:00','DD/MM/YYYY HH24:MI:SS.FF TZH:TZM'), TO_TIMESTAMP_TZ('30/10/2017 16:18:35.000000 +01:00','DD/MM/YYYY HH24:MI:SS.FF TZH:TZM'), 'dummy', 'EPSG:5799', 
    2, TO_TIMESTAMP_TZ('19/09/2017 18:55:00.000000 +01:00','DD/MM/YYYY HH24:MI:SS.FF TZH:TZM'), 'false', 20.93845, '7C1AA93A-C78C-4643-E053-1A041EAC5880');
Insert into KOORDINAT
   (OBJECTID, REGISTRERINGFRA, REGISTRERINGTIL, SAGSEVENTID, SRID, 
    SZ, T, TRANSFORMERET, Z, PUNKTID)
 Values
   (2, TO_TIMESTAMP_TZ('19/09/2017 20:59:37.000000 +01:00','DD/MM/YYYY HH24:MI:SS.FF TZH:TZM'), TO_TIMESTAMP_TZ('30/10/2017 16:18:31.000000 +01:00','DD/MM/YYYY HH24:MI:SS.FF TZH:TZM'), 'dummy', 'EPSG:5799', 
    1, TO_TIMESTAMP_TZ('19/09/2017 18:55:00.000000 +01:00','DD/MM/YYYY HH24:MI:SS.FF TZH:TZM'), 'false', 3.34499, '7C1AA93A-C7A4-4643-E053-1A041EAC5880');
COMMIT;
