[README.md](https://github.com/user-attachments/files/31043729/README.md)
**An Experimental Case Study on Retirement and Investment Client Cases**

A revenue and engagement manager for the parody company “Homosapien Intrigue” has approached this data analyst with the following business need:

* Analyze Q1 customer service case details  
* Find trends in case handling times, high volume case categories, etc  
* Recommend areas for improvement and focus areas  
* Insight on increasing conversion rates and manage client retention/upgrade and churn

**Timeframe:** Cases analyzed were opened during Q1 2026\. Some did not close until much later in the year.

Analysis tools:

* BigQuery SQL  
  * [\`Data\_cleaning.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/Data_cleaning.sql)- cleaned the raw dataset
  * [\`Tableau\_Input.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/Tableau_Input.sql) and [\`Tableau\_Inpu\_Viewt.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/Tableau_Input_View.sql)- created ingestible table for Tableau  
  * [\`date\_table.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/date_table.sql)- a placement table for creating date relationships for Tableau timeline line chart    
* Tableau Desktop  
  * Case Count & Avg Handle Time  
    * Bubble chart  
      * Circle Size represents the count of cases with larger bubbles having a higher volume of cases  
      * Color represents the average handle time in days with darker teal having a higher average  
  * Closed vs Opened Timeline  
    * Line chart showing the count and divergence between count of open vs closed case dates  
* Case study data was sourced from Customer Relationship Management platform, Salesforce. It was scrubbed clean of PII. Financial data was not used (PII).   
* Source data is stored in the relational database management system, Snowflake, warehouse with Tableau as the integrated BI platform

**Top Insights found during analysis:**

* BigQuery SQL  
  * [\`Case\_metrics\_sum\_max\_avg.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/Case_metrics_sum_max_avg.sql) and [\`Case\_max\_handle\_time\_date\_opened\_closed.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/Case_max_handle_time_date_opened_closed.sql) used to find the following:  
    * There is a large amount of unidentified or “N/A” cases  
      * Total Case count 86, Avg Handle Time 7 days 19 hrs 11 mins, Total Handle Time All Cases 662 days 22 hrs 26 mins, and Max Case Handle Time 195 days 22 hrs 33 mins  
      * These are chalked up to “user error” as the customer service agents did not correctly document the case category in Salesforce (coaching opportunity for more accurate data compiling)  
    * Highest Total Case Count: 111  
      * Case category: Termination of Employment  
    * Highest Total Handle Time: 929 days 11 hrs 51 mins  
      * Case category: Discrepancy  
    * Highest Avg Handle Time: 35 days 9 hrs 10 mins  
      * Case category: Plan Deconversion  
    * Longest Max Case Handle Time: 195 days 22 hrs 33 mins  
      * “N/A”  
      * Opened 1/2/26, Closed 7/17/26  
    * Case category “Discrepancy” has the heaviest combined burden  
      * Total Case count 78, Avg Handle Time 11 days 22 hrs, Total Handle Time All Cases 929 days 11 hrs 51 mins, and Max Case Handle Time 91 days 2 hrs 12 mins  
  * [\`Case\_avg\_daily\_opened\_closed.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/Case_avg_daily_opened_closed.sql)  
    * From 1/1/26 to 3/31/26, Avg Daily Opened cases:18.63, Avg Closed cases: 14  
* Tableau Charts
  * [\`count_opened_and_closed_cases_per_day.sql\`](https://github.com/jgeroli36/Google_Data_Analyst_Capstone/blob/2f9069591177f5dd55eb9fea3100f7b1be4a1f70/Google_Data_Analyst_Case_Study/count_opened_and_closed_cases_per_day.sql)
  * An uptick in cases from 2025 EOY to 2026 Q1 is due to it being peak compliance season  
  * Maximum Divergence (Opened vs closed): 49 \- Occurred on Jan 4, 26 (128 vs 79\)  
  * Minimum Divergence (Opened vs closed): 1 \- Occurred on Feb 8, 26 (119 vs 120\)

**Recommendations for Improvement**

**Identify High-Burden Cases:** 

* Use Salesforce to track top 10 weekly categories driven by high volume and long handle times, then address them using two targeted strategies:  
  * High Volume: Tech Failures (e.g., API issues, system lag)  
    * Triage & Containment: Post status banners to reduce duplicate tickets, bulk-tag incoming cases, and deprioritize non-urgent inquiries.  
    * Streamlined Communication: Send standardized auto-replies with adjusted SLA timelines, then bulk-resolve tagged tickets once fixed.  
    * Operations: Shift staff to front-line triage and set up a dedicated Slack bridge with engineering.  
    * Post-Incident: Hold a root-cause post-mortem with engineering and build auto-routing rules for future error logs.  
  * High Volume: Manual Causes (e.g., data entry errors)  
    * Dedicated Onboarding Task Force: Create a specialized customer success team to provide white-glove setup support for SMB clients who lack the technical resources to integrate via APIs independently.

**Addressing Conversation Rates and client retention/upgrade:**

* Conversion Rate \= (\# of completed actions/Total prospects) x 100  
  * Conversion rates need to be tracked across multiple stages from initial tool usage to consultation booking to account funding:  
    * Traffic to Lead conversion, Lead to consultation, Consultation to acquisition  
* Simplify the initial client signup  
  * Replace long, intimidating intake forms with multi-step, progressive forms, create a more streamlined digital sign-up. Provide interactive tools (e.g., "How much will you need by age 65?") that deliver instant personalized insights and user experience.   
* Build trust & social proof early  
  * Transparency on processes and timelines, fee structures. Realistic switchover conversations, especially related to payroll. Work with the client's HR department to make sure they are aware of potential holds on funds while transfers are in place and offer workarounds if needed.  
* Training prediction models on the intersection of SLA results and CSAT scores  
  * High SLA \+ Positive CSAT (Optimal): High speed and high satisfaction. Benchmark for best practices and upgrade potential  
  * High SLA \+ Negative CSAT (Efficiency Paradox): Fast resolution, but poor experience. Indicates rushed service, lack of empathy, or quality issues.  
  * Poor SLA \+ Positive CSAT (High-Touch Value): Delayed resolution, but high satisfaction. Highlights complex cases where thoroughness outweighs speed.  
  * Poor SLA \+ Negative CSAT (Critical Risk): Operational failure directly impacting retention. Benchmark for customer churn

**Top 3 metrics to define success:**

1. Case Handle Time (CHT)  
   1. Why to use it: Measures operational efficiency. Increasing sales conversions naturally spikes incoming workload; tracking CHT ensures high lead volume does not degrade the speed of processing or onboarding.  
   2. How to use it: Monitor CHT alongside conversion spikes.  
   3. Success signal: CHT decreases or remains stable as conversion rates rise, showing that processes are streamlined.  
   4. Warning signal: A rising CHT indicates that agents or systems are struggling with higher complexity or volume, risking drop-offs before transactions complete.  
2. Divergence of Opened vs. Closed Cases  
   1. Why to use it: Measures system balance and backlog stability. It compares incoming demand (opened cases) against operational fulfillment (closed cases).  
   2. How to use it: Plot open volume against closed volume over time.  
   3. Success signal: Parallel lines (convergence), meaning cases are resolved as quickly as new leads convert.  
   4. Warning signal: Divergence (opened cases outstripping closed cases), signaling a growing backlog. High conversion rates fail if onboarding or post-sale operations create a bottleneck.  
3. Customer Satisfaction Score (CSAT)  
   1. Why to use it: CSATs were not analyzed in this case study, however, they are crucial in measuring quality and long-term retention. Converting leads rapidly is meaningless if speed comes at the cost of service quality and customer happiness.  
   2. How to use it: Collect post-interaction feedback immediately after key conversion touchpoints.  
   3. Success signal: High or rising CSAT scores alongside high conversion rates confirm that quality isn't being sacrificed for speed or volume.  
   4. Warning signal: A drop in CSAT indicates burnout, rushed service, or poor customer experience—leading to high churn shortly after conversion.
