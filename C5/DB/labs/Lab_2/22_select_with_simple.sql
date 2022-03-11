WITH IU7_STUDS AS (
	SELECT STUDENTS.ID, STUDENTS.NAME, STUDENTS.SURNAME, STUDENTS.AGE
	FROM STUDENTS
	WHERE STUDENTS.DEPARTAMENT = 'ИУ7'
)

SELECT AVG(AGE) AS avg_age
FROM IU7_STUDS;