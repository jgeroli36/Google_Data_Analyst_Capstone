-- Drop unnecessary columns
ALTER TABLE `hi-case-report.Cases.Case_Details_2`
  DROP COLUMN IF EXISTS string_field_6,
  DROP COLUMN IF EXISTS string_field_7;

-- Add a new column with the DATETIME data type and populate column with converted data
ALTER TABLE `hi-case-report.Cases.Case_Details_2`
  ADD COLUMN IF NOT EXISTS Datetime_opened DATETIME,
  ADD COLUMN IF NOT EXISTS Datetime_closed DATETIME;

-- FIX 1: Split UPDATE assignments with commas instead of 'AND'
UPDATE `hi-case-report.Cases.Case_Details_2`
  SET Datetime_opened = SAFE.PARSE_DATETIME('%m/%d/%Y %I:%M %p', CAST(`Date opened` AS STRING)),
      Datetime_closed = SAFE.PARSE_DATETIME('%m/%d/%Y %I:%M %p', CAST(`Date closed` AS STRING))
  WHERE TRUE;

-- Drop Date opened column
ALTER TABLE `hi-case-report.Cases.Case_Details_2`
  DROP COLUMN IF EXISTS `Date opened`,
  DROP COLUMN IF EXISTS `Date closed`;

-- Anonymize Client Names
ALTER TABLE `hi-case-report.Cases.Case_Details_2`
  ADD COLUMN IF NOT EXISTS `client_name` STRING;

-- Create Anonymizing function
CREATE TEMP FUNCTION AnonymizeName(name STRING) 
RETURNS STRING 
LANGUAGE js AS r"""
  if (!name) return null;
  
  return name.trim().split(/\s+/).map(word => {
    const cleanWord = word.trim();
    const upperWord = cleanWord.toUpperCase();
    
    // 1. Keep any suffix up to 3 letters (e.g., CORP, LTD, PLC)
    if (cleanWord.length <= 3 && /^[A-Za-z.,]+$/.test(cleanWord)) {
      return cleanWord;
    }
    
    // 2. Otherwise, take only the first character
    return cleanWord.charAt(0);
  }).join(' ');
""";

-- Update the column using the custom function
UPDATE `hi-case-report.Cases.Case_Details_2`
  SET `client_name` = AnonymizeName(`Customer Name`)
WHERE TRUE;

-- Drop 'Customer Name' column
ALTER TABLE `hi-case-report.Cases.Case_Details_2`
  DROP COLUMN IF EXISTS `Customer Name`;