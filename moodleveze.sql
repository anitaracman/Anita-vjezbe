drop database if exists moodle;
create database moodle;
use moodle;

create table assign (
id bigint(10) not null primary key auto_increment,
course bigint(10) not null,
name varchar (255) not null,
intro Longtext,
introformat smallint(4) not null,
alwaysshowdescription TINYINT(2) not null,
nosubmissions tinyint(2) not null,
submissiondrafts TINYINT(2) not null,
sendnotifications TINYINT(2) not null,
sendlatenotifications TINYINT(2) not null,
duedate BIGINT(10) not null,
allowsubmissionsfromdate BIGINT(10) not null,
grade BIGINT(10) not null,
timemodified BIGINT(10) not null,
requiresubmissionstatement TINYINT(2) not null,
completionsubmit TINYINT(2) not null,
cutoffdate BIGINT(10) not null,
teamsubmission TINYINT(2) not null,
requireallteammemberssubmit TINYINT(2) not null,
teamsubmissiongroupingid BIGINT(10) not null,
blindmarking TINYINT(2) not null,
revealidentites TINYINT(2) not null,
attemptreopenmethod VARCHAR(10) not null,
maxattempts bigint(6) not null,
markingworkflow TINYINT(2) not null,
markingallocation TINYINT(2) not null,
sendstudentnotifications TINYINT(2) not null

);

create table assign_plugin_config (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
plugin varchar(28) not null,
subtype varchar(28) not null,
naame  varchar(28) not null,
value longtext
);



create table assignsubmission_file (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
submission BIGINT(10) not null,
numfiles BIGINT(10) not null
);

create table assign_submission (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
userid BIGINT(10) not null,
timecreated BIGINT(10) not null,
timemodified BIGINT(10) not null,
status varchar(10),
groupid BIGINT(10) not null,
attemptnumber BIGINT(10) not null
);


create table assignsubmission_onlinetext (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
submission BIGINT(10) not null,
onlinetext longtext,
onlineformat SMALLINT(4) not null
);

create table assign_user_flags (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
userid BIGINT(10) not null,
locked BIGINT(10) not null,
mailed SMALLINT(4) not null,
workflowstate  varchar(20),
extensionduedate BIGINT(10) not null,
allocatedmarker BIGINT(10) not null
);

create table assignfeedback_file (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
grade BIGINT(10) not null,
numfiles BIGINT(10) not null
);

create table assignfeedback_editpdf_quick (
id bigint(10) not null primary key auto_increment,
usser BIGINT(10) not null,
rawtext LONGTEXT,
width BIGINT(10) not null,
color VARCHAR(10)
);


create table assignfeedback_comments (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
grade BIGINT(10) not null,
commenttext LONGTEXT,
commentformat SMALLINT(4)
);


create table assignfeedback_editpdf_annot (
id bigint(10) not null primary key auto_increment,
gradeid BIGINT(10) not null,
pageno BIGINT(10) not null,
x BIGINT(10),
y BIGINT(10),
endx BIGINT(10),
endy BIGINT(10),
path LONGTEXT,
type VARCHAR(10),
colour VARCHAR(10),
draft TINYINT(2) not null
);


create table assign_user_mapping (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
userid BIGINT(10) not null
);

create table assign_grades (
id bigint(10) not null primary key auto_increment,
assignment BIGINT(10) not null,
userid BIGINT(10) not null,
timecreated BIGINT(10) not null,
timemodified BIGINT(10) not null,
grader BIGINT(10) not null,
grade DECIMAL(10,5),
attemptnumber BIGINT(10) not null
);

create table assignfeedback_editpdf_cmnt (
id bigint(10) not null primary key auto_increment,
gradeid BIGINT(10) not null,
x BIGINT(10),
y BIGINT(10),
width BIGINT(10),
rawtext longtext,
pageno BIGINT(10) not null,
colour VARCHAR(10),
draft TINYINT(2) not NULL
);


alter table assign_plugin_config add foreign key (assignment) references assign(id);
alter table assignsubmission_file add foreign key (assignment) references assign(id);

alter table assign_submission add foreign key (assignment) references assign(id);

alter table assignsubmission_onlinetext add foreign key (assignment) references assign(id);
alter table assignsubmission_onlinetext add foreign key (submission) references assign_submission(id);


alter table assignsubmission_file add foreign key (submission) references assign_submission(id);

alter table assign_user_flags add foreign key (assignment) references assign(id);

alter table assignfeedback_file add foreign key (assignment) references assign(id);
alter table assignfeedback_file add foreign key (grade) references assign_grades(id);

alter table assignfeedback_comments add foreign key (assignment) references assign(id);
alter table assignfeedback_comments add foreign key (grade) references assign_grades(id);

alter table assignfeedback_editpdf_annot add foreign key (gradeid) references assign_grades(id);


alter table assign_user_mapping add foreign key (assignment) references assign(id);

alter table assign_grades add foreign key (assignment) references assign(id);

alter table assignfeedback_editpdf_cmnt add foreign key (gradeid) references assign_grades(id);