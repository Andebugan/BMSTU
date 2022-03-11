SELECT STUDENTS.NAME, STUDENTS.SURNAME,
CASE
WHEN STUDENTS.AGE < 19 THEN '1st course'
WHEN STUDENTS.AGE < 20 THEN '2nd course'
WHEN STUDENTS.AGE < 21 THEN '3rd course'
WHEN STUDENTS.AGE < 22 THEN '4th course'
ELSE 'mage'
END AS course
FROM STUDENTS;