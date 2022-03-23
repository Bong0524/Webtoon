--사용자 정보
create table web_User(
	id varchar2(20) not null primary key,
	pw varchar2(20) not null,
	name varchar2(20) not null,
	grade varchar2(10) default 'User'
)
select * from web_user where not grade = 'Admin'
insert into web_User values('damun','1234','다문화','User')
insert into web_User values('nahae','1234','나해남','Writer')
insert into web_User values('admin','1234','나관리','Admin')
insert into web_User values('uuser','1234','이회원','User')
insert into web_User values('hong','1234','홍회원','User')
select * from WEB_USER;
update web_user set pw = '1234', name = '나관리' where id = 'admin'
delete from web_User where id = 'nagum'
update web_User set grade = 'Admin' where id = 'admin'
update web_user set grade = 'Writer' where id = 'jaka'
update web_User set grade = 'User' where id = 'hong' or id = 'uuser'
--웹툰 정보
drop table web_webtoon;
create table web_webtoon(
	toon_id varchar2(20) not null primary key,
	writer varchar2(20) not null,
	title varchar2(100) not null,
	thumbnail varchar2(100) not null,
	info varchar2(1000) not null
)

insert into WEB_WEBTOON values('cyber','nagum','사이버범죄수사단','img/cyber/thumbnail.jpg',
'여러분들이 겪으실 수 있는 사이버범죄에 대한 유형들을 이해하기 쉽도록 만화형태로 만들어봤습니다. 사이버수사과 웹툰을 통해 국민 모두가 이러한 사이버범죄에 당하지 않도록 바래봅니다^^
출처: https://cybercid.spo.go.kr/entry/사이버범죄수사단-웹툰-1회?category=446065 [대검찰청 과학수사부 사이버수사과입니다.]');
insert into WEB_WEBTOON values('haenam','nahae','해남일기','img/haenam/thumbnail.jpg',
'해남에서 첫 사회생활을 하게 된 땅끝군! 첫 시작, 첫 직장, 새내기 직딩이라 아직은 모든게 낯설기만 한데..');
select * from web_webtoon where toon_id = 'buch';
delete from web_webtoon where writer = 'jaka'
delete from web_toonpage where toon_id = 'buch'
--웹툰 한화 정보
drop table web_toonpage;
create table web_toonpage(
	page_id varchar2(10) not null primary key,
	page_num number not null,
	toon_id varchar2(20) not null,
	title varchar2(100) not null,
	view_cnt number default 0,
	wrdate date default sysdate
)


select page_num from web_toonpage where toon_id = 'jinch' and wrdate > (select wrdate from web_toonpage where page_id = 'jinch_1') 
insert into web_toonpage values('cyber_1',1,'cyber','시작',0,'2022-03-02');
insert into web_toonpage values('haenam_1',1,'haenam','해남시작',0,'2022-03-03');
insert into web_toonpage values('haenam_2',2,'haenam','해남두번째',0,'2022-03-10');
select * from WEB_TOONPAGE;
delete from web_toonpage where toon_id = 'eqw'
delete from web_toonpage where page_num = 111
select * from WEB_TOONPAGE where toon_id = 'jinch' order by wrdate;
select * from web_toonpage where page_id = 'haenam_2'
update web_toonpage set view_cnt = (select view_cnt+1 from web_toonpage where page_id = 'cyber_1') where page_id = 'cyber_1';
--댓글 정보
drop table web_comments 
create table web_comments(
	comm_id number not null primary key,
	writer_id varchar2(20) not null,
	writer_name varchar2(20) not null,
	target varchar2(10) not null,
	comments varchar2(1000) not null,
	wrdate date default sysdate
)
delete web_comments
update web_comments set comments = '삭제된 댓글입니다.' where comm_id = 5

insert into web_comments(comm_id,writer_id,writer_name,target,comments) values((select nvl(max(comm_id)+1,0) from web_comments),?,?,?,?)
insert into web_comments(comm_id,writer_id,writer_name,target,comments) values((select nvl(max(comm_id)+1,0) from web_comments),'uuser','이회원','haenam_1','재밋게 보고가요');
select comm_id,substr(writer_id,1,3) || lpad('*',length(writer_id)-2,'*') as writer_id,writer_name,target,comments,to_char(wrdate,'yyyy-mm-dd hh:mi') as wrdate from web_comments order by sysdate desc;
delete from web_comments where target = 'uuser'
select * from web_comments
--연재신청작 정보
drop table WEB_REQUEST;
create table web_request(
	writer varchar2(20) not null primary key,
	title varchar2(100) not null,
	subTitle varchar2(100) not null,
	info varchar2(1000) not null,
	wrdate date default sysdate
)

insert into web_request(writer,title,info) values('uuser','양육비','ssssss')
delete from web_request where writer = 'hong';
select writer,title,to_char(wrdate,'yyyy-mm-dd hh:mi') as wrdate from web_request order by sysdate desc;
select * from web_request 
delete from web_request where writer = 'nahae' or writer = 'uuser'


select * from web_request

drop table web_banner
create table web_banner(
	banner_id varchar2(20) not null primary key,
	link varchar2(1000),
	position varchar2(10),
	title varchar2(30),
	intro varchar2(1000),
	num number
)

alter table web_banner modify (title varchar2(100));

insert into web_banner(banner_id,link,position,num) values('side1','http://archive.much.go.kr/data/07/folderView.do?jobdirSeq=852&idnbr=2017030127','side',1);
insert into web_banner(banner_id,link,position,num) values('side2','http://archive.much.go.kr/data/07/folderView.do?jobdirSeq=852&idnbr=2017030127','side',2);
insert into web_banner(banner_id,position,num) values('side3', 'side',3);
insert into web_banner values('top1','http://localhost:8081/webtoon/WebtoonPro?toon=cyber','top','사이버','징역펀치',1);
insert into web_banner values('top2','http://localhost:8081/webtoon/WebtoonPro?toon=haenam','top','해남','해남에서 시작하는 생활',2);
insert into web_banner(banner_id,position,num) values('top4', 'top',4);

select * from web_banner;

select link as result from web_banner where banner_id = 'side1'
delete from web_banner where banner_id = 'side4'
select * from web_banner where banner_id =  'side1'
select * from web_banner where position = 'side'
update web_banner set title = '사이버', intro = '정의의 징역펀치!', link = 'http://localhost:8081/webtoon/WebtoonPro?toon=cyber' where banner_id = 'top1'
select * from web_banner where position = 'side' and link is not null
select * from web_webtoon where title like '%사%'

delete from web_comments where target = 'gong_1'

select comm_id,substr(writer_id,1,3) || lpad('*',length(writer_id)-2,'*') as writer_id,writer_name,target,comments,to_char(wrdate,'yyyy-mm-dd hh:mi') as wrdate from web_comments where target = 'ssirum_1' order by wrdate desc