show tables;

create table board (
	idx   	int not null auto_increment,	/* 게시글의 고유번호 */
	mid      varchar(20) not null,			/* 작성자 아이디 */
	nickName varchar(20) not null,			/* 작성자 닉네임 */
	title   varchar(100) not null,			/* 게시글 제목 */
	content text not null,					/* 게시글 내용 */
	readNum int default 0,					/* 글 조회수 */
	hostIp  varchar(40) not null,			/* 글 올린이의 IP */
	wDate   datetime  default now(),		/* 글 올린 날짜/시간 */
	good	int default 0,					/* '좋아요' 클릭 횟수 누적 */
	primary key(idx)
);


CREATE TABLE `board` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) NOT NULL,
  `nickName` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `readNum` int DEFAULT '0',
  `wDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `good` int DEFAULT '0',
  memberIdx int not null,
  PRIMARY KEY (`idx`),
	foreign key(memberIdx) references member(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade	
);



desc board;

insert into board values (default,'admin','관리맨','게시판 서비스를 시작합니다.','admin@naver.com','admin.tistory.com','이곳은 게시판입니다.',default,'192.168.50.96',default,default,default);

select * from boardReply;

-- 게시판 댓글 달기
create table boardReply (
	idx int not null auto_increment,	-- 댓글 고유번호
	boardIdx int not null,				-- 원본글 고유번호(외래키로 지정)
	mid varchar(20) not null,			-- 작성자 아이디
	nickName varchar(20) not null,		-- 작성자 닉네임
	wDate datetime default now(),		-- 작성 날짜
	hostIp varchar(50) not null,		-- 댓글 쓴 PC 고유 IP
	content text not null,				-- 댓글 내용
	primary key(idx),					-- 기본키 : 고유번호
	foreign key(boardIdx) references board(idx)	-- 외래키 설정
	on update cascade
	on delete restrict
);


/* 날짜함수 처리 연습 */
select now();				/* 오늘 날짜 보여달라. */
select year(now());
select month(now());
select day(now());
select concat(year(now()),'년 ',month(now()), '월 ', day(now()), '일');
select concat(year(now()),'년 ',month(now()), '월 ', day(now()), '일') as nalja;
select date(now());				/* 날짜를 '년-월-일' 로 출력 */
select weekday(now()); 		/* 0(월), 1(화), 2(수), 3(목), 4(금), 5(토), 6(일) */
select dayofweek(now());	/* 1(일), 2(월), 3(화), 4(수), 5(목), 6(금), 7(토) */

select year('2023-5-3');
select idx,wDate from board;
select idx,year(wDate) from board;

/* 날짜 연산 */
/* date_add(date, interval 값 Type) */
select date_add(now(), interval 1 day);		/* 오늘 날짜보다 +1 = 내일날짜 출력 */
select date_add(now(), interval -1 day);		/* 오늘 날짜보다 -1 = 어제날짜 출력 */
select now(),date_add(now(), interval 10 day_hour);		/* 오늘날짜보다 +10시간 이후의 날짜/시간 출력 */
select now(),date_add(now(), interval -10 day_hour);		/* 오늘날짜보다 -10시간 이후의 날짜/시간 출력 */

/* date_sub(date, interval 값 Type) */
select date_sub(now(), interval 1 day);		/* 오늘 날짜보다 -1 = 어제날짜 출력 */
select date_sub(now(), interval -1 day);		/* 오늘 날짜보다 +1 = 내일날짜 출력 */

/* board테이블에 적용하기 */
select wDate, date_add(now(), interval -1 day) from board;		/* 게시글중에서 하루전에 올라온 글만 보여주시오 */
select substring(wDate,1,10), substring(date_add(now(), interval -1 day),1,10) from board;
select idx, wDate, date_add(now(), interval -1 day) from board where substring(wDate,1,10) = substring(date_add(now(), interval -1 day),1,10);
select idx, wDate, now() from board where wDate >= date_add(now(), interval -24 day_hour);		/* 게시글중 24시간 전에 올라온 글에대해서만 보여주시오 */
select * from board where wDate >= date_add(now(), interval -24 day_hour);
select idx, wDate, date_add(now(), interval -24 day_hour), now(), (wDate - date_add(now(), interval -24 day_hour)) from board;

/* 날짜차이 계산 : DATEDIFF(시작날짜, 마지막날짜) */
select datediff('2023-05-04', '2023-05-01');
select datediff(now(), '2023-05-01');
select idx, datediff(now(), wDate) from board;
select idx, datediff(now(), wDate) as day_diff from board;

select timestampdiff(hour, now(), '2023-05-04');
select timestampdiff(hour, '2023-05-04', now());
select timestampdiff(hour, wDate, now()) from board;
select timestampdiff(hour, wDate, now()) as hour_diff from board;
select *,timestampdiff(hour, wDate, now()) as hour_diff from board order by idx desc;
select *,timestampdiff(hour, wDate, now()) as hour_diff from board order by idx desc limit 0,5;
select *,datediff(wDate, now()) as day_diff,timestampdiff(hour, wDate, now()) as hour_diff from board order by idx desc limit 0,5;
select timestampdiff(day, '2023-05-01', now());

/* 날짜양식(date_format()) : 4자리년도(%Y), 월(%m), 일(%d) */
select wDate, date_format(wDate, '%Y-%m-%d %H:%i') from board;
select *,date_format(wDate, '%Y-%m-%d'),date_format(wDate, '%H:%i'),timestampdiff(hour, wDate, now()) as hour_diff from board;
select *,date_format(wDate, '%Y-%m-%d') as day_format, date_format(wDate, '%H:%i') as hour_format, timestampdiff(hour, wDate, now()) as hour_diff from board;


-- 이전글 / 다음글 꺼내오기
select * from board;
select idx,title from board where idx < 7 order by idx desc limit 1; -- 이전글
select idx,title from board where idx > 7 limit 1; -- 다음글


-- 게시판 리스트 글제목 옆에 해당 글의 댓글 수 출력

-- 댓글 수 전체 리스트에 출력 연습
-- board테이블 전체 내용 최신순으로 출력
select * from board order by idx desc;

-- board 테이블 고유번호 16번에 해당하는 댓글 테이블의 댓글 수 ?
select count(*) from boardReply where boardIdx = 16;

-- 원본 글 고유번호, 총댓글 갯수(replyCnt) 출력
select boardIdx, count(*) replyCnt from boardReply where boardIdx = 16;

-- 원본 글쓴이 닉네임 추가 / 닉네임 원본글(board)테이블에서 가져오기
select boardIdx, count(*) replyCnt, (select nickName from board where idx = 16) nickName from boardReply where boardIdx = 16;

-- board 테이블 관점 ?
select mid, nickName from board where idx = 16;

-- boardReply 테이블 관점 ?
select *, (select count(*) from boardReply where boardIdx = 16) replyCnt from board where idx = 16;

-- board 테이블 기준으로 처리
-- board 테이블 1페이지 5건 출력 / board 테이블 모든내용 + 현재 게시글 댓글 개수 출력 (최신순)
select *,
(select count(*) from boardReply where boardIdx = b.idx) replyCnt
from board b
order by idx desc
limit 5;



































































