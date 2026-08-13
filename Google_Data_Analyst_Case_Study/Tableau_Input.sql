WITH time_calc AS (
  SELECT
    `client_name`,
    -- Convert "-" strings to "N/A" in 'Contact Source' and 'Case Category' 
    CASE 
      WHEN `Contact Source` = '-' THEN 'N/A' 
      ELSE `Contact Source` 
    END AS `Contact Source`,
    CASE 
      WHEN `Case category` = '-' THEN 'N/A' 
      ELSE `Case category` 
    END AS `Case category`,
    Datetime_opened, Datetime_closed,
    DATETIME_DIFF(Datetime_closed, Datetime_opened, MINUTE) AS total_minutes
  FROM `hi-case-report.Cases.Case_Details_2`
)
SELECT
  `client_name`, `Contact Source`, `Case category`, Datetime_opened, Datetime_closed, total_minutes,
  CASE 
    -- Dynamic output handling Days, Hours, and Minutes
    WHEN total_minutes < 60 THEN
      FORMAT('%d min', total_minutes)
      
    WHEN total_minutes < 1440 THEN
      FORMAT('%d hr %d min', DIV(total_minutes, 60), MOD(total_minutes, 60))
      
    ELSE FORMAT(
      '%d day %d hr %d min',
      DIV(total_minutes, 1440),
      DIV(MOD(total_minutes, 1440), 60),
      MOD(total_minutes, 60)
    )
  END AS formatted_time_diff
FROM time_calc;