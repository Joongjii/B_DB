# 타입
# 문자열 : char, varchar
# 숫자 : int, double
# 날짜 : date, datetime


# dql : 테이블에서 원하는 데이터를 조회하는 구문
# 테이블에서 원하는 조건의 데이터를 조회한 결과를 result set(결과 집합) 이라고 한다.
# 작성법
# select 컬럼명...
# from 테이블명
# where 조건식


# 연산자
# 산술연산자 : + - * / &
# 비교연산자 : < > <= >= =
#    같지 않다 : != <>
# 논리연산자 : and or not

# job테이블에서 직급명을 조회
select job_name from job;

# job테이블의 모든 컬럼명을 조회
select * from job;

#emp 테이블에서 모든 사원의 사번 이름 급여를 조회
select * from employee;

#emp 테이블에서 급여가 300만원이상인 사원들이 이름과 급여를 조회하세요.
select emp_name,salary 
from employee 
where SALARY > 3000000;

# emp 테이블에서 부서코드 D9인 사원들을 조회하시오
select *
from employee
where dept_code = 'D9';

# 산술연사
# 1. emp 테이블에서 직원의 이름과 연봉(급여*12)을 조회하세요
select emp_name, salary*12
from employee;

# 2. emp 테이블에서 연봉이 3천만원 이상인 직원들의 이름과 급여를 조회
select emp_name, salary
from employee
where salary*12 > 30000000;

# 컬럼 별칭 붙이기
# 형식 : 컬럼명 as 별칭 - 강사 추천 이유는 가독성, 컬럼명 별칭, 컬럼명 as '별칭', 컬러면 '별칭'

select emp_name, salary*12 as 연봉
from employee;

# distinct
# reslut set에서 중복된 row를 제거 해준다

# employ 테이블에서 부서코드를 조회
select distinct dept_code 
from employee;

# emp 테이블에서 D5부서의 직원의 이름 연봉 보너스를 추가한 연봉을 조회하시오
# 연봉의 별칭은 연봉, 보녀를 포함한 연봉의 별칭은 총 연봉
# 총 연봉에 null이 나오는 것은 신경쓰지 마세요

select emp_name, salary * 12 as 연봉 ,  salary * (1+bonus) * 12 as '총 연봉'
from employee
where dept_code = 'D5' and salary >= 3000000 ;





