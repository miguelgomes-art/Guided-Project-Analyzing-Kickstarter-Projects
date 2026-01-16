/* Introduction
 For this guided project, you'll take on the role of a data analyst at a startup. The product team is considering launching a campaign on Kickstarter to test the viability of some offerings. You've been asked to pull data that will help the team understand what might influence the success of a campaign. The data source is a selection of fields from Kaggle.

Questions to be answered

What types of projects are most likely to be successful?
Which projects fail?

*/
PRAGMA table_info(ksprojects);

SELECT *
  FROM ksprojects
 LIMIT 10;
	
-- Only keep the records where the project state is either 'failed', 'canceled', or 'suspended'.

SELECT main_category, goal, backers, pledged
  FROM ksprojects
 WHERE state IN ('failed', 'canceled', 'suspended')
 LIMIT 10;
 
-- Expand your query from the previous screen to find which of these projects had at least 100 backers and at least $20,000 pledged.
SELECT main_category, backers, pledged, goal
  FROM ksprojects
 WHERE state IN ('failed', 'canceled', 'suspended') AND pledged >= 20000 AND backers >= 100
 LIMIT 10;

-- Sort the results by two fields: Main category sorted in ascending order, and calculated field called 'pct_pledged', which divides 'pledged' by 'goal'. Sort this field in descending order. (Add 'pct_pledged' to the SELECT clause, too.)

-- Now, modify your query so that only projects in a failed state are returned.
SELECT main_category, backers, pledged, goal, pledged/goal AS pct_pledged
  FROM ksprojects
 WHERE state IN ('failed')
   AND backers >= 100 AND pledged >= 20000
 ORDER BY main_category ASC, pct_pledged DESC
 LIMIT 10;
 
-- Create a field 'funding_status' that applies the following logic based on the percentage of amount pledged to campaign goal: If the percentage pledged is greater than or equal to 1, then the project is "Fully funded"; If the percentage pledged is between 75% and 100%, then the project is "Nearly funded"; If the percentage pledged is less than 75%, then the project is "Not nearly funded".
  
  /*
  This query examines failed Kickstarter projects that have:
  - A substantial number of backers (>= 100)
  - Significant funding (>= $20,000)
  The results may indicate that factors other than funding or backer support contribute to project failure.
  */
  SELECT main_category, backers, pledged, goal, pledged / goal AS pct_pledged,
         CASE
         WHEN pledged/goal >= 1 THEN 'Fully funded'
         WHEN pledged/goal BETWEEN .75 AND 1 THEN 'Nearly funded'
         ELSE 'Not nearly funded'
         END AS funding_status
    FROM ksprojects
   WHERE state IN ('failed')
     AND backers >= 100 AND pledged >= 20000
ORDER BY main_category, pct_pledged DESC
   LIMIT 10;
