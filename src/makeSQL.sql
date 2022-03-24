--사용자 정보
create table web_User(
	id varchar2(20) not null primary key,
	pw varchar2(20) not null,
	name varchar2(20) not null,
	grade varchar2(10) default 'User'
)
insert into web_User values('admin','1234','나관리','Admin')
select * from web_user

--웹툰 정보
create table web_webtoon(
	toon_id varchar2(20) not null primary key,
	writer varchar2(20) not null,
	title varchar2(100) not null,
	thumbnail varchar2(100) not null,
	info varchar2(1000) not null
)
select * from web_webtoon
--웹툰 한화 정보
drop table web_toonpage;
create table web_toonpage(
	page_id varchar2(20) not null primary key,
	page_num number not null,
	toon_id varchar2(20) not null,
	title varchar2(100) not null,
	view_cnt number default 0,
	wrdate date default sysdate
)
select * from web_toonpage;

select page_num from web_toonpage where toon_id = 'jinch' and wrdate > (select wrdate from web_toonpage where page_id = 'jinch_1') 
update web_toonpage set view_cnt = (select view_cnt+1 from web_toonpage where page_id = 'cyber_1') where page_id = 'cyber_1';

--댓글 정보
create table web_comments(
	comm_id number not null primary key,
	writer_id varchar2(20) not null,
	writer_name varchar2(20) not null,
	target varchar2(20) not null,
	comments varchar2(1000) not null,
	wrdate date default sysdate
)
select * from web_comments

insert into web_comments(comm_id,writer_id,writer_name,target,comments) values((select nvl(max(comm_id)+1,0) from web_comments),'uuser','이회원','haenam_1','재밋게 보고가요');
select comm_id,substr(writer_id,1,3) || lpad('*',length(writer_id)-2,'*') as writer_id,writer_name,target,comments,to_char(wrdate,'yyyy-mm-dd hh:mi') as wrdate from web_comments where target = 'ssirum_1' order by wrdate desc

--연재신청작 정보
create table web_request(
	writer varchar2(20) not null primary key,
	title varchar2(100) not null,
	subTitle varchar2(100) not null,
	info varchar2(1000) not null,
	wrdate date default sysdate
)

select writer,title,to_char(wrdate,'yyyy-mm-dd hh:mi') as wrdate from web_request order by sysdate desc;
select * from web_request 

--배너
create table web_banner(
	banner_id varchar2(20) not null primary key,
	link varchar2(1000),
	position varchar2(10),
	title varchar2(100),
	intro varchar2(1000),
	num number
)

insert into web_banner(banner_id,position,num) values('side1', 'side',1);
insert into web_banner(banner_id,position,num) values('side2', 'side',2);
insert into web_banner(banner_id,position,num) values('side3', 'side',3);
insert into web_banner(banner_id,position,num) values('top1', 'top',1);
insert into web_banner(banner_id,position,num) values('top2', 'top',2);
insert into web_banner(banner_id,position,num) values('top3', 'top',3);
insert into web_banner(banner_id,position,num) values('top4', 'top',4);

select * from web_banner;

select * from web_banner where position = 'side' and link is not null


--별점
drop table web_score
create table web_score(
	score number(4,2) not null,
	target varchar2(20) not null,
	id varchar2(20) not null,
	constraint score_pk primary key(id,target)
)
select * from web_score 
insert into web_score values(9,'jinch_1','admin');
insert into web_score values(7,'jinch_1','jaka');
select count(target) as cnt,nvl(avg(score),0) as score from web_score where target = 'jinch_1'
select count(target) as did from web_score where target = 'jinch_1' and id = 'admin'

select t.*, nvl(round(avg(s.score),2),0) as score from web_toonpage t join web_score s on t.page_id = s.target(+) where toon_id = 'jinch' group by page_id,page_num,toon_id,title,view_cnt,wrdate

select t.*, nvl(round(avg(s.score),2),0) as score from web_toonpage t join web_score s on t.page_id = s.target(+) where page_id = 'jinch_1' group by page_id,page_num,toon_id,title,view_cnt,wrdate order by wrdate desc

select score from web_score where target = 'jinch_1' and id = 'admin'




