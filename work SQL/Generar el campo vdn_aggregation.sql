
SELECT 
    ivr_id AS calls_ivr_id,
    vdn_label,
    
    -- Lógica para generar vdn_aggregation
    CASE 
        WHEN vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation

FROM 
    keepcoding.ivr_calls;
