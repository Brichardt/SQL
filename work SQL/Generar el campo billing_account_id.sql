ALTER TABLE ivr_detail
ADD COLUMN billing_account_id VARCHAR(50);  

UPDATE ivr_detail
SET billing_account_id = (
    SELECT 
        MAX(SUBSTRING(step_description_error, POSITION('ACCOUNT_ID=' IN step_description_error) + 11, 50)) 
    FROM 
        ivr_steps
    WHERE 
        ivr_steps.calls_ivr_id = ivr_detail.calls_ivr_id
    AND 
        step_description_error LIKE '%ACCOUNT_ID=%'
    GROUP BY ivr_steps.calls_ivr_id
);
