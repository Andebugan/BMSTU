INSERT INTO TEACHER_STAIR_REGISTER (id, stair, teacher, entry_date, entry_time)
SELECT TEACHER_STAIR_REGISTER
FROM TEACHER_STAIR_REGISTER, (
	SELECT TEACHERS.ID
	FROM TEACHERS
	WHERE TEACHERS.DEPARTAMENT = 'ИУ7') AS TEACH_UI7
WHERE TEACHER_STAIR_REGISTER.TEACHER = TEACH_UI7.ID;