ALTER TABLE ivr_detail
ADD COLUMN masiva_lg TINYINT; 


UPDATE ivr_detail
SET masiva_lg = (
    SELECT 
        CASE 
            WHEN COUNT(*) > 0 THEN 1
            ELSE 0
        END
    FROM 
        ivr_modules
    WHERE 
        ivr_modules.ivr_id = ivr_detail.calls_ivr_id
    AND 
        ivr_modules.module_name = 'AVERIA_MASIVA'
);
