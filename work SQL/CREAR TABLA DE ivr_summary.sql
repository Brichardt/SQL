-- 1. Crear la tabla ivr_summary
CREATE TABLE ivr_summary (
    ivr_id INTEGER PRIMARY KEY,               -- Identificador de la llamada
    phone_number VARCHAR(20),                 -- Número de teléfono del cliente
    ivr_result VARCHAR(50),                   -- Resultado de la llamada
    vdn_aggregation VARCHAR(50),              -- Campo calculado de vdn_aggregation
    start_date TIMESTAMP,                     -- Fecha de inicio de la llamada
    end_date TIMESTAMP,                       -- Fecha de fin de la llamada
    total_duration INTERVAL,                  -- Duración total de la llamada
    customer_segment VARCHAR(50),             -- Segmento del cliente
    ivr_language VARCHAR(20),                 -- Idioma de la IVR
    steps_module INTEGER,                     -- Número de módulos por los que pasa la llamada
    module_aggregation TEXT,                  -- Lista de módulos por los que pasa la llamada
    document_type VARCHAR(50),                -- Tipo de documento
    document_identification VARCHAR(50),      -- Identificación del documento
    customer_phone VARCHAR(20),               -- Teléfono del cliente
    billing_account_id INTEGER,               -- ID de cuenta de facturación
    masiva_lg TINYINT,                        -- Flag si pasó por AVERIA_MASIVA
    info_by_phone_lg TINYINT,                 -- Flag si se identificó por teléfono
    info_by_dni_lg TINYINT,                   -- Flag si se identificó por DNI
    repeated_phone_24H TINYINT,               -- Flag si hubo llamadas en las últimas 24 horas
    cause_recall_phone_24H TINYINT            -- Flag si hay una llamada posterior en las 24 horas
);

-- 2. Insertar datos en ivr_summary desde ivr_detail
INSERT INTO ivr_summary (
    ivr_id, phone_number, ivr_result, vdn_aggregation, start_date, end_date, total_duration, 
    customer_segment, ivr_language, steps_module, module_aggregation, document_type, 
    document_identification, customer_phone, billing_account_id, masiva_lg, 
    info_by_phone_lg, info_by_dni_lg, repeated_phone_24H, cause_recall_phone_24H
)
SELECT
    calls_ivr_id AS ivr_id,                                   -- Identificador de la llamada
    calls_phone_number AS phone_number,                       -- Número llamante
    calls_ivr_result AS ivr_result,                           -- Resultado de la llamada
    vdn_aggregation,                                          -- Vdn_aggregation (calculado anteriormente)
    calls_start_date AS start_date,                           -- Fecha de inicio
    calls_end_date AS end_date,                               -- Fecha de fin
    calls_total_duration AS total_duration,                   -- Duración total
    calls_customer_segment AS customer_segment,               -- Segmento de cliente
    calls_ivr_language AS ivr_language,                       -- Idioma de la IVR
    calls_steps_module AS steps_module,                       -- Número de módulos por los que pasa la llamada
    calls_module_aggregation AS module_aggregation,           -- Lista de módulos
    document_type,                                            -- Tipo de documento (calculado)
    document_identification,                                  -- Identificación del documento (calculado)
    customer_phone,                                           -- Número de teléfono del cliente (calculado)
    billing_account_id,                                       -- ID de la cuenta de facturación
    masiva_lg,                                                -- Flag si pasó por el módulo AVERIA_MASIVA
    info_by_phone_lg,                                         -- Flag si se identificó por el número de teléfono
    info_by_dni_lg,                                           -- Flag si se identificó por el DNI
    repeated_phone_24H,                                       -- Flag si hubo una llamada en las últimas 24 horas
    cause_recall_phone_24H                                    -- Flag si hay una llamada posterior en 24 horas
FROM ivr_detail;
