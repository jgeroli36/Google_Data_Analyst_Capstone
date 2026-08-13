CREATE OR REPLACE VIEW `hi-case-report.Cases.Tableau_Input_View` AS
SELECT 
  *,
  GENERATE_UUID() AS case_id,
  DATE(Datetime_opened) AS Date_opened,
  DATE(Datetime_closed) AS Date_closed
FROM `hi-case-report.Cases.Tableau_Input`