SELECT SSR_STD.ID, SSR_STD.NAME, SSR_STD.SURNAME, SSR_STD.ENTRY_DATE, SSR_STD.ENTRY_TIME
FROM ((
	SELECT STUDENT_STAIR_REGISTER.STUDENT, STUDENT_STAIR_REGISTER.ENTRY_DATE, STUDENT_STAIR_REGISTER.ENTRY_TIME
	FROM STUDENT_STAIR_REGISTER
		 ) AS SSR JOIN (
	SELECT STUDENTS.ID, STUDENTS.NAME, STUDENTS.SURNAME
	FROM STUDENTS
	WHERE STUDENTS.DEPARTAMENT = 'ИУ7'
) AS STD ON STD.ID = SSR.STUDENT) AS SSR_STD;