-- 1. Añadir las columnas repeated_phone_24H y cause_recall_phone_24H a la tabla ivr_detail
ALTER TABLE ivr_detail
ADD COLUMN repeated_phone_24H TINYINT DEFAULT 0,
ADD COLUMN cause_recall_phone_24H TINYINT DEFAULT 0;

-- 2. Actualizar repeated_phone_24H (llamadas anteriores en las últimas 24 horas)
UPDATE ivr_detail d1
SET repeated_phone_24H = 1
WHERE EXISTS (
    SELECT 1
    FROM ivr_detail d2
    WHERE d1.calls_phone_number = d2.calls_phone_number
    AND d2.calls_start_date BETWEEN d1.calls_start_date - INTERVAL '24 HOUR' AND d1.calls_start_date
    AND d1.calls_ivr_id <> d2.calls_ivr_id  
);

-- 3. Actualizar cause_recall_phone_24H (llamadas posteriores en las próximas 24 horas)
UPDATE ivr_detail d1
SET cause_recall_phone_24H = 1
WHERE EXISTS (
    SELECT 1
    FROM ivr_detail d2
    WHERE d1.calls_phone_number = d2.calls_phone_number
    AND d2.calls_start_date BETWEEN d1.calls_start_date AND d1.calls_start_date + INTERVAL '24 HOUR'
    AND d1.calls_ivr_id <> d2.calls_ivr_id  
);
