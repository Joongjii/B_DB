# root 사용자로 진행해야 한다 이유는 권한관리라서 그렇다
# DCL (Data Control language)

# DCL 데이터 컨트롤 랭귀지
# 권한관리
# 관리자계정  -- 데이터베이스관리를 담당하는 슈퍼사용자
#           -- 데이터베이스의 모든 권한과 책임을 가지고있다 (루트)
# 사용자 계정 -- 테이터베이스에서 본인이 맡은 작업을 수행하는 계정
# 			-- 업무에 필요한 최소한의 권한만 부여

# 1. 계정생성
# BM
create user bm identified by '123qwe!@#QWE';
show grants for bm;

create user bm2 identified by '123qwe!@#QWE';

# 2. 권한 부여
# grant 권한 [,권한...] on db이름.테이블명 to 사용자 [with grant option]
# with grant option : 부여받은 권한을 다른 사용자에게 부여할 권한을 주는 옵션

grant select, insert on mc_sql.* to 'bm' with grant option;

# role : 역할에 필요한 권한을 하나의 이름을 묶은 권한의 묶음
create role 'web_dev';
grant select, update, delete, insert on mc_sql.* to 'web_dev';

# 3. 권한 회수
# revoke 권한 from 사용자
revoke select, insert on mc_sql.* from bm;
revoke select, insert on mc_sql.employee from bm;

revoke 'web_dev' from bm;

grant 'web_dev' to 'bm';
set default role 'web_dev' to 'bm';
show grants for 'bm';

## 데이터베이스에서 가장  중요한 것은 select입니다