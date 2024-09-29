-- 1. Añadir la columna info_by_dni_lg a la tabla ivr_detail
ALTER TABLE ivr_detail
ADD COLUMN info_by_dni_lg TINYINT DEFAULT 0;  -- Utilización de TINYINT para almacenar 0 o 1

-- 2. Actualizar el valor de info_by_dni_lg si el cliente ha sido identificado por DNI
UPDATE ivr_detail
SET info_by_dni_lg = 1
WHERE calls_ivr_id IN (
    SELECT ivr_steps.calls_ivr_id
    FROM ivr_steps
    WHERE ivr_steps.step_name = 'CUSTOMERINFOBYDNI.TX'
    AND ivr_steps.step_result = 'OK'
);
