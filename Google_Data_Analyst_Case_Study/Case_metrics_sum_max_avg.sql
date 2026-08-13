WITH max_case AS(
  SELECT
    `Case Category`, COUNT(1) AS total_cases,
    COUNT(DISTINCT `Case Category`) AS distinct_category_count,
    CAST(ROUND(SUM(total_minutes)) AS INT64) AS total_time_sum,
    CAST(ROUND(AVG(total_minutes)) AS INT64) AS avg_handle_time,
    CAST(ROUND(MAX(total_minutes)) AS INT64) AS max_single_total_time
  FROM
    `hi-case-report.Cases.Tableau_Input_View`
  GROUP BY 
    `Case Category`
)
SELECT `Case Category`, total_cases,
  CASE
    WHEN total_time_sum < 60 THEN
      FORMAT('%d mins', total_time_sum)
    WHEN total_time_sum < 1440 THEN
      FORMAT('%d hrs %d mins', DIV(total_time_sum, 60), MOD(total_time_sum, 60))
    ELSE FORMAT(
      '%d days %d hrs %d mins',
      DIV(total_time_sum, 1440),
      DIV(MOD(total_time_sum, 1440), 60),
      MOD(total_time_sum, 60))
  END AS `Total Handle Time`,
  CASE
    WHEN avg_handle_time < 60 THEN
      FORMAT('%d mins', avg_handle_time)
    WHEN avg_handle_time < 1440 THEN
      FORMAT('%d hrs %d mins', DIV(avg_handle_time, 60), MOD(avg_handle_time, 60))
    ELSE FORMAT(
      '%d days %d hrs %d mins',
      DIV(avg_handle_time, 1440),
      DIV(MOD(avg_handle_time, 1440), 60),
      MOD(avg_handle_time, 60))
  END AS `Average Handle Time`,
  CASE
    WHEN max_single_total_time < 60 THEN
      FORMAT('%d mins', max_single_total_time)
    WHEN max_single_total_time < 1440 THEN
      FORMAT('%d hrs %d mins', DIV(max_single_total_time, 60), MOD(max_single_total_time, 60))
    ELSE FORMAT(
      '%d days %d hrs %d mins',
      DIV(max_single_total_time, 1440),
      DIV(MOD(max_single_total_time, 1440), 60),
      MOD(max_single_total_time, 60))
  END AS `Max Handle Time`,
FROM max_case
ORDER BY
  total_cases DESC,
  total_time_sum DESC,
  avg_handle_time DESC,
  max_single_total_time DESC 
LIMIT 10