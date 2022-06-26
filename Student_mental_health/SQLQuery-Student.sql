SELECT * FROM Student..Student_Mental_Health


--Grouped by Courses 
SELECT course,COUNT(*)FROM Student..Student_Mental_Health 
GROUP BY course

--Replacing the incorrect entries with correct one
 UPDATE Student..Student_Mental_Health SET course='Engineering' WHERE course ='Engine'

 SELECT course,COUNT(*)FROM Student..Student_Mental_Health 
GROUP BY course

 UPDATE Student..Student_Mental_Health SET course='Law' WHERE course ='Laws'

  SELECT course,COUNT(*)FROM Student..Student_Mental_Health 
GROUP BY course

--Students with Marital Status ='Yes'

SELECT *FROM Student..Student_Mental_Health 
WHERE Marital_status ='Yes'


--Count of Students with Marital Status ='Yes'
SELECT COUNT(*)AS Num_Married FROM Student..Student_Mental_Health 
WHERE Marital_status ='Yes'

--%of Students with Marital Status ='Yes'
SELECT COUNT(*)AS Num_Married FROM Student..Student_Mental_Health 
WHERE Marital_status ='Yes'

-- Students  with Do_you_have_Depression ='Yes'--
SELECT *FROM Student..Student_Mental_Health 
WHERE Do_you_have_Depression='Yes'

SELECT COUNT(*)FROM Student..Student_Mental_Health 
WHERE Do_you_have_Depression='Yes'

SELECT COUNT(*)FROM Student..Student_Mental_Health 
WHERE Did_you_seek_any_specialist_for_a_treatment='Yes'

--CTE EXPRESSION--

WITH TREATMENT 
AS (
SELECT *FROM Student..Student_Mental_Health 
WHERE Did_you_seek_any_specialist_for_a_treatment='Yes'
)
SELECT course FROM TREATMENT

-- Students  with Do_you_have_Depression ='Yes'--

SELECT *FROM Student..Student_Mental_Health 
WHERE Do_you_have_Depression='Yes'


WITH DEPRESSION
AS (
SELECT *FROM Student..Student_Mental_Health 
WHERE Do_you_have_Depression='Yes'
)
SELECT DISTINCT course,COUNT(*) AS Dep_count FROM DEPRESSION
GROUP BY course

--Age with Engineering course are more in number.

-- Students  with Do_you_have_Anxiety=yes--
WITH ANXIETY
AS (
SELECT *FROM Student..Student_Mental_Health 
WHERE Do_you_have_Anxiety='Yes'
)
SELECT Age,COUNT(*)  FROM ANXIETY
GROUP BY Age

--Age with 18 years are having max number--


-- Students  with Do_you_have_Panic Attack=yes--
WITH PANIC
AS (
SELECT *FROM Student..Student_Mental_Health 
WHERE Do_you_have_Panic_attack='Yes'
)
SELECT Age,COUNT(*)  FROM PANIC
GROUP BY Age
--Age with 18,19,24 are having max number--

WITH TREATMENT
AS (
SELECT *FROM Student..Student_Mental_Health 
WHERE Did_you_seek_any_specialist_for_a_treatment='Yes'
)
SELECT Age,course,COUNT(*) FROM TREATMENT
GROUP BY course,Age

--Age with 18and 24 having max number--