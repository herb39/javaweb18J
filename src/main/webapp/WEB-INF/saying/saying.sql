show tables;

create table saying (
	idx		int	not null auto_increment primary key,	-- 고유번호
	image	varchar(100)	not null,	-- 이미지
	content	text			not null,	-- 내용
	name	varchar(30)		not null	-- 인물
);

desc saying;

insert into saying values (default, 'https://cdn.pixabay.com/photo/2017/03/08/19/53/stone-2127669_1280.png','"아무런 위험을 감수하지 않는다면 더 큰 위험을 감수하게 될 것이다."','- Erica Jong');



