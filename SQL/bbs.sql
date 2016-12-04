create database bbs character set utf8 collate utf8_gengeral_ci;

use bbs;

create table article 
(
id int primary key auto_increment,
pid int,
rootid int,
title varchar(1024),
cont text,
pdata datetime,
isleaf int
) character set utf8 collate utf8_gengeral_ci;

insert into article values (null, 0, 1, '蚂蚁战大象', '蚂蚁战大象', now(), 1);
insert into article values (null, 1, 1, '大象被打趴下了', '大象被打趴下了', now(), 1);
insert into article values (null, 2, 1, '蚂蚁也不好过', '蚂蚁也不好过', now(), 0);
insert into article values (null, 2, 1, '瞎说', '瞎说', now(), 1);
insert into article values (null, 4, 1, '没有瞎说', '没有瞎说', now(), 0);
insert into article values (null, 1, 1, '怎么可能', '怎么可能', now(), 1);
insert into article values (null, 6, 1, '怎么没有可能', '怎么没有可能', now(), 0);
insert into article values (null, 6, 1, '可能性是很大的', '可能性是很大的', now(), 0);
insert into article values (null, 2, 1, '大象进医院了', '大象进医院了', now(), 1);
insert into article values (null, 9, 1, '护士是蚂蚁', '护士是蚂蚁', now(), 0);