use univ_db;

select * from student;

-- 1. 가장 키 큰 학생 찾기\
-- max를 이용하면 될 것 같지만 max는 그룹연산시 사용가능하므로 결과가 나오지 않음 
select student_name, max(height) from student;

-- student 테이블에서 먼저 height의 max 값을 찾은 후 그값을 조건으로 이용해서 탐색
-- 단일 행 서브쿼리  (결과가 1행만 반환)
SELECT student_name
FROM student
WHERE height = (SELECT MAX(height) FROM student);


-- 2. 수학과/정보통신학과 소속 학생 찾기
select * from student;  -- student 테이블에는 학과 번호만 있고 학과 이름은 알 수 없음
select * from department; -- departent 테입블을 조회 해야만 학과 이름이 나옴
-- 1번에서는 키가 가장 큰 값 1개만 찾아서 이용했으나 이번에는 수학과, 정보통신학과 2개의 조건이 있으므로 in 을 사용
-- 다중 행 서브쿼리 (결과가 여러 행 반환, IN/ANY/ALL 연산자와 함께 사용)

SELECT department_id FROM department WHERE department_name IN ('수학', '정보통신학');  -- 1, 3
SELECT student_name FROM student WHERE department_id IN (1,3);

SELECT student_name
FROM student
WHERE department_id IN (
SELECT department_id
FROM department
WHERE department_name IN ('수학', '정보통신학')
);


-- 3. 학생 이름과 학과 이름 같이 조회상관 서브쿼리 (Correlated Subquery)
-- 스칼라 서브쿼리 (하나의 값만 반환, SELECT 절에서 사용)
select * from student;
select * from department;

SELECT student_name,
(SELECT department_name
FROM department d
WHERE d.department_id = s.department_id) AS dept_name
FROM student s;

-- 조인을 이용해서도 검색 가능
select s.student_name, d.department_name from student s 
inner join department d on s.department_id = d.department_id; 


-- 4. 자기 학과 평균보다 키 큰 학생을 찾아 이름과 학과 출력하기
-- 외부 쿼리의 각 행에 대해 서브쿼리가 실행됨.

-- group by를 통해서 학과별 평균키를 구할 수 있으나 각 생별로 비교하는 것이 안됨
select * from student;
select department_id, avg(height) as mean_height from student group by department_id;

-- group by 결과를 join으로 합치는 것이 가능
select * from student s 
inner join (select department_id, avg(height) as mean_height from student group by department_id) h
on s.department_id = h.department_id;

select * from student s 
inner join (select department_id, avg(height) as mean_height from student group by department_id) h
on s.department_id = h.department_id where s.height > h.mean_height;

select s.student_name, d.department_name from student s 
inner join (select department_id, avg(height) as mean_height  from student group by department_id) h
on s.department_id = h.department_id 
inner join department d on s.department_id = d.department_id where s.height > h.mean_height;
 

-- 서브쿼리로 구현
SELECT student_name, department_name
FROM student s
inner join department d on s.department_id = d.department_id
WHERE height > (
SELECT AVG(height)
FROM student
WHERE department_id = s.department_id
);

