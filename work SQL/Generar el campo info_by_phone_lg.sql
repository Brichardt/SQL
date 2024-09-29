ALTER TABLE ivr_detail
ADD COLUMN info_by_phone_lg TINYINT DEFAULT 0;  


UPDATE ivr_detail
SET info_by_phone_lg = 1
WHERE calls_ivr_id IN (
    SELECT ivr_steps.calls_ivr_id
    FROM ivr_steps
    WHERE ivr_steps.step_name = 'CUSTOMERINFOBYPHONE.TX'
    AND ivr_steps.step_result = 'OK'
);
