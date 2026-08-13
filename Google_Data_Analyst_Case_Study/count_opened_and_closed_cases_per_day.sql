SELECT 
  e.date_day,
  COUNT(DISTINCT c_open.case_id) AS open_count,
  COUNT(DISTINCT c_close.case_id) AS close_count
FROM `hi-case-report.Cases.Q1_date_table` e
LEFT JOIN `hi-case-report.Cases.Tableau_Input_View` c_open
  ON e.date_day = c_open.date_opened
LEFT JOIN `hi-case-report.Cases.Tableau_Input_View` c_close
  ON e.date_day = c_close.date_closed
GROUP BY 
  e.date_day
ORDER BY 
  e.date_day ASC;