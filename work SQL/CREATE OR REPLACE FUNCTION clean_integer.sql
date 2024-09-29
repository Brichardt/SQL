CREATE OR REPLACE FUNCTION clean_integer(input_value INTEGER)
RETURNS INTEGER
LANGUAGE SQL
AS $$
    -- Si el valor de entrada es NULL, devuelve -999999, de lo contrario, devuelve el valor de entrada.
    SELECT COALESCE(input_value, -999999);
$$;
