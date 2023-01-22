# DDL : creat(생성) drop(삭제) alter(수정)
# DDL은 auto commit; 

# 테이블 생성 구문
#CREATE TABLE 테이블명 (
#  컬럼명 type(크기)  제약조건
# ,...
#
# 제약조건
#)


#데이터무결성
#데이터의 정확성 일관성 유효성을 지키는 것
#데이터 무결성 보장을 위해 dbms는 무결성 제약조건을 제공해준다.

CREATE TABLE our_dept (
    dept_code CHAR(3) PRIMARY KEY,
    dept_title VARCHAR(30)
);  

 
insert into our_dept values('D01','개발팀');
insert into our_dept(dept_code, dept_title) values('D02','인사팀');
insert into our_dept values('D03','총무팀');
commit;
 select*from our_dept;

create table our_emp(

	# 무결성을 위한 제약조건
		# primary key, foreign key, unique, check, default, not null
		# primary key(기본 키)
    # 테이블을 대표하며, 테이블이 각 행을 식별하기 위해 사용하는 컬럼에 지정
    # 예시 -- 회원 테이블이면 아이디 
	# 컬럼에 중복값을 허용하지 않는다 - 유일성
	# 컬럼에 null을 허용하지 않는다 - 최소성
    # 기본키는 유일성과 최소성이 반드시 만족되는 컬럼에 지정해야한다
    
    # 모든 테이블에 기본키를 만들어주는 것이 좋다
    # 기본키를 지정하면, 내부적으로 고유 인덱스라는 것이 생성이 돼
	# db가 테이블의 데이터를 검색할 때 빠르게 수행할 수 있다  
    
    # 식별자로 사용할 수 있는 컬럼 또는 컬럼 집합을 슈퍼키라고 한다
    # 식별자로 사용할 수 있고 최소한의 컬럼 집합을 후보키라고 한다
    # 후보키 중에서 가장 대표성을 지니는 컬럼을 기본키로 지정
    
  # emp_ id를 기본키로 지정
  # auto_increment : insert 문에서 컬럼을 지정하지 않으면
  # 순차적으로 1씩 증가하는 숫자값을 emp_id에 디폴트로 넣어준다
	#emp_id int auto_increment primary
	emp_id int primary key
    
	# not null : 컬럼에 null값을 허용하지 않음
    ,emp_name varchar(30) not null
    
    #check : 도메인 무결성을 보장 : 도메인에 속한 값만 컬럼에 추가 가능
	,age int check(age>0)
	
    #unique : 중복값을 허용하지 않음
    , emp_no char(14) unique
    
    #default : insert때 컬럼을 명시하지 않으면, default값을 세팅
    ,hire_date timestamp default NOW()
    
    # 참조무결성 
    
    # 1. 자신이 참조하고 있는 테이블에 존재하지 않는 값은 지정할 수 없다.
    # 2. 자신을 참조하고 있는 테이블이 있다면, 참조되고 있는 행은 삭제할 수 없다
    
    # 참조하고 있는 테이블 자식테이블
    # 참조되고 있는 테이블 부모테이블
    
    ,dept_code char(3)
    
    #dept_code를 외래키 - 부모테이블을 참조하는 키 -로 사용
    #부모테이블에서 유일성과 최소성을 만족하는 컬럼을 외래키로 사용해야한다
    # 그래서 보통 기본키를 참조한다
    , foreign key(dept_code) references our_dept(dept_code)
);

#default 확인 : hire_date에 현재시간이 들어간 것을 확인

insert into our_emp(emp_id, emp_name, age, emp_no, dept_code)
values(1, '하명도',19,'000000-0000000','D01');

#외래키 제약조건 확인
# DELTE FROM OUR_DEPT WHERE DPET_CODE = 'D01';  => 삭제 불가. , 자식 테이블이 D01로 식별되는 행을 참조하고 있음
# DELTE FROM OUR_DEPT WHERE DPET_CODE = 'D02';  => 삭제 가능.
# UPDATE OUR_DEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D01'; => 자식테이블에서 외래키로 사용하고 있는 컬럼은 수정이 불가능
ROLLBACK;

# 외래키 제약조건 확인 2
# 부모테이블의 컬럼에 존재하지 않는 값을 자식테이블의 외래키 컬럼에 넣을 수 없음
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(1, '하명도', 19, '000000-0000000', 'D04');

# NULL 제약조건 : NOT NULL이 지정된 EMP_NAME을 빼고 INSERT
# 실패
-- INSERT INTO OUR_EMP(EMP_ID, AGE, EMP_NO, DEPT_CODE)
-- VALUES(2, 19, '000000-0000001', 'D01');

# 성공
INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(2, '신비', 19, '000000-0000001', 'D01');
COMMIT;

# CHECK 제약조건
# AGE에 -100을 넣어보자.
# 실패
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(3, '배재현', -100, '000000-0000002', 'D01');

# 성공
INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(3, '배재현', 10, '000000-0000002', 'D01');
COMMIT;

# UNIQUE 제약조건
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(4, '이준형', 10, '000000-0000002', 'D01');

INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(4, '이준형', 10, '000000-0000003', 'D01');

# 기본키 : primary key : unique + not null
# not null 어겨보기
# 기본키 : 유일성 + 최소성
# 최소성 어겨보기
-- INSERT INTO OUR_EMP( EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES('여태양', 15, '000000-0000004', 'D01');

# 유일성 어겨보기
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(4, '여태양', 15, '000000-0000004', 'D01');

INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(5, '여태양', 15, '000000-0000004', 'D01');
COMMIT;

INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(6, '여태양', 15, '000000-0000005', 'D01');
COMMIT;



#컬럼의 크기는 컬럼에 포함된 데이터보다 큰 크기로만 가능
#제약조건은 현재 데이터들의 증가로 

# alter table our_emp modify emp_name varchar(2); 불가능!

alter table our_emp modify emp_name varchar(30);
alter table our_emp modify emp_name varchar(20) unique;
delete from our_emp where emp_id = 6;
commit;

# alter table our_emp modify job varchar(20) unique;

alter table our_emp modify age int check (age >= 10);
#alter table our_emp modify age int check (age >= 20);

# 테이블 복제
CREATE TABLE CP_EMPLOYEE
AS SELECT * FROM EMPLOYEE WHERE ENT_YN = 'Y';

# 테이블 구조 복제
CREATE TABLE EMPLOYEE_DEPT
AS SELECT 
* 
FROM EMPLOYEE 
JOIN department ON(DEPT_ID = DEPT_CODE)
WHERE 1=0;


