-- 오늘 주제 테이블
create table board1 (
	idx   	int not null auto_increment,	/* 게시글의 고유번호 */
	boardIdx int not null,				-- 원본글 고유번호(외래키로 지정)
	mid      varchar(20) not null,			/* 작성자 아이디 */
	nickName varchar(20) not null,			/* 작성자 닉네임 */
	title   varchar(100) not null,			/* 게시글 제목 */
	content text not null,					/* 게시글 내용 */
	hostIp  varchar(40) not null,			/* 글 올린이의 IP */
	wDate   datetime  default now(),		/* 글 올린 날짜/시간 */
	level int not null,
	primary key(idx),
	foreign key(boardIdx) references board(idx)	-- 외래키 설정
	on update cascade
	on delete restrict
);

alter table board1 add level int not null; 

drop table board1;
drop table board1Reply;

-- 게시판 댓글 달기
create table board1Reply (
	idx int not null auto_increment,	-- 댓글 고유번호
	board1Idx int not null,				-- 원본글 고유번호(외래키로 지정)
	mid varchar(20) not null,			-- 작성자 아이디
	nickName varchar(20) not null,		-- 작성자 닉네임
	content text not null,				-- 댓글 내용
	hostIp varchar(50) not null,		-- 댓글 쓴 PC 고유 IP
	good	int default 0,				-- '좋아요' 클릭 횟수 누적
	wDate datetime default now(),		-- 작성 날짜
	oX	varchar(10)	not null default 'X',				-- 찬반여부
	primary key(idx),					-- 기본키 : 고유번호
	foreign key(board1Idx) references board1(idx)	-- 외래키 설정
	on update cascade
	on delete restrict
);

