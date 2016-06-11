/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.1.13-MariaDB : Database - excelcia
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`excelcia` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `excelcia`;

/*Table structure for table `examquestion` */

DROP TABLE IF EXISTS `examquestion`;

CREATE TABLE `examquestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `topicid` int(11) NOT NULL COMMENT 'for reviewtopic foreign key',
  `subjid` int(11) NOT NULL COMMENT 'for studyunits foreign key',
  `level` varchar(50) NOT NULL COMMENT 'level of difficulty (easy,medium,difficult)',
  `question` varchar(500) NOT NULL COMMENT 'actual question',
  `a` varchar(100) NOT NULL COMMENT 'A choice',
  `b` varchar(100) NOT NULL COMMENT 'B choice',
  `c` varchar(100) NOT NULL COMMENT 'C choice',
  `d` varchar(100) NOT NULL COMMENT 'D choice',
  `a_rational` varchar(500) NOT NULL COMMENT 'rationale for choice A',
  `b_rational` varchar(500) NOT NULL COMMENT 'rationale for choice B',
  `c_rational` varchar(500) NOT NULL COMMENT 'rationale for choice C',
  `d_rational` varchar(500) NOT NULL COMMENT 'rationale for choice D',
  `correct_ans` varchar(100) NOT NULL COMMENT 'correct answer for the question',
  `minutes` int(10) unsigned NOT NULL COMMENT 'minutes for question',
  `point` int(11) NOT NULL COMMENT 'point for question',
  `type` int(100) NOT NULL COMMENT 'test type of question',
  PRIMARY KEY (`id`),
  KEY `topicid` (`topicid`),
  KEY `subjid` (`subjid`),
  CONSTRAINT `examquestion_ibfk_1` FOREIGN KEY (`topicid`) REFERENCES `reviewtopic` (`id`),
  CONSTRAINT `examquestion_ibfk_2` FOREIGN KEY (`subjid`) REFERENCES `studyunits` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;

/*Data for the table `examquestion` */

insert  into `examquestion`(`id`,`topicid`,`subjid`,`level`,`question`,`a`,`b`,`c`,`d`,`a_rational`,`b_rational`,`c_rational`,`d_rational`,`correct_ans`,`minutes`,`point`,`type`) values (1,1,2,'EASY','the machine that changed the world','a.) Colossus','b.) SmartPhone','c.) Computer','d.) All the above','a.) Colossus','b.) SmartPhone','c.) Computer','d.) All the above','c',1,1,1),(2,1,2,'EASY','names whom contributed for the development of computers','a.) C.Babbage / T.Flowers / K. Warwick / Jeremy','b.) A. Turing / C.Babbage / Jeremy','c.) T.Flowers / A.Turing / K. Warwick / C. Babbage','d.) all of the above.','a.) C.Babbage / T.Flowers / K. Warwick / Jeremy','b.) A. Turing / C.Babbage / Jeremy','c.) T.Flowers / A.Turing / K. Warwick / C. Babbage','d.) all of the above.','c',1,1,1),(3,1,3,'EASY','father of computer','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','a',1,1,1),(4,1,3,'EASY','father of computer science','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','b',1,1,1),(5,1,4,'EASY','he developed colossus.','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','d',2,1,1),(6,1,4,'EASY','dr. artificial intelligent / robotics, that got a microhip implant, w/c intends to remotely control a robotic arm','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','a.) Charles Babbage','b.) Alan Turing','c.) Kevin Warwick','d.) none of the above','c',2,1,1),(7,1,5,'EASY','would be use to destroy computer/AI','a.) Electro-Magnetic-Interference','b.) Electro-Magnetic-Pulse','c.) Nuclear bom','d.) both A & B','a.) Electro-Magnetic-Interference','b.) Electro-Magnetic-Pulse','c.) Nuclear bom','d.) both A & B','d',2,1,1),(8,1,5,'EASY','composed of electronic valves and wires (a machine that is as big enough to occupy the entire building floor)','a.) desktop computer','b.) mainframe computer','c.) Colossus','d.) all of the above','a.) desktop computer','b.) mainframe computer','c.) Colossus','d.) all of the above','c',2,1,1),(9,1,5,'EASY','miniturized electronic component (a complex electronic part composed of several thousand of colossus circuits)','a.) integrated circuits','b.) silicon chips','c.) microchips','d.) all of the above','a.) integrated circuits','b.) silicon chips','c.) microchips','d.) all of the above','d',1,1,1),(10,1,2,'MEDIUM','a man made machine capable to automate human task','a.) desktop computer','b.) mainframe computer','c.) Colossus','d.) all of the above','a.) desktop computer','b.) mainframe computer','c.) Colossus','d.) all of the above','d',1,1,1),(11,1,2,'MEDIUM','refers to the physical tangible computer itself (an element of a complete computer system)','a.) people ware','b.) software','c.) hardware','d.) all of the above','a.) people ware','b.) software','c.) hardware','d.) all of the above','c',1,1,1),(12,1,3,'MEDIUM','refers to the programs/system/machine instructions that is made by programmers.','a.) people ware','b.) software','c.) hardware','d.) all of the above','a.) people ware','b.) software','c.) hardware','d.) all of the above','b',1,1,1),(13,1,3,'MEDIUM','refers to user/coders/programmers/computer operators (an element of a complete computer system)','a.) people ware','b.) software','c.) hardware','d.) all of the above','a.) people ware','b.) software','c.) hardware','d.) all of the above','a',1,1,1),(14,1,4,'MEDIUM','smallest unit of measurement use to measure; capacity to hold information or data, capacity to process, and etc.','a.) byte','b.) bit','c.) kilobyte','d. all of the above','a.) byte','b.) bit','c.) kilobyte','d. all of the above','b',3,1,1),(15,1,4,'MEDIUM','if I have 3bytes how many characters do I have?','a.) 18','b.) 24','c.) 36','d.) none of the above','a.) 18','b.) 24','c.) 36','d.) none of the above','d',3,1,1),(16,1,5,'MEDIUM','volatile memory of a computer','a.) RAM','b.) ROM','c.) BIOS','d.) CMOS','a.) RAM','b.) ROM','c.) BIOS','d.) CMOS','a',3,1,1),(17,1,5,'MEDIUM','a memory type used to hold the configuration/settings of the computer (including system date & time)','a.) RAM','b.) ROM','c.) BIOS','d.) CMOS','a.) RAM','b.) ROM','c.) BIOS','d.) CMOS','b',4,1,1),(18,1,2,'MEDIUM','a collection of programs &/or modules that is combined all together to accomplish and/or automate human tasks','a.) system','b.) program','c.) machine instructions','d.) all of the above','a.) system','b.) program','c.) machine instructions','d.) all of the above','a',4,1,1),(19,1,2,'MEDIUM','a collection of commands written by a programmer to accomplish specific task','a.) system','b.) program','c.) machine instructions','d.) all of the above','a.) system','b.) program','c.) machine instructions','d.) all of the above','b',1,1,1),(20,1,2,'DIFFICULT','if i have 2 characters how many bytes do i have','a.) 8','b.) 16','c.) 2','d.) none of the above','a.) 8','b.) 16','c.) 2','d.) none of the above','c',1,1,1),(21,1,2,'DIFFICULT','keyboard is what type of device?','a.) input','b.) output','c.) input & output','d.) unknown','a.) input','b.) output','c.) input & output','d.) unknown','a',1,1,1),(22,1,3,'DIFFICULT','mouse is what type of device?','a.) input','b.) output','c.) input & output','d.) unknown','a.) input','b.) output','c.) input & output','d.) unknown','a',1,1,1),(23,1,3,'DIFFICULT','speaker is what type of device?','a.) input','b.) output','c.) input & output','d.) unknown','a.) input','b.) output','c.) input & output','d.) unknown','b',2,1,1),(24,2,4,'DIFFICULT','RFID tag reader is what type of device?','a.) input','b.) output','c.) input & output','d.) unknown','a.) input','b.) output','c.) input & output','d.) unknown','a',2,1,2),(25,2,4,'DIFFICULT','printer is what type of device?','a.) input','b.) output','c.) input & output','d.) unknown','a.) input','b.) output','c.) input & output','d.) unknown','b',2,1,2),(26,2,5,'DIFFICULT','momentary storage of a computer','a.) RAM','b.) ROM','c.) BIOS','d.) CMOS','a.) RAM','b.) ROM','c.) BIOS','d.) CMOS','a',2,1,2),(27,1,5,'DIFFICULT','the particular computer memory which contains the configuration/settings of a computer','a.) RAM','b.) ROM','c.) BIOS','d.) both b & c','a.) RAM','b.) ROM','c.) BIOS','d.) both b & c','d',1,1,1),(28,1,3,'DIFFICULT','if i have 24bits how many characters do i have.','a.) 24','b.) 12','c.) 3','d.) none of the above','a.) 24','b.) 12','c.) 3','d.) none of the above','c',1,1,1),(29,1,3,'DIFFICULT','this controls the basic i/o processing of a computer','a.) RAM','b.) ROM','c.) BIOS','d.) none of the above','a.) RAM','b.) ROM','c.) BIOS','d.) none of the above','c',1,1,1),(30,2,7,'5','raw facts, events or happening. this is processed in order to provide an information','a.) data','b.) information','c.) IS','d.) none of the above','a.) data','b.) information','c.) IS','d.) none of the above','a',1,1,2),(31,2,7,'1','a collection of facts organized in such a way that they have additional value beyond the facts themselves.','a.) data','b.) information','c.) IS','d.) none of the above','a.) data','b.) information','c.) IS','d.) none of the above','b',1,1,2),(32,2,7,'2','typically considered to be a set of interrelated elements or components that collect (input), manipulate(processes), and dissiminate(output) and information and provide a feedback mechanism to meet an objective.','a.) data','b.) information','c.) IS','d.) none of the above','a.) data','b.) information','c.) IS','d.) none of the above','c',3,1,2),(33,2,7,'3','provides information and supports needed for effective decision making by managers','a.) MIS','b.) DSS','c.) ES','d.) none of the above','a.) MIS','b.) DSS','c.) ES','d.) none of the above','d',3,1,2),(34,2,8,'4','automate office procedures and enhance office communications and productivity','a.) MIS','b.) DSS','c.) ES','d.) none of the above','a.) MIS','b.) DSS','c.) ES','d.) none of the above','d',3,1,2),(35,2,8,'5','Provide critical information tailored to the information needs of executives.','a.) MIS','b.) DSS','c.) ESS','d.) none of the above','a.) MIS','b.) DSS','c.) ESS','d.) none of the above','c',4,1,2),(36,2,8,'1','a SAD model of development that is linear and sequential.','a.) SCRUM','b.) AGILE','c.) WaterFall','d.) none of the above','a.) SCRUM','b.) AGILE','c.) WaterFall','d.) none of the above','c',4,1,2),(37,2,8,'2','is a time boxed, iteractive approach to software development that builds software incrementally from the start of the project, instead of trying to deliver it all at once near the end.','a.) SCRUM','b.) AGILE','c.) WaterFall','d.) none of the above','a.) SCRUM','b.) AGILE','c.) WaterFall','d.) none of the above','b',1,1,2),(38,2,8,'3','A shared collection of logically related data designed to meet the information needs of multiple users in organization.','a.) database','b.) document','c.) information','d.) none of the above','a.) database','b.) document','c.) information','d.) none of the above','a',1,1,2),(39,2,7,'4','are computerized information systems that were developed to process large amounts of data for routine business transaction.','a.) ESS','b.) TPS','c.) MIS','d.) none of the above','a.) ESS','b.) TPS','c.) MIS','d.) none of the above','b',1,1,2),(40,2,7,'5','the one who studies the problems and needs of an organization to determine how people, data, processes, communications, and information technology can best accomplish improvements for the business.','a.) programmer','b.) encoder','c.) system analyst','d.) none of the above','a.) programmer','b.) encoder','c.) system analyst','d.) none of the above','c',1,1,2),(41,2,7,'1','Organized collection of people, procedures, software, databases, and devices used to record completed business transactions','a.) ESS','b.) MIS','c.) TPS','d.) none of the above','a.) ESS','b.) MIS','c.) TPS','d.) none of the above','d',2,1,2),(42,2,7,'2','Computer system takes on characteristics of human intelligence','a.) DSS','b.) MIS','c.) TPS','d.) all of the above','a.) DSS','b.) MIS','c.) TPS','d.) all of the above','d',2,1,2),(43,2,7,'3','a graphical representation of the \"flow\" of data through an information system, modelling its process aspects.','a.) System Flow','b.) Data Flow Diagram','c.) System Flowchart','d.) none of the above','a.) System Flow','b.) Data Flow Diagram','c.) System Flowchart','d.) none of the above','b',2,1,2),(44,2,7,'4','symbol used to represent data that the system stores.','a.) Process','b.) External Entity','c.) Data Flow','d.) None of the above','a.) Process','b.) External Entity','c.) Data Flow','d.) None of the above','d',2,1,2),(45,2,8,'5','performs some action on data, such as creates, modifies, stores, delete, etc. (either manual or supported by a computer)','a.) Process','b.) External Entity','c.) Data Flow','d.) None of the above','a.) Process','b.) External Entity','c.) Data Flow','d.) None of the above','b',1,1,2),(46,2,8,'1','a type of computer network which intends to connect one town to another town of a different region.','a.) LAN','b.) MAN','c.) WAN','d.) none of the above','a.) LAN','b.) MAN','c.) WAN','d.) none of the above','c',1,1,2),(47,2,8,'2','a computer program created intentionally to disrupt the normal operation of a computer','a.) System','b.) information System','c.) Virus','d.) none of the above','a.) System','b.) information System','c.) Virus','d.) none of the above','c',1,1,2),(48,2,8,'3','a problem solving technique that decomposes a system into its component pieces for the purpose of the studying how well those component parts work and interact to accomplish their purpose.','a.) system programming','b.) system designing','c.) system planning','d.) system analysis','a.) system programming','b.) system designing','c.) system planning','d.) system analysis','d',1,1,2),(49,2,7,'4','a conceptual model used in project management that describes the stages involved in an information system development project, from an initial feasibility study through maintenance of the completed application.','a.) SDLC','b.) Waterfall','c.) Agile','d.) SCRUM','a.) SDLC','b.) Waterfall','c.) Agile','d.) SCRUM','a',1,1,2),(50,2,7,'5','a collection of descriptions of the data objects or items in a data model for the benefit of programmers and others who need to refer to them','a.) Information','b.) Data dictionary','c.) Data Processing','d.) none of the above','a.) Information','b.) Data dictionary','c.) Data Processing','d.) none of the above','b',3,1,2),(51,2,7,'1','which is none element of a complete computer system','a.) people ware','b.) Hardware','c.) Anti Virus','d.) none of the above','a.) people ware','b.) Hardware','c.) Anti Virus','d.) none of the above','c',3,1,2),(52,2,7,'2','none basic hardware element','a.) external hard drive or flash drive','b.) Monitor/Display','c.) CPU / Central Processing Unit','d.) none of the above','a.) external hard drive or flash drive','b.) Monitor/Display','c.) CPU / Central Processing Unit','d.) none of the above','a',3,1,2),(53,2,7,'3','it is an electronic device that uses stored data and instruction to generate information','a.) calculator','b.) smartphone','c.) computer','d.) all of the above','a.) calculator','b.) smartphone','c.) computer','d.) all of the above','c',4,1,2),(54,2,7,'4','it refers to processed data','a.) input','b.) output','c.) data','d.) none of the above','a.) input','b.) output','c.) data','d.) none of the above','d',4,1,2),(55,2,7,'5','it is the unprocessed facts','a.) input','b.) output','c.) data','d.) none of the above','a.) input','b.) output','c.) data','d.) none of the above','c',1,1,2),(56,2,8,'1','an electronic machine that has memory and can manipulate data and it has arithmetic and logic function','a.) calculator','b.) smartphone','c.) computer ','d.) all of the above','a.) calculator','b.) smartphone','c.) computer ','d.) all of the above','c',1,1,2),(57,2,8,'2','a computing device popularized by chinese as their early calculator','a.) abacus','b.) smartphone','c.) napiers bone','d.) none of the above','a.) abacus','b.) smartphone','c.) napiers bone','d.) none of the above','a',1,1,2),(58,2,8,'3','basic components of computer system','a.) monitor / keyboard / cpu','b.) monitor / keyboard / cpu / mouse / avr','c.) monitor / keyboard / cpu / webcam / speaker / avr','d.) none of the above','a.) monitor / keyboard / cpu','b.) monitor / keyboard / cpu / mouse / avr','c.) monitor / keyboard / cpu / webcam / speaker / avr','d.) none of the above','d',1,1,2),(59,2,8,'4','basic computer hardware components','a.) monitor / keyboard / cpu','b.) monitor / keyboard / cpu / mouse / avr','c.) monitor / keyboard / cpu / webcam / speakers','d.) none of the above','a.) monitor / keyboard / cpu','b.) monitor / keyboard / cpu / mouse / avr','c.) monitor / keyboard / cpu / webcam / speakers','d.) none of the above','a',2,1,2),(60,2,8,'5','this refers to the physical components of the computer','a.) people ware','b.) software','c.) hardware','d.) none of the above','a.) people ware','b.) software','c.) hardware','d.) none of the above','c',2,1,2),(61,2,8,'1','this is considered to be the brain of a computer','a.) input/output device','b.) internal storage','c.) processor','d.) none of the above','a.) input/output device','b.) internal storage','c.) processor','d.) none of the above','c',2,1,2),(62,2,8,'2','nonvolatile memory of a computer','a.) Read Only Memory (ROM)','b.) Random Access Memory (RAM)','c.) both A & B','d.) none of the above','a.) Read Only Memory (ROM)','b.) Random Access Memory (RAM)','c.) both A & B','d.) none of the above','a',2,1,2),(63,2,8,'3','this is known to be the device which can accept instructions from computer user','a.) input device','b.) output device','c.) both A & B','d.) none of the above','a.) input device','b.) output device','c.) both A & B','d.) none of the above','a',1,1,2),(64,2,7,'4','this is known to return data, that is, information back to the user','a.) input device','b.) output device','c.) both A & B','d.) none of the above','a.) input device','b.) output device','c.) both A & B','d.) none of the above','b',1,1,2),(65,1,4,'5','this is known to be an optical storage which can hold 600MB to 720MB of data','a.) CD Disc','b.) DVD Disc','c.) Bluray','d.) none of the above','a.) CD Disc','b.) DVD Disc','c.) Bluray','d.) none of the above','a',1,1,1),(66,1,5,'1','this refers to the set of instructions written in code that computers can understand and executed','a.) System','b.) software','c.) programs','d.) none / all of the above','a.) System','b.) software','c.) programs','d.) none / all of the above','b',1,1,1),(67,1,2,'2','a software which contains programs that perform task needed for computer hardware to function efficiently. ','a.) system software / operating system','b.) microsoft windows','c.) IOS','d.) none / all of the above','a.) system software / operating system','b.) microsoft windows','c.) IOS','d.) none / all of the above','a',1,1,1),(68,1,2,'3','a software that is used to govern the proper operation of a computer','a.) system software / operating system','b.) microsoft windows','c.) IOS','d.) none / all of the above','a.) system software / operating system','b.) microsoft windows','c.) IOS','d.) none / all of the above','a',3,1,1),(69,1,3,'4','refers to any person involve in the software development and maintenance of the hardware','a.) hardware','b.) software','c.) peopleware','d.) none / all of the above','a.) hardware','b.) software','c.) peopleware','d.) none / all of the above','c',3,1,1),(70,1,3,'5','is an interrelated set of components that function together to achieve an outcome','a.) program','b.) system','c.) module','d.) none of the above','a.) program','b.) system','c.) module','d.) none of the above','b',3,1,1);

/*Table structure for table `examresulthistory` */

DROP TABLE IF EXISTS `examresulthistory`;

CREATE TABLE `examresulthistory` (
  `id` int(11) DEFAULT NULL COMMENT 'main id',
  `studentid` int(11) DEFAULT NULL COMMENT 'personalinfo foreign key',
  `examid` int(11) DEFAULT NULL COMMENT 'summary foreign key',
  `studyid` int(11) DEFAULT NULL COMMENT 'studyunit foreign key',
  `answer` varchar(5) DEFAULT NULL COMMENT 'answer of student',
  `remark` varchar(50) DEFAULT NULL COMMENT 'remarks',
  `pt` tinyint(4) DEFAULT NULL COMMENT 'point per question',
  `status` tinyint(4) DEFAULT NULL COMMENT 'status if complete/incomplete'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `examresulthistory` */

/*Table structure for table `personalinfo` */

DROP TABLE IF EXISTS `personalinfo`;

CREATE TABLE `personalinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lname` varchar(100) NOT NULL,
  `mname` varchar(100) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `contactno` varchar(100) NOT NULL,
  `emailadd` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `usertype` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `personalinfo` */

insert  into `personalinfo`(`id`,`lname`,`mname`,`fname`,`address`,`contactno`,`emailadd`,`username`,`password`,`usertype`,`status`) values (1,'dean','salansang','alan','taytay','123','email@ko.com','alan','alan','admin','1'),(2,'manalastas','edd','edd','angono','321','email@edd.com','edd','edd','admin','1');

/*Table structure for table `reviewmaterials` */

DROP TABLE IF EXISTS `reviewmaterials`;

CREATE TABLE `reviewmaterials` (
  `id` int(11) NOT NULL,
  `studyid` int(11) NOT NULL,
  `reviewid` int(11) NOT NULL,
  `attachment` varchar(500) NOT NULL,
  `filetype` varchar(100) NOT NULL,
  `extname` varchar(100) NOT NULL,
  `dateupload` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reviewmaterials` */

/*Table structure for table `reviewresult` */

DROP TABLE IF EXISTS `reviewresult`;

CREATE TABLE `reviewresult` (
  `id` int(11) DEFAULT NULL,
  `reviewid` int(11) DEFAULT NULL,
  `rating` decimal(18,2) DEFAULT NULL,
  `datetimestarted` datetime DEFAULT NULL,
  `datetimeend` datetime DEFAULT NULL,
  `examresultlogid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reviewresult` */

/*Table structure for table `reviewsession` */

DROP TABLE IF EXISTS `reviewsession`;

CREATE TABLE `reviewsession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionName` varchar(200) NOT NULL,
  `decription` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reviewsession` */

/*Table structure for table `reviewtopic` */

DROP TABLE IF EXISTS `reviewtopic`;

CREATE TABLE `reviewtopic` (
  `id` int(11) NOT NULL,
  `topicname` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reviewtopic` */

insert  into `reviewtopic`(`id`,`topicname`,`description`) values (1,'Pre-Test',''),(2,'Post-Test','');

/*Table structure for table `studentsession` */

DROP TABLE IF EXISTS `studentsession`;

CREATE TABLE `studentsession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) NOT NULL,
  `questionid` int(11) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `datetimecreated` datetime NOT NULL,
  `datetimeanswered` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionid` (`questionid`),
  KEY `studentid` (`studentid`),
  CONSTRAINT `studentsession_ibfk_1` FOREIGN KEY (`questionid`) REFERENCES `examquestion` (`id`),
  CONSTRAINT `studentsession_ibfk_2` FOREIGN KEY (`studentid`) REFERENCES `personalinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `studentsession` */

insert  into `studentsession`(`id`,`studentid`,`questionid`,`answer`,`datetimecreated`,`datetimeanswered`) values (1,1,1,'c','2016-06-11 14:29:21','0000-00-00 00:00:00'),(2,1,2,'b','2016-06-11 14:29:21','0000-00-00 00:00:00'),(3,1,3,'a','2016-06-11 14:29:21','0000-00-00 00:00:00'),(4,1,10,'c','2016-06-11 14:29:21','0000-00-00 00:00:00'),(5,1,11,'a','2016-06-11 14:29:21','0000-00-00 00:00:00'),(6,1,12,'c','2016-06-11 14:29:21','0000-00-00 00:00:00'),(7,1,13,'b','2016-06-11 14:29:21','0000-00-00 00:00:00'),(8,1,20,'d','2016-06-11 14:29:21','0000-00-00 00:00:00'),(9,1,21,'a','2016-06-11 14:29:21','0000-00-00 00:00:00'),(10,1,22,'','2016-06-11 14:29:21','0000-00-00 00:00:00');

/*Table structure for table `studentsessionsummary` */

DROP TABLE IF EXISTS `studentsessionsummary`;

CREATE TABLE `studentsessionsummary` (
  `id` int(11) NOT NULL,
  `testsessionid` int(50) NOT NULL,
  `studentid` int(11) NOT NULL,
  `topicid` int(11) NOT NULL,
  `unitid` int(11) NOT NULL,
  `totalpoints` int(11) NOT NULL,
  `studentpoints` int(11) NOT NULL,
  `totaltime` time NOT NULL,
  `studenttime` time NOT NULL,
  `remarks` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `testsessionid` (`testsessionid`),
  CONSTRAINT `studentsessionsummary_ibfk_1` FOREIGN KEY (`testsessionid`) REFERENCES `studentsession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `studentsessionsummary` */

/*Table structure for table `studyunits` */

DROP TABLE IF EXISTS `studyunits`;

CREATE TABLE `studyunits` (
  `id` int(11) NOT NULL,
  `topicid` int(11) NOT NULL,
  `studyname` varchar(100) NOT NULL,
  `isparent` int(11) NOT NULL,
  `parentid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `topicid` (`topicid`),
  CONSTRAINT `studyunits_ibfk_1` FOREIGN KEY (`topicid`) REFERENCES `reviewtopic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `studyunits` */

insert  into `studyunits`(`id`,`topicid`,`studyname`,`isparent`,`parentid`) values (1,1,'Introduction to Accounting',1,0),(2,1,'Day 1 Online Accounting',0,1),(3,1,'Day 2 Describe the nature of Accounting',0,1),(4,1,'Day 3 Explains the fucntion of accounting in business',0,1),(5,1,'Day 4 Narrate the history/Origin of Accounting',0,1),(6,2,'Branches of Accounting',1,0),(7,2,'Day 5 Differentiate the branches of Accounting',0,6),(8,2,'Day 6 Explain the kind/Type of service rendered in each of these branches',0,6);

/*Table structure for table `testbuffer` */

DROP TABLE IF EXISTS `testbuffer`;

CREATE TABLE `testbuffer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'just a record id',
  `testsessionid` int(50) NOT NULL,
  `datetimecreated` datetime NOT NULL,
  `testtype` varchar(15) NOT NULL COMMENT 'pre-test | post-test | short-quiz | long-quiz | major-exam',
  `topicid` int(11) NOT NULL COMMENT 'topic id as defined on examquestion',
  `subjid` int(11) NOT NULL COMMENT 'subject id as defined on examquestion',
  `level` varchar(50) NOT NULL COMMENT 'day or sub topic as defined on examquestion and as shown on student grade report',
  `question` varchar(500) NOT NULL COMMENT 'the actual question from examquestion table',
  `a` varchar(100) NOT NULL COMMENT 'choice a',
  `b` varchar(100) NOT NULL COMMENT 'choice b',
  `c` varchar(100) NOT NULL COMMENT 'choice c',
  `d` varchar(100) NOT NULL COMMENT 'choice d',
  `a_rational` varchar(500) NOT NULL COMMENT 'rationale for choice a',
  `b_rational` varchar(500) NOT NULL COMMENT 'rationale for choice b',
  `c_rational` varchar(500) NOT NULL COMMENT 'rationale for choice c',
  `d_rational` varchar(500) NOT NULL COMMENT 'rationale for choice d',
  `correct_ans` varchar(100) NOT NULL COMMENT 'correct answer as defined on examquestion',
  `ansreceived` varchar(1) NOT NULL COMMENT 'received answer submitted by exam taker',
  `minutes` int(10) unsigned NOT NULL COMMENT 'time duration for this question',
  `point` int(11) NOT NULL COMMENT 'points to be given for this question',
  `type` varchar(100) NOT NULL COMMENT 'easy | moderate | difficult',
  PRIMARY KEY (`id`),
  KEY `testsessionid` (`testsessionid`),
  CONSTRAINT `testbuffer_ibfk_1` FOREIGN KEY (`testsessionid`) REFERENCES `studentsession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `testbuffer` */

/*Table structure for table `testhistory` */

DROP TABLE IF EXISTS `testhistory`;

CREATE TABLE `testhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'just a record id',
  `testsessionid` int(50) NOT NULL,
  `datetimecreated` datetime NOT NULL,
  `testtype` varchar(15) NOT NULL COMMENT 'pre-test | post-test | short-quiz | long-quiz | major-exam',
  `topicid` int(11) NOT NULL COMMENT 'topic id as defined on examquestion',
  `subjid` int(11) NOT NULL COMMENT 'subject id as defined on examquestion',
  `level` varchar(50) NOT NULL COMMENT 'day or sub topic as defined on examquestion and as shown on student grade report',
  `question` varchar(500) NOT NULL COMMENT 'the actual question from examquestion table',
  `a` varchar(100) NOT NULL COMMENT 'choice a',
  `b` varchar(100) NOT NULL COMMENT 'choice b',
  `c` varchar(100) NOT NULL COMMENT 'choice c',
  `d` varchar(100) NOT NULL COMMENT 'choice d',
  `a_rational` varchar(500) NOT NULL COMMENT 'rationale for choice a',
  `b_rational` varchar(500) NOT NULL COMMENT 'rationale for choice b',
  `c_rational` varchar(500) NOT NULL COMMENT 'rationale for choice c',
  `d_rational` varchar(500) NOT NULL COMMENT 'rationale for choice d',
  `correct_ans` varchar(100) NOT NULL COMMENT 'correct answer as defined on examquestion',
  `ansreceived` varchar(1) NOT NULL COMMENT 'received answer submitted by exam taker',
  `minutes` int(10) unsigned NOT NULL COMMENT 'time duration for this question',
  `point` int(11) NOT NULL COMMENT 'points to be given for this question',
  `type` varchar(100) NOT NULL COMMENT 'easy | moderate | difficult',
  PRIMARY KEY (`id`),
  KEY `testsessionid` (`testsessionid`),
  CONSTRAINT `testhistory_ibfk_1` FOREIGN KEY (`testsessionid`) REFERENCES `studentsession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `testhistory` */

/*Table structure for table `topic_config` */

DROP TABLE IF EXISTS `topic_config`;

CREATE TABLE `topic_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `topicID` int(10) NOT NULL,
  `testtype` int(10) NOT NULL,
  `itemseasy` int(10) NOT NULL,
  `itemsmoderate` int(10) NOT NULL,
  `itemsdifficult` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `topicID` (`topicID`),
  CONSTRAINT `topic_config_ibfk_1` FOREIGN KEY (`topicID`) REFERENCES `reviewtopic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='topic configuration to be defined by the teacher or admin';

/*Data for the table `topic_config` */

insert  into `topic_config`(`id`,`topicID`,`testtype`,`itemseasy`,`itemsmoderate`,`itemsdifficult`) values (1,1,1,3,4,3),(2,2,2,4,3,3);

/*Table structure for table `userlogs` */

DROP TABLE IF EXISTS `userlogs`;

CREATE TABLE `userlogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loguserid` int(11) NOT NULL,
  `logdate` date NOT NULL,
  `logdesc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `userlogs` */

insert  into `userlogs`(`id`,`loguserid`,`logdate`,`logdesc`) values (1,0,'2016-05-28','Good Login'),(2,0,'2016-05-28','Good Login'),(3,0,'2016-05-28','Good Login'),(4,2,'2016-05-29','Good Login'),(5,2,'2016-05-29','Good Login'),(6,0,'2016-06-01','Good Login'),(7,0,'2016-06-11','Good Login'),(8,0,'2016-06-11','Good Login');

/* Procedure structure for procedure `1` */

/*!50003 DROP PROCEDURE IF EXISTS  `1` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `1`(in studid int,IN `topid` INT,IN `subid` varchar(50),in _type varchar(50),in toteasy int,in totmed int,in totdiff int)
BEGIN
INSERT INTO studentsession (studentid,questionid,answer,datetimecreated,datetimeanswered)
SELECT studid,U.id,NULL,NOW(),NULL FROM ((SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND FIND_IN_SET(SUBJID, subid) AND LEVEL = 'EASY' AND TYPE = _type LIMIT toteasy) 
UNION
(SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND  FIND_IN_SET(SUBJID, subid) AND LEVEL = 'MEDIUM' AND TYPE = _type LIMIT totmed )
UNION
(SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND FIND_IN_SET(SUBJID, subid) AND LEVEL = 'DIFFICULT' AND TYPE = _type LIMIT totdiff ))
AS U;
 
INSERT  INTO `excelcia`.`testbuffer`
            (`testsessionid`,
             `datetimecreated`,
             `testtype`,
             `topicid`,
             `subjid`,
             `level`,
             `question`,
             `a`,
             `b`,
             `c`,
             `d`,
             `a_rational`,
             `b_rational`,
             `c_rational`,
             `d_rational`,
             `correct_ans`,
             `ansreceived`,
             `minutes`,
             `point`,
             `type`)
             
SELECT ss.id,NOW(),eq.`type`,eq.`topicid`,eq.`subjid`,eq.`level`,eq.`question`,eq.a,eq.b,eq.c,eq.d,eq.`a_rational`,eq.`b_rational`,eq.`c_rational`,
   eq.`d_rational`,eq.`correct_ans`,ss.`answer`,eq.`minutes`,eq.point, eq.`type` FROM studentsession ss
 INNER JOIN examquestion eq ON eq.id = ss.questionid;
 
 select * from testbuffer where studentid = studid and testsessionid = sessionid;
 
 END */$$
DELIMITER ;

/* Procedure structure for procedure `generateQuestions` */

/*!50003 DROP PROCEDURE IF EXISTS  `generateQuestions` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `generateQuestions`(in studid int,IN `topid` INT,IN `subid` varchar(50),in _type int,in toteasy int,in totmed int,in totdiff int)
BEGIN
 
INSERT INTO studentsession (studentid,questionid,answer,datetimecreated,datetimeanswered)
SELECT studid,U.id,NULL,NOW(),NULL FROM ((SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND FIND_IN_SET(SUBJID, subid) AND LEVEL = 'EASY' AND TYPE = _type LIMIT toteasy) 
UNION
(SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND  FIND_IN_SET(SUBJID, subid) AND LEVEL = 'MEDIUM' AND TYPE = _type LIMIT totmed )
UNION
(SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND FIND_IN_SET(SUBJID, subid) AND LEVEL = 'DIFFICULT' AND TYPE = _type LIMIT totdiff ))
AS U where U.id not in (select distinct questionid from studentsession where studentid = studid);
 /*
INSERT  INTO `excelcia`.`testbuffer`
            (`testsessionid`,
             `datetimecreated`,
             `testtype`,
             `topicid`,
             `subjid`,
             `level`,
             `question`,
             `a`,
             `b`,
             `c`,
             `d`,
             `a_rational`,
             `b_rational`,
             `c_rational`,
             `d_rational`,
             `correct_ans`,
             `ansreceived`,
             `minutes`,
             `point`,
             `type`)
             
SELECT ss.id,NOW(),eq.`type`,eq.`topicid`,eq.`subjid`,eq.`level`,eq.`question`,eq.a,eq.b,eq.c,eq.d,eq.`a_rational`,eq.`b_rational`,eq.`c_rational`,
   eq.`d_rational`,eq.`correct_ans`,ss.`answer`,eq.`minutes`,eq.point, eq.`type` FROM studentsession ss
 INNER JOIN examquestion eq ON eq.id = ss.questionid
 where ss.studentid = studid; */
 
 
 END */$$
DELIMITER ;

/* Procedure structure for procedure `getLogin` */

/*!50003 DROP PROCEDURE IF EXISTS  `getLogin` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getLogin`(IN `username` VARCHAR(200), IN `pswrd` VARCHAR(200))
BEGIN
select * from personalinfo where username = lcase(username) and password = lcase(pswrd);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getQuestion` */

/*!50003 DROP PROCEDURE IF EXISTS  `getQuestion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getQuestion`(in sesid int,IN studid INT,IN `topid` INT,IN `subid` VARCHAR(50))
BEGIN
  /*  
SELECT ss.id,ss.studentid,NOW(),eq.`type`,eq.`topicid`,eq.`subjid`,eq.`level`,eq.`question`,eq.a,eq.b,eq.c,eq.d,eq.`a_rational`,eq.`b_rational`,eq.`c_rational`,
   eq.`d_rational`,eq.`correct_ans`,ss.`answer`,eq.`minutes`,eq.point, eq.`type` FROM studentsession ss
 INNER JOIN testbuffer eq ON eq.`testsessionid` = ss.id
WHERE studentid = studid AND topicid = topid AND FIND_IN_SET(SUBJID, subid); */
SELECT * FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid 
WHERE ss.studentid = studid AND eq.topicid = topid AND FIND_IN_SET(eq.SUBJID, subid) ORDER BY ss.id LIMIT 1 OFFSET sesid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getReviewtopic` */

/*!50003 DROP PROCEDURE IF EXISTS  `getReviewtopic` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getReviewtopic`()
BEGIN
select id,topicname,description from reviewtopic;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getStudyunits` */

/*!50003 DROP PROCEDURE IF EXISTS  `getStudyunits` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudyunits`()
BEGIN
select id,topicid,studyname,isparent,parentid from studyunits ;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getSubStudyunits` */

/*!50003 DROP PROCEDURE IF EXISTS  `getSubStudyunits` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`pela`@`%` PROCEDURE `getSubStudyunits`(IN `pid` INT)
BEGIN
select id,reviewid,studyname,description,isparent,parentid from studyunits where parentid = pid;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
