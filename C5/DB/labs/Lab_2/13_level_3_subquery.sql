SELECT STAIRS.STEP_NUM
FROM STAIRS, (
	SELECT STUDENT_STAIR_REGISTER.STAIR
	FROM STUDENT_STAIR_REGISTER, (
		SELECT STUDENTS.ID
		FROM STUDENTS
		WHERE STUDENTS.SEX = 'м'
	) AS STD_M
	WHERE STD_M.ID = STUDENT_STAIR_REGISTER.STUDENT) AS STAIRS_STD_M
WHERE STAIRS.ID = STAIRS_STD_M.STAIR;