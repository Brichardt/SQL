\c keepcoding;

CREATE TABLE ivr_detail (
    calls_ivr_id INTEGER,
    calls_phone_number VARCHAR(20),
    calls_ivr_result VARCHAR(50),
    calls_vdn_label VARCHAR(50),
    calls_start_date TIMESTAMP,
    calls_start_date_id INTEGER GENERATED ALWAYS AS (
        EXTRACT(YEAR FROM calls_start_date) * 10000 +
        EXTRACT(MONTH FROM calls_start_date) * 100 +
        EXTRACT(DAY FROM calls_start_date)
    ) STORED,
    calls_end_date TIMESTAMP,
    calls_end_date_id INTEGER GENERATED ALWAYS AS (
        EXTRACT(YEAR FROM calls_end_date) * 10000 +
        EXTRACT(MONTH FROM calls_end_date) * 100 +
        EXTRACT(DAY FROM calls_end_date)
    ) STORED,
    calls_total_duration INTEGER, -- Duración en segundos, en lugar de INTERVAL
    calls_customer_segment VARCHAR(50),
    calls_ivr_language VARCHAR(20),
    calls_steps_module INTEGER,
    calls_module_aggregation INTEGER, -- Asumo que es un número de agregación, no texto
    module_sequence INTEGER,
    module_name VARCHAR(50),
    module_duration INTEGER, -- Duración en segundos, en lugar de INTERVAL
    module_result VARCHAR(50),
    step_sequence INTEGER,
    step_name VARCHAR(50),
    step_result VARCHAR(50),
    step_description_error TEXT,
    document_type VARCHAR(50),
    document_identification VARCHAR(50),
    customer_phone VARCHAR(20),
    billing_account_id INTEGER,

    -- Llave foránea que relaciona con la tabla ivr_calls
    FOREIGN KEY (calls_ivr_id) REFERENCES ivr_calls(ivr_id),

    -- Llave foránea que relaciona con ivr_modules utilizando ivr_id y module_sequence
    FOREIGN KEY (calls_ivr_id, module_sequence) REFERENCES ivr_modules(ivr_id, module_sequence)
);
