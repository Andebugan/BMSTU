SELECT TEACHERS.DEPARTAMENT, AVG(TEACHERS.AGE) AS avg_age
FROM TEACHERS
GROUP BY TEACHERS.DEPARTAMENT
HAVING AVG(TEACHERS.AGE) > 50;