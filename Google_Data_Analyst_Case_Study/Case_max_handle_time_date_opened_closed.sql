WITH max_handle_time AS(
  SELECT *
  FROM
    `hi-case-report.Cases.Tableau_Input_View`
  ORDER BY
    `total_minutes` DESC
  LIMIT 1
)
SELECT 
  `Case category`, Date_opened, Date_closed, formatted_time_diff
FROM
  max_handle_time