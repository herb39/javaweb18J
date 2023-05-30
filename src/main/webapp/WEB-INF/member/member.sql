show tables;
drop table member;

create table member (
	idx 		int 			not null 	auto_increment,		-- 고유번호
	mid 		varchar(20) 	not null,						-- 아이디(중복x)
	pwd 		varchar(100) 	not null,						-- 비밀번호(SHA256 암호화)
	nickName	varchar(20) 	not null,						-- 닉네임(중복x/수정o)
	name 		varchar(20) 	not null,						-- 성명
	email		varchar(50)		not null,						-- 이메일(아이디/비밀번호 찾기) *폼체크 필수
	image		varchar(100)	default 	'noimage.jpg',		-- 사진
	userDel		char(2)			default		'NO',				-- 탈퇴신청여부 OK:탈퇴신청중
	point		int				default		0,					-- 좋아요 누적
	level		int				default		1,					-- 회원등급 0관리자 1~99회원 100운영자
	salt		char(8)			not null,						-- 비밀번호 보안 해시키
	primary key (idx, mid)
);

CREATE TABLE `member` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `nickName` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `userDel` char(2) DEFAULT 'NO',
  `point` int DEFAULT '0',
  `level` int DEFAULT '1',
  `salt` char(8) NOT NULL,
  PRIMARY KEY (`idx`,`mid`)
);


alter table member alter column point set default 0;

desc member;

select * from member;

delete from member where idx='17';

update member set level='0' where idx='1';

alter table member add salt char(8);

drop table member;


ALTER TABLE board
ADD COLUMN memberIdx INT NOT NULL,
ADD FOREIGN KEY (memberIdx) REFERENCES member(idx);

ALTER TABLE board1
ADD COLUMN memberIdx INT NOT NULL,
ADD FOREIGN KEY (memberIdx) REFERENCES member(idx);

ALTER TABLE board1Reply
ADD COLUMN memberIdx INT NOT NULL,
ADD FOREIGN KEY (memberIdx) REFERENCES member(idx);



ALTER TABLE board
DROP FOREIGN KEY board_ibfk_1,
DROP COLUMN memberIdx;

ALTER TABLE board1
DROP FOREIGN KEY board1_ibfk_2,
DROP COLUMN memberIdx;

ALTER TABLE board1Reply
DROP FOREIGN KEY board1Reply_ibfk_2,
DROP COLUMN memberIdx;


















