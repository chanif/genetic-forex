DELETE FROM PROCESO WHERE ID_INDIVIDUO IN
(
SELECT DISTINCT ID_INDIVIDUO FROM OPERACION WHERE ((FECHA_CIERRE-FECHA_APERTURA)/30 > 1) OR (FECHA_CIERRE IS NULL)
);


DELETE FROM OPERACION WHERE ID_INDIVIDUO IN
(
SELECT DISTINCT ID_INDIVIDUO FROM OPERACION WHERE ((FECHA_CIERRE-FECHA_APERTURA)/30 > 1) OR (FECHA_CIERRE IS NULL)
);

COMMIT;
