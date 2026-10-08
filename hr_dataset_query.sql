/* What is the total number of employees and the overall attrition rate? */
SELECT COUNT(*) AS total_employees,
SUM(CAST(Attrition AS INT)) AS total_Attrition,
CAST((SUM(CAST(Attrition AS INT))*100.0 / COUNT(*)) AS DECIMAL(8,2)) AS Attrition_rate
FROM Hr_Dataset
--Which departments have the highest attrition rate?
SELECT Department,
CAST((SUM(CAST(Attrition AS INT))*100.0 / COUNT(*)) AS DECIMAL(8,2)) AS Attrition_rate
FROM Hr_Dataset
GROUP BY Department
ORDER BY Attrition_rate DESC;

/* Which job roles have the highest attrition rate */
SELECT Job_Role,
CAST((SUM(CAST(Attrition AS INT))*100.0 / COUNT(*)) AS DECIMAL(8,2)) AS Attrition_rate
FROM Hr_Dataset
GROUP BY Job_Role
ORDER BY Attrition_rate DESC;
/* Does job satisfaction differ between employees who stay and employees who leave? */
SELECT
    Attrition,
    AVG(Job_Satisfaction) AS Avg_Job_Satisfaction
FROM Hr_Dataset
GROUP BY Attrition;
/* Is overtime associated with higher employee attrition? */
SELECT Overtime,
SUM(CAST(Attrition AS INT)) AS total_Attrition,
CAST((SUM(CAST(Attrition AS INT))*100.0 / COUNT(*)) AS DECIMAL(8,2)) AS Attrition_rate
FROM Hr_Dataset
GROUP BY Overtime;
/* Is poor work-life balance associated with higher attrition? */
SELECT Work_Life_Balance,
SUM(CAST(Attrition AS INT)) AS total_Attrition,
CAST((SUM(CAST(Attrition AS INT))*100.0 / COUNT(*)) AS DECIMAL(8,2)) AS Attrition_rate
FROM Hr_Dataset
GROUP BY Work_Life_Balance
ORDER BY Attrition_rate DESC;
/* Is distance from the workplace associated with higher employee attrition? */
SELECT 
    COUNT(*) AS total_employees,
    CASE  
        WHEN Distance_From_Home <= 5 THEN 'Near'
        WHEN Distance_From_Home > 5 AND Distance_From_Home <= 10 THEN 'Moderate'
        WHEN Distance_From_Home > 10 AND Distance_From_Home <= 20 THEN 'Far'
        WHEN Distance_From_Home > 20 THEN 'Very Far'
    END AS distance_group,
    SUM(CAST(Attrition AS INT)) AS total_Attrition,
    CAST(
        SUM(CAST(Attrition AS INT)) * 100.0 / COUNT(*)
        AS DECIMAL(8,2)
    ) AS Attrition_rate
FROM Hr_Dataset
GROUP BY
    CASE  
        WHEN Distance_From_Home <= 5 THEN 'Near'
        WHEN Distance_From_Home > 5 AND Distance_From_Home <= 10 THEN 'Moderate'
        WHEN Distance_From_Home > 10 AND Distance_From_Home <= 20 THEN 'Far'
        WHEN Distance_From_Home > 20 THEN 'Very Far'
    END



/* Are employees who have gone longer without a promotion more likely to leave? */
SELECT
    CASE
        WHEN Years_Since_Last_Promotion <= 2 THEN '0-2 Years'
        WHEN Years_Since_Last_Promotion BETWEEN 3 AND 5 THEN '3-5 Years'
        ELSE '6+ Years'
    END AS Promotion_Gap_Group,

    COUNT(*) AS Total_Employees,

    SUM(CAST(Attrition AS INT)) AS Total_Attrition,

    CAST(
        SUM(CAST(Attrition AS INT)) * 100.0 / COUNT(*)
        AS DECIMAL(8,2)
    ) AS Attrition_Rate

FROM Hr_Dataset

GROUP BY
    CASE
        WHEN Years_Since_Last_Promotion <= 2 THEN '0-2 Years'
        WHEN Years_Since_Last_Promotion BETWEEN 3 AND 5 THEN '3-5 Years'
        ELSE '6+ Years'
    END

ORDER BY Attrition_Rate DESC;

/* Which departments have the highest average monthly income, 
and how does income vary by job level? */
SELECT Department,
Job_Level,
Avg(Monthly_Income) AS avg_monthly_income
FROM Hr_Dataset
GROUP BY Department,Job_Level
ORDER BY avg_monthly_income DESC;
/* Which employees have long tenure but have not received a promotion recently? */
SELECT
    Employee_ID,
    Department,
    Job_Role,
    Job_Level,
    Years_at_Company,
    Years_Since_Last_Promotion
FROM Hr_Dataset
WHERE Years_at_Company >= 8
  AND Years_Since_Last_Promotion >= 4
ORDER BY Years_at_Company DESC;
/* Which employee groups have high workload and high absenteeism? */
SELECT
    CASE
        WHEN Average_Hours_Worked_Per_Week < 40 THEN 'Low Workload'
        WHEN Average_Hours_Worked_Per_Week BETWEEN 40 AND 50 THEN 'Medium Workload'
        ELSE 'High Workload'
    END AS Workload_Group,

    COUNT(*) AS Total_Employees,
    AVG(Absent_days) AS Avg_Absent_Days
FROM Hr_Dataset
GROUP BY
    CASE
        WHEN Average_Hours_Worked_Per_Week < 40 THEN 'Low Workload'
        WHEN Average_Hours_Worked_Per_Week BETWEEN 40 AND 50 THEN 'Medium Workload'
        ELSE 'High Workload'
    END;

/* Which combination of department, job role, and overtime has the highest attrition rate? */
SELECT Department,Job_Role, Overtime,
COUNT(*) AS total_Employees,
CAST((SUM(CAST(Attrition AS INT))*100.0 / COUNT(*)) AS DECIMAL(8,2)) AS Attrition_rate
FROM Hr_Dataset
GROUP BY Department,Job_Role, Overtime
ORDER BY Attrition_rate DESC;