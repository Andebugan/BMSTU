DELETE STUDENTS
WHERE STUDENTS.ID IN (
	SELECT STUDENT_STAIR_REGISTER.STUDENT
	FROM STUDENT_STAIR_REGISTER
	WHERE STUDENT_STAIR_REGISTER.ENTRY_DATE = '1.9.2021'
);