WITH avg_case_count AS (
  SELECT
    COUNT(Date_opened) AS total_count_opened, COUNT(Date_closed) AS total_count_closed,
    COUNT(DISTINCT Date_opened) AS distinct_count_opened, COUNT(DISTINCT Date_closed) AS distinct_count_closed
  FROM
    `hi-case-report.Cases.Tableau_Input_View`
  WHERE Date_opened > '2026-03-31' AND Date_closed > '2026-03-31')
SELECT
  ROUND(SAFE_DIVIDE(total_count_opened, distinct_count_opened), 2) AS avg_opened,
  ROUND(SAFE_DIVIDE(total_count_closed, distinct_count_closed),2) AS avg_closed
FROM
  avg_case_count;