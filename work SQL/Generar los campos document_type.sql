SELECT 
    ivr_detail.calls_ivr_id,
    ivr_detail.vdn_label,
    MAX(steps.document_type) AS document_type,
    MAX(steps.document_identification) AS document_identification
FROM 
    keepcoding.ivr_detail AS ivr_detail
LEFT JOIN 
    keepcoding.ivr_steps AS steps
ON 
    ivr_detail.calls_ivr_id = steps.calls_ivr_id
GROUP BY 
    ivr_detail.calls_ivr_id, ivr_detail.vdn_label;
