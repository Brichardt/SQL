ALTER TABLE ivr_detail
ADD COLUMN customer_phone VARCHAR(20);

UPDATE ivr_detail
SET customer_phone = (
    SELECT 
        MAX(SUBSTRING(step_description_error, POSITION('TEL=' IN step_description_error) + 4, 20)) 
    FROM 
        ivr_steps
    WHERE 
        ivr_steps.calls_ivr_id = ivr_detail.calls_ivr_id
    AND 
        step_description_error LIKE '%TEL=%'
    GROUP BY ivr_steps.calls_ivr_id
);
