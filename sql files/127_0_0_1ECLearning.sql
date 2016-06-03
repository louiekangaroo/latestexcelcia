-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2016 at 06:51 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `excelcia`
--
CREATE DATABASE IF NOT EXISTS `excelcia` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `excelcia`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `1` (IN `studid` INT, IN `topid` INT, IN `subid` VARCHAR(50), IN `_type` VARCHAR(50), IN `toteasy` INT, IN `totmed` INT, IN `totdiff` INT)  BEGIN
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
 
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `generateQuestions` (IN `studid` INT, IN `topid` INT, IN `subid` VARCHAR(50), IN `_type` VARCHAR(50), IN `toteasy` INT, IN `totmed` INT, IN `totdiff` INT)  BEGIN
 
INSERT INTO studentsession (studentid,questionid,answer,datetimecreated,datetimeanswered)
SELECT studid,U.id,NULL,NOW(),NULL FROM ((SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND FIND_IN_SET(SUBJID, subid) AND LEVEL = 'EASY' AND TYPE = _type LIMIT toteasy) 
UNION
(SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND  FIND_IN_SET(SUBJID, subid) AND LEVEL = 'MEDIUM' AND TYPE = _type LIMIT totmed )
UNION
(SELECT id FROM EXAMQUESTION WHERE TOPICID = topid AND FIND_IN_SET(SUBJID, subid) AND LEVEL = 'DIFFICULT' AND TYPE = _type LIMIT totdiff ))
AS U;
 
 
 
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLogin` (IN `username` VARCHAR(200), IN `pswrd` VARCHAR(200))  BEGIN
select * from personalinfo where username = lcase(username) and password = lcase(pswrd);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getQuestion` (IN `sesid` INT, IN `studid` INT, IN `topid` INT, IN `subid` VARCHAR(50))  BEGIN
  
SELECT * FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid 
WHERE ss.studentid = studid AND eq.topicid = topid AND FIND_IN_SET(eq.SUBJID, subid) ORDER BY ss.id LIMIT 1 OFFSET sesid;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getReviewtopic` ()  BEGIN
select id,topicname,description from reviewtopic;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudyunits` (IN `rid` INT)  BEGIN
select id,topicid,studyname,isparent,parentid from studyunits where topicid = rid;
    END$$

CREATE DEFINER=`pela`@`%` PROCEDURE `getSubStudyunits` (IN `pid` INT)  BEGIN
select id,reviewid,studyname,description,isparent,parentid from studyunits where parentid = pid;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `examquestion`
--

CREATE TABLE `examquestion` (
  `id` int(11) NOT NULL COMMENT 'id',
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
  `minutes` int(10) UNSIGNED NOT NULL COMMENT 'minutes for question',
  `point` int(11) NOT NULL COMMENT 'point for question',
  `type` varchar(100) NOT NULL COMMENT 'test type of question'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `examquestion`
--

INSERT INTO `examquestion` (`id`, `topicid`, `subjid`, `level`, `question`, `a`, `b`, `c`, `d`, `a_rational`, `b_rational`, `c_rational`, `d_rational`, `correct_ans`, `minutes`, `point`, `type`) VALUES
(1, 1, 2, 'EASY', 'the machine that changed the world', 'a.) Colossus', 'b.) SmartPhone', 'c.) Computer', 'd.) All the above', 'a.) Colossus', 'b.) SmartPhone', 'c.) Computer', 'd.) All the above', 'c', 1, 1, 'PRE-TEST'),
(2, 1, 2, 'EASY', 'names whom contributed for the development of computers', 'a.) C.Babbage / T.Flowers / K. Warwick / Jeremy', 'b.) A. Turing / C.Babbage / Jeremy', 'c.) T.Flowers / A.Turing / K. Warwick / C. Babbage', 'd.) all of the above.', 'a.) C.Babbage / T.Flowers / K. Warwick / Jeremy', 'b.) A. Turing / C.Babbage / Jeremy', 'c.) T.Flowers / A.Turing / K. Warwick / C. Babbage', 'd.) all of the above.', 'c', 1, 1, 'PRE-TEST'),
(3, 1, 3, 'EASY', 'father of computer', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'a', 1, 1, 'PRE-TEST'),
(4, 1, 3, 'EASY', 'father of computer science', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'b', 1, 1, 'PRE-TEST'),
(5, 1, 4, 'EASY', 'he developed colossus.', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'd', 2, 1, 'PRE-TEST'),
(6, 1, 4, 'EASY', 'dr. artificial intelligent / robotics, that got a microhip implant, w/c intends to remotely control a robotic arm', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'a.) Charles Babbage', 'b.) Alan Turing', 'c.) Kevin Warwick', 'd.) none of the above', 'c', 2, 1, 'POST-TEST'),
(7, 1, 5, 'EASY', 'would be use to destroy computer/AI', 'a.) Electro-Magnetic-Interference', 'b.) Electro-Magnetic-Pulse', 'c.) Nuclear bom', 'd.) both A & B', 'a.) Electro-Magnetic-Interference', 'b.) Electro-Magnetic-Pulse', 'c.) Nuclear bom', 'd.) both A & B', 'd', 2, 1, 'POST-TEST'),
(8, 1, 5, 'EASY', 'composed of electronic valves and wires (a machine that is as big enough to occupy the entire building floor)', 'a.) desktop computer', 'b.) mainframe computer', 'c.) Colossus', 'd.) all of the above', 'a.) desktop computer', 'b.) mainframe computer', 'c.) Colossus', 'd.) all of the above', 'c', 2, 1, 'POST-TEST'),
(9, 1, 5, 'EASY', 'miniturized electronic component (a complex electronic part composed of several thousand of colossus circuits)', 'a.) integrated circuits', 'b.) silicon chips', 'c.) microchips', 'd.) all of the above', 'a.) integrated circuits', 'b.) silicon chips', 'c.) microchips', 'd.) all of the above', 'd', 1, 1, 'POST-TEST'),
(10, 1, 2, 'MEDIUM', 'a man made machine capable to automate human task', 'a.) desktop computer', 'b.) mainframe computer', 'c.) Colossus', 'd.) all of the above', 'a.) desktop computer', 'b.) mainframe computer', 'c.) Colossus', 'd.) all of the above', 'd', 1, 1, 'PRE-TEST'),
(11, 1, 2, 'MEDIUM', 'refers to the physical tangible computer itself (an element of a complete computer system)', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) all of the above', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) all of the above', 'c', 1, 1, 'PRE-TEST'),
(12, 1, 3, 'MEDIUM', 'refers to the programs/system/machine instructions that is made by programmers.', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) all of the above', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) all of the above', 'b', 1, 1, 'PRE-TEST'),
(13, 1, 3, 'MEDIUM', 'refers to user/coders/programmers/computer operators (an element of a complete computer system)', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) all of the above', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) all of the above', 'a', 1, 1, 'PRE-TEST'),
(14, 1, 4, 'MEDIUM', 'smallest unit of measurement use to measure; capacity to hold information or data, capacity to process, and etc.', 'a.) byte', 'b.) bit', 'c.) kilobyte', 'd. all of the above', 'a.) byte', 'b.) bit', 'c.) kilobyte', 'd. all of the above', 'b', 3, 1, 'PRE-TEST'),
(15, 1, 4, 'MEDIUM', 'if I have 3bytes how many characters do I have?', 'a.) 18', 'b.) 24', 'c.) 36', 'd.) none of the above', 'a.) 18', 'b.) 24', 'c.) 36', 'd.) none of the above', 'd', 3, 1, 'PRE-TEST'),
(16, 1, 5, 'MEDIUM', 'volatile memory of a computer', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) CMOS', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) CMOS', 'a', 3, 1, 'POST-TEST'),
(17, 1, 5, 'MEDIUM', 'a memory type used to hold the configuration/settings of the computer (including system date & time)', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) CMOS', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) CMOS', 'b', 4, 1, 'POST-TEST'),
(18, 1, 2, 'MEDIUM', 'a collection of programs &/or modules that is combined all together to accomplish and/or automate human tasks', 'a.) system', 'b.) program', 'c.) machine instructions', 'd.) all of the above', 'a.) system', 'b.) program', 'c.) machine instructions', 'd.) all of the above', 'a', 4, 1, 'POST-TEST'),
(19, 1, 2, 'MEDIUM', 'a collection of commands written by a programmer to accomplish specific task', 'a.) system', 'b.) program', 'c.) machine instructions', 'd.) all of the above', 'a.) system', 'b.) program', 'c.) machine instructions', 'd.) all of the above', 'b', 1, 1, 'POST-TEST'),
(20, 1, 2, 'DIFFICULT', 'if i have 2 characters how many bytes do i have', 'a.) 8', 'b.) 16', 'c.) 2', 'd.) none of the above', 'a.) 8', 'b.) 16', 'c.) 2', 'd.) none of the above', 'c', 1, 1, 'PRE-TEST'),
(21, 1, 2, 'DIFFICULT', 'keyboard is what type of device?', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a', 1, 1, 'PRE-TEST'),
(22, 1, 3, 'DIFFICULT', 'mouse is what type of device?', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a', 1, 1, 'PRE-TEST'),
(23, 1, 3, 'DIFFICULT', 'speaker is what type of device?', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'b', 2, 1, 'PRE-TEST'),
(24, 2, 4, 'DIFFICULT', 'RFID tag reader is what type of device?', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a', 2, 1, 'PRE-TEST'),
(25, 2, 4, 'DIFFICULT', 'printer is what type of device?', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'a.) input', 'b.) output', 'c.) input & output', 'd.) unknown', 'b', 2, 1, 'PRE-TEST'),
(26, 2, 5, 'DIFFICULT', 'momentary storage of a computer', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) CMOS', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) CMOS', 'a', 2, 1, 'POST-TEST'),
(27, 1, 5, 'DIFFICULT', 'the particular computer memory which contains the configuration/settings of a computer', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) both b & c', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) both b & c', 'd', 1, 1, 'POST-TEST'),
(28, 1, 3, 'DIFFICULT', 'if i have 24bits how many characters do i have.', 'a.) 24', 'b.) 12', 'c.) 3', 'd.) none of the above', 'a.) 24', 'b.) 12', 'c.) 3', 'd.) none of the above', 'c', 1, 1, 'POST-TEST'),
(29, 1, 3, 'DIFFICULT', 'this controls the basic i/o processing of a computer', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) none of the above', 'a.) RAM', 'b.) ROM', 'c.) BIOS', 'd.) none of the above', 'c', 1, 1, 'POST-TEST'),
(30, 2, 7, '5', 'raw facts, events or happening. this is processed in order to provide an information', 'a.) data', 'b.) information', 'c.) IS', 'd.) none of the above', 'a.) data', 'b.) information', 'c.) IS', 'd.) none of the above', 'a', 1, 1, 'easy'),
(31, 2, 7, '1', 'a collection of facts organized in such a way that they have additional value beyond the facts themselves.', 'a.) data', 'b.) information', 'c.) IS', 'd.) none of the above', 'a.) data', 'b.) information', 'c.) IS', 'd.) none of the above', 'b', 1, 1, 'easy'),
(32, 2, 7, '2', 'typically considered to be a set of interrelated elements or components that collect (input), manipulate(processes), and dissiminate(output) and information and provide a feedback mechanism to meet an objective.', 'a.) data', 'b.) information', 'c.) IS', 'd.) none of the above', 'a.) data', 'b.) information', 'c.) IS', 'd.) none of the above', 'c', 3, 1, 'easy'),
(33, 2, 7, '3', 'provides information and supports needed for effective decision making by managers', 'a.) MIS', 'b.) DSS', 'c.) ES', 'd.) none of the above', 'a.) MIS', 'b.) DSS', 'c.) ES', 'd.) none of the above', 'd', 3, 1, 'easy'),
(34, 2, 8, '4', 'automate office procedures and enhance office communications and productivity', 'a.) MIS', 'b.) DSS', 'c.) ES', 'd.) none of the above', 'a.) MIS', 'b.) DSS', 'c.) ES', 'd.) none of the above', 'd', 3, 1, 'easy'),
(35, 2, 8, '5', 'Provide critical information tailored to the information needs of executives.', 'a.) MIS', 'b.) DSS', 'c.) ESS', 'd.) none of the above', 'a.) MIS', 'b.) DSS', 'c.) ESS', 'd.) none of the above', 'c', 4, 1, 'easy'),
(36, 2, 8, '1', 'a SAD model of development that is linear and sequential.', 'a.) SCRUM', 'b.) AGILE', 'c.) WaterFall', 'd.) none of the above', 'a.) SCRUM', 'b.) AGILE', 'c.) WaterFall', 'd.) none of the above', 'c', 4, 1, 'easy'),
(37, 2, 8, '2', 'is a time boxed, iteractive approach to software development that builds software incrementally from the start of the project, instead of trying to deliver it all at once near the end.', 'a.) SCRUM', 'b.) AGILE', 'c.) WaterFall', 'd.) none of the above', 'a.) SCRUM', 'b.) AGILE', 'c.) WaterFall', 'd.) none of the above', 'b', 1, 1, 'easy'),
(38, 2, 8, '3', 'A shared collection of logically related data designed to meet the information needs of multiple users in organization.', 'a.) database', 'b.) document', 'c.) information', 'd.) none of the above', 'a.) database', 'b.) document', 'c.) information', 'd.) none of the above', 'a', 1, 1, 'easy'),
(39, 2, 7, '4', 'are computerized information systems that were developed to process large amounts of data for routine business transaction.', 'a.) ESS', 'b.) TPS', 'c.) MIS', 'd.) none of the above', 'a.) ESS', 'b.) TPS', 'c.) MIS', 'd.) none of the above', 'b', 1, 1, 'moderate'),
(40, 2, 7, '5', 'the one who studies the problems and needs of an organization to determine how people, data, processes, communications, and information technology can best accomplish improvements for the business.', 'a.) programmer', 'b.) encoder', 'c.) system analyst', 'd.) none of the above', 'a.) programmer', 'b.) encoder', 'c.) system analyst', 'd.) none of the above', 'c', 1, 1, 'moderate'),
(41, 2, 7, '1', 'Organized collection of people, procedures, software, databases, and devices used to record completed business transactions', 'a.) ESS', 'b.) MIS', 'c.) TPS', 'd.) none of the above', 'a.) ESS', 'b.) MIS', 'c.) TPS', 'd.) none of the above', 'd', 2, 1, 'moderate'),
(42, 2, 7, '2', 'Computer system takes on characteristics of human intelligence', 'a.) DSS', 'b.) MIS', 'c.) TPS', 'd.) all of the above', 'a.) DSS', 'b.) MIS', 'c.) TPS', 'd.) all of the above', 'd', 2, 1, 'moderate'),
(43, 2, 7, '3', 'a graphical representation of the "flow" of data through an information system, modelling its process aspects.', 'a.) System Flow', 'b.) Data Flow Diagram', 'c.) System Flowchart', 'd.) none of the above', 'a.) System Flow', 'b.) Data Flow Diagram', 'c.) System Flowchart', 'd.) none of the above', 'b', 2, 1, 'moderate'),
(44, 2, 7, '4', 'symbol used to represent data that the system stores.', 'a.) Process', 'b.) External Entity', 'c.) Data Flow', 'd.) None of the above', 'a.) Process', 'b.) External Entity', 'c.) Data Flow', 'd.) None of the above', 'd', 2, 1, 'moderate'),
(45, 2, 8, '5', 'performs some action on data, such as creates, modifies, stores, delete, etc. (either manual or supported by a computer)', 'a.) Process', 'b.) External Entity', 'c.) Data Flow', 'd.) None of the above', 'a.) Process', 'b.) External Entity', 'c.) Data Flow', 'd.) None of the above', 'b', 1, 1, 'moderate'),
(46, 2, 8, '1', 'a type of computer network which intends to connect one town to another town of a different region.', 'a.) LAN', 'b.) MAN', 'c.) WAN', 'd.) none of the above', 'a.) LAN', 'b.) MAN', 'c.) WAN', 'd.) none of the above', 'c', 1, 1, 'moderate'),
(47, 2, 8, '2', 'a computer program created intentionally to disrupt the normal operation of a computer', 'a.) System', 'b.) information System', 'c.) Virus', 'd.) none of the above', 'a.) System', 'b.) information System', 'c.) Virus', 'd.) none of the above', 'c', 1, 1, 'moderate'),
(48, 2, 8, '3', 'a problem solving technique that decomposes a system into its component pieces for the purpose of the studying how well those component parts work and interact to accomplish their purpose.', 'a.) system programming', 'b.) system designing', 'c.) system planning', 'd.) system analysis', 'a.) system programming', 'b.) system designing', 'c.) system planning', 'd.) system analysis', 'd', 1, 1, 'moderate'),
(49, 2, 7, '4', 'a conceptual model used in project management that describes the stages involved in an information system development project, from an initial feasibility study through maintenance of the completed application.', 'a.) SDLC', 'b.) Waterfall', 'c.) Agile', 'd.) SCRUM', 'a.) SDLC', 'b.) Waterfall', 'c.) Agile', 'd.) SCRUM', 'a', 1, 1, 'difficult'),
(50, 2, 7, '5', 'a collection of descriptions of the data objects or items in a data model for the benefit of programmers and others who need to refer to them', 'a.) Information', 'b.) Data dictionary', 'c.) Data Processing', 'd.) none of the above', 'a.) Information', 'b.) Data dictionary', 'c.) Data Processing', 'd.) none of the above', 'b', 3, 1, 'difficult'),
(51, 2, 7, '1', 'which is none element of a complete computer system', 'a.) people ware', 'b.) Hardware', 'c.) Anti Virus', 'd.) none of the above', 'a.) people ware', 'b.) Hardware', 'c.) Anti Virus', 'd.) none of the above', 'c', 3, 1, 'difficult'),
(52, 2, 7, '2', 'none basic hardware element', 'a.) external hard drive or flash drive', 'b.) Monitor/Display', 'c.) CPU / Central Processing Unit', 'd.) none of the above', 'a.) external hard drive or flash drive', 'b.) Monitor/Display', 'c.) CPU / Central Processing Unit', 'd.) none of the above', 'a', 3, 1, 'difficult'),
(53, 2, 7, '3', 'it is an electronic device that uses stored data and instruction to generate information', 'a.) calculator', 'b.) smartphone', 'c.) computer', 'd.) all of the above', 'a.) calculator', 'b.) smartphone', 'c.) computer', 'd.) all of the above', 'c', 4, 1, 'difficult'),
(54, 2, 7, '4', 'it refers to processed data', 'a.) input', 'b.) output', 'c.) data', 'd.) none of the above', 'a.) input', 'b.) output', 'c.) data', 'd.) none of the above', 'd', 4, 1, 'difficult'),
(55, 2, 7, '5', 'it is the unprocessed facts', 'a.) input', 'b.) output', 'c.) data', 'd.) none of the above', 'a.) input', 'b.) output', 'c.) data', 'd.) none of the above', 'c', 1, 1, 'difficult'),
(56, 2, 8, '1', 'an electronic machine that has memory and can manipulate data and it has arithmetic and logic function', 'a.) calculator', 'b.) smartphone', 'c.) computer ', 'd.) all of the above', 'a.) calculator', 'b.) smartphone', 'c.) computer ', 'd.) all of the above', 'c', 1, 1, 'difficult'),
(57, 2, 8, '2', 'a computing device popularized by chinese as their early calculator', 'a.) abacus', 'b.) smartphone', 'c.) napiers bone', 'd.) none of the above', 'a.) abacus', 'b.) smartphone', 'c.) napiers bone', 'd.) none of the above', 'a', 1, 1, 'difficult'),
(58, 2, 8, '3', 'basic components of computer system', 'a.) monitor / keyboard / cpu', 'b.) monitor / keyboard / cpu / mouse / avr', 'c.) monitor / keyboard / cpu / webcam / speaker / avr', 'd.) none of the above', 'a.) monitor / keyboard / cpu', 'b.) monitor / keyboard / cpu / mouse / avr', 'c.) monitor / keyboard / cpu / webcam / speaker / avr', 'd.) none of the above', 'd', 1, 1, 'difficult'),
(59, 2, 8, '4', 'basic computer hardware components', 'a.) monitor / keyboard / cpu', 'b.) monitor / keyboard / cpu / mouse / avr', 'c.) monitor / keyboard / cpu / webcam / speakers', 'd.) none of the above', 'a.) monitor / keyboard / cpu', 'b.) monitor / keyboard / cpu / mouse / avr', 'c.) monitor / keyboard / cpu / webcam / speakers', 'd.) none of the above', 'a', 2, 1, 'easy'),
(60, 2, 8, '5', 'this refers to the physical components of the computer', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) none of the above', 'a.) people ware', 'b.) software', 'c.) hardware', 'd.) none of the above', 'c', 2, 1, 'easy'),
(61, 2, 8, '1', 'this is considered to be the brain of a computer', 'a.) input/output device', 'b.) internal storage', 'c.) processor', 'd.) none of the above', 'a.) input/output device', 'b.) internal storage', 'c.) processor', 'd.) none of the above', 'c', 2, 1, 'easy'),
(62, 2, 8, '2', 'nonvolatile memory of a computer', 'a.) Read Only Memory (ROM)', 'b.) Random Access Memory (RAM)', 'c.) both A & B', 'd.) none of the above', 'a.) Read Only Memory (ROM)', 'b.) Random Access Memory (RAM)', 'c.) both A & B', 'd.) none of the above', 'a', 2, 1, 'easy'),
(63, 2, 8, '3', 'this is known to be the device which can accept instructions from computer user', 'a.) input device', 'b.) output device', 'c.) both A & B', 'd.) none of the above', 'a.) input device', 'b.) output device', 'c.) both A & B', 'd.) none of the above', 'a', 1, 1, 'easy'),
(64, 2, 7, '4', 'this is known to return data, that is, information back to the user', 'a.) input device', 'b.) output device', 'c.) both A & B', 'd.) none of the above', 'a.) input device', 'b.) output device', 'c.) both A & B', 'd.) none of the above', 'b', 1, 1, 'easy'),
(65, 1, 4, '5', 'this is known to be an optical storage which can hold 600MB to 720MB of data', 'a.) CD Disc', 'b.) DVD Disc', 'c.) Bluray', 'd.) none of the above', 'a.) CD Disc', 'b.) DVD Disc', 'c.) Bluray', 'd.) none of the above', 'a', 1, 1, 'easy'),
(66, 1, 5, '1', 'this refers to the set of instructions written in code that computers can understand and executed', 'a.) System', 'b.) software', 'c.) programs', 'd.) none / all of the above', 'a.) System', 'b.) software', 'c.) programs', 'd.) none / all of the above', 'b', 1, 1, 'easy'),
(67, 1, 2, '2', 'a software which contains programs that perform task needed for computer hardware to function efficiently. ', 'a.) system software / operating system', 'b.) microsoft windows', 'c.) IOS', 'd.) none / all of the above', 'a.) system software / operating system', 'b.) microsoft windows', 'c.) IOS', 'd.) none / all of the above', 'a', 1, 1, 'easy'),
(68, 1, 2, '3', 'a software that is used to govern the proper operation of a computer', 'a.) system software / operating system', 'b.) microsoft windows', 'c.) IOS', 'd.) none / all of the above', 'a.) system software / operating system', 'b.) microsoft windows', 'c.) IOS', 'd.) none / all of the above', 'a', 3, 1, 'easy'),
(69, 1, 3, '4', 'refers to any person involve in the software development and maintenance of the hardware', 'a.) hardware', 'b.) software', 'c.) peopleware', 'd.) none / all of the above', 'a.) hardware', 'b.) software', 'c.) peopleware', 'd.) none / all of the above', 'c', 3, 1, 'easy'),
(70, 1, 3, '5', 'is an interrelated set of components that function together to achieve an outcome', 'a.) program', 'b.) system', 'c.) module', 'd.) none of the above', 'a.) program', 'b.) system', 'c.) module', 'd.) none of the above', 'b', 3, 1, 'easy');

-- --------------------------------------------------------

--
-- Table structure for table `examresulthistory`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `personalinfo`
--

CREATE TABLE `personalinfo` (
  `id` int(11) NOT NULL,
  `lname` varchar(100) NOT NULL,
  `mname` varchar(100) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `contactno` varchar(100) NOT NULL,
  `emailadd` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `usertype` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personalinfo`
--

INSERT INTO `personalinfo` (`id`, `lname`, `mname`, `fname`, `address`, `contactno`, `emailadd`, `username`, `password`, `usertype`, `status`) VALUES
(1, 'dean', 'salansang', 'alan', 'taytay', '123', 'email@ko.com', 'alan', 'alan', 'teacher', '1'),
(2, 'manalastas', 'edd', 'edd', 'angono', '321', 'email@edd.com', 'edd', 'edd', 'admin', '1'),
(3, 'pep', 'pep', 'pep', 'pep', '111', 'email@pep.com', 'pep', 'pep', 'student', '1');

-- --------------------------------------------------------

--
-- Table structure for table `reviewmaterials`
--

CREATE TABLE `reviewmaterials` (
  `id` int(11) NOT NULL,
  `studyid` int(11) NOT NULL,
  `reviewid` int(11) NOT NULL,
  `attachment` varchar(500) NOT NULL,
  `filetype` varchar(100) NOT NULL,
  `extname` varchar(100) NOT NULL,
  `dateupload` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reviewresult`
--

CREATE TABLE `reviewresult` (
  `id` int(11) DEFAULT NULL,
  `reviewid` int(11) DEFAULT NULL,
  `rating` decimal(18,2) DEFAULT NULL,
  `datetimestarted` datetime DEFAULT NULL,
  `datetimeend` datetime DEFAULT NULL,
  `examresultlogid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reviewsession`
--

CREATE TABLE `reviewsession` (
  `id` int(11) NOT NULL,
  `sessionName` varchar(200) NOT NULL,
  `decription` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reviewtopic`
--

CREATE TABLE `reviewtopic` (
  `id` int(11) NOT NULL,
  `topicname` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reviewtopic`
--

INSERT INTO `reviewtopic` (`id`, `topicname`, `description`) VALUES
(1, 'Pre-Test', ''),
(2, 'Post-Test', '');

-- --------------------------------------------------------

--
-- Table structure for table `studentsession`
--

CREATE TABLE `studentsession` (
  `id` int(11) NOT NULL,
  `studentid` int(11) NOT NULL,
  `questionid` int(11) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `datetimecreated` datetime NOT NULL,
  `datetimeanswered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studentsession`
--

INSERT INTO `studentsession` (`id`, `studentid`, `questionid`, `answer`, `datetimecreated`, `datetimeanswered`) VALUES
(1, 1, 1, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(2, 1, 2, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(3, 1, 3, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(4, 1, 10, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(5, 1, 11, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(6, 1, 12, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(7, 1, 13, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(8, 1, 20, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(9, 1, 21, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(10, 1, 22, '', '2016-06-02 01:41:38', '0000-00-00 00:00:00'),
(16, 1, 1, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(17, 1, 2, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(18, 1, 3, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(19, 1, 10, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(20, 1, 11, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(21, 1, 12, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(22, 1, 13, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(23, 1, 20, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(24, 1, 21, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(25, 1, 22, '', '2016-06-02 11:49:52', '0000-00-00 00:00:00'),
(31, 1, 1, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(32, 1, 2, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(33, 1, 3, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(34, 1, 10, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(35, 1, 11, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(36, 1, 12, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(37, 1, 13, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(38, 1, 20, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(39, 1, 21, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(40, 1, 22, '', '2016-06-02 11:50:00', '0000-00-00 00:00:00'),
(46, 1, 1, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(47, 1, 2, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(48, 1, 3, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(49, 1, 10, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(50, 1, 11, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(51, 1, 12, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(52, 1, 13, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(53, 1, 20, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(54, 1, 21, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(55, 1, 22, '', '2016-06-02 11:50:03', '0000-00-00 00:00:00'),
(61, 1, 1, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(62, 1, 2, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(63, 1, 3, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(64, 1, 10, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(65, 1, 11, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(66, 1, 12, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(67, 1, 13, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(68, 1, 20, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(69, 1, 21, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(70, 1, 22, '', '2016-06-02 11:50:05', '0000-00-00 00:00:00'),
(76, 1, 1, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(77, 1, 2, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(78, 1, 3, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(79, 1, 10, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(80, 1, 11, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(81, 1, 12, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(82, 1, 13, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(83, 1, 20, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(84, 1, 21, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(85, 1, 22, '', '2016-06-02 11:50:07', '0000-00-00 00:00:00'),
(91, 1, 1, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(92, 1, 2, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(93, 1, 3, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(94, 1, 10, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(95, 1, 11, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(96, 1, 12, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(97, 1, 13, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(98, 1, 20, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(99, 1, 21, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(100, 1, 22, '', '2016-06-02 11:50:09', '0000-00-00 00:00:00'),
(106, 1, 1, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(107, 1, 2, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(108, 1, 3, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(109, 1, 10, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(110, 1, 11, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(111, 1, 12, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(112, 1, 13, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(113, 1, 20, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(114, 1, 21, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(115, 1, 22, '', '2016-06-02 11:50:11', '0000-00-00 00:00:00'),
(121, 1, 1, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(122, 1, 2, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(123, 1, 3, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(124, 1, 10, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(125, 1, 11, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(126, 1, 12, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(127, 1, 13, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(128, 1, 20, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(129, 1, 21, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(130, 1, 22, '', '2016-06-02 17:06:59', '0000-00-00 00:00:00'),
(131, 1, 1, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(132, 1, 2, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(133, 1, 3, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(134, 1, 10, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(135, 1, 11, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(136, 1, 12, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(137, 1, 13, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(138, 1, 20, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(139, 1, 21, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(140, 1, 22, '', '2016-06-03 11:56:25', '0000-00-00 00:00:00'),
(146, 1, 1, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(147, 1, 2, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(148, 1, 3, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(149, 1, 10, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(150, 1, 11, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(151, 1, 12, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(152, 1, 13, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(153, 1, 20, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(154, 1, 21, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(155, 1, 22, '', '2016-06-03 11:56:51', '0000-00-00 00:00:00'),
(161, 1, 1, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(162, 1, 2, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(163, 1, 3, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(164, 1, 10, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(165, 1, 11, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(166, 1, 12, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(167, 1, 13, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(168, 1, 20, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(169, 1, 21, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(170, 1, 22, '', '2016-06-03 11:59:38', '0000-00-00 00:00:00'),
(176, 1, 1, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(177, 1, 2, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(178, 1, 3, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(179, 1, 10, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(180, 1, 11, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(181, 1, 12, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(182, 1, 13, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(183, 1, 20, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(184, 1, 21, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(185, 1, 22, '', '2016-06-03 12:00:28', '0000-00-00 00:00:00'),
(191, 1, 1, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(192, 1, 2, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(193, 1, 3, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(194, 1, 10, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(195, 1, 11, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(196, 1, 12, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(197, 1, 13, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(198, 1, 20, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(199, 1, 21, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(200, 1, 22, '', '2016-06-03 12:00:52', '0000-00-00 00:00:00'),
(206, 1, 1, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(207, 1, 2, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(208, 1, 3, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(209, 1, 10, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(210, 1, 11, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(211, 1, 12, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(212, 1, 13, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(213, 1, 20, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(214, 1, 21, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(215, 1, 22, '', '2016-06-03 12:00:55', '0000-00-00 00:00:00'),
(221, 1, 1, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(222, 1, 2, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(223, 1, 3, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(224, 1, 10, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(225, 1, 11, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(226, 1, 12, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(227, 1, 13, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(228, 1, 20, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(229, 1, 21, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(230, 1, 22, '', '2016-06-03 12:00:57', '0000-00-00 00:00:00'),
(236, 1, 1, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(237, 1, 2, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(238, 1, 3, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(239, 1, 10, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(240, 1, 11, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(241, 1, 12, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(242, 1, 13, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(243, 1, 20, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(244, 1, 21, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(245, 1, 22, '', '2016-06-03 12:01:00', '0000-00-00 00:00:00'),
(251, 1, 1, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(252, 1, 2, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(253, 1, 3, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(254, 1, 10, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(255, 1, 11, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(256, 1, 12, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(257, 1, 13, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(258, 1, 20, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(259, 1, 21, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(260, 1, 22, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(266, 1, 1, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(267, 1, 2, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(268, 1, 3, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(269, 1, 10, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(270, 1, 11, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(271, 1, 12, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(272, 1, 13, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(273, 1, 20, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(274, 1, 21, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(275, 1, 22, '', '2016-06-03 12:01:01', '0000-00-00 00:00:00'),
(281, 1, 1, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(282, 1, 2, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(283, 1, 3, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(284, 1, 10, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(285, 1, 11, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(286, 1, 12, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(287, 1, 13, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(288, 1, 20, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(289, 1, 21, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(290, 1, 22, '', '2016-06-03 12:01:02', '0000-00-00 00:00:00'),
(296, 1, 1, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(297, 1, 2, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(298, 1, 3, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(299, 1, 10, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(300, 1, 11, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(301, 1, 12, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(302, 1, 13, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(303, 1, 20, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(304, 1, 21, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(305, 1, 22, '', '2016-06-03 12:01:04', '0000-00-00 00:00:00'),
(311, 1, 1, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(312, 1, 2, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(313, 1, 3, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(314, 1, 10, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(315, 1, 11, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(316, 1, 12, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(317, 1, 13, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(318, 1, 20, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(319, 1, 21, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(320, 1, 22, '', '2016-06-03 12:01:05', '0000-00-00 00:00:00'),
(326, 1, 1, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(327, 1, 2, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(328, 1, 3, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(329, 1, 10, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(330, 1, 11, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(331, 1, 12, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(332, 1, 13, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(333, 1, 20, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(334, 1, 21, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(335, 1, 22, '', '2016-06-03 12:01:06', '0000-00-00 00:00:00'),
(341, 1, 1, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(342, 1, 2, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(343, 1, 3, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(344, 1, 10, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(345, 1, 11, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(346, 1, 12, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(347, 1, 13, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(348, 1, 20, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(349, 1, 21, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(350, 1, 22, '', '2016-06-03 12:01:07', '0000-00-00 00:00:00'),
(356, 1, 1, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(357, 1, 2, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(358, 1, 3, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(359, 1, 10, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(360, 1, 11, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(361, 1, 12, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(362, 1, 13, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(363, 1, 20, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(364, 1, 21, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(365, 1, 22, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(371, 1, 1, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(372, 1, 2, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(373, 1, 3, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(374, 1, 10, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(375, 1, 11, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(376, 1, 12, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(377, 1, 13, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(378, 1, 20, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(379, 1, 21, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(380, 1, 22, '', '2016-06-03 12:01:08', '0000-00-00 00:00:00'),
(386, 1, 1, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(387, 1, 2, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(388, 1, 3, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(389, 1, 10, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(390, 1, 11, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(391, 1, 12, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(392, 1, 13, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(393, 1, 20, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(394, 1, 21, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(395, 1, 22, '', '2016-06-03 12:01:09', '0000-00-00 00:00:00'),
(401, 1, 1, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(402, 1, 2, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(403, 1, 3, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(404, 1, 10, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(405, 1, 11, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(406, 1, 12, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(407, 1, 13, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(408, 1, 20, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(409, 1, 21, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(410, 1, 22, '', '2016-06-03 12:04:45', '0000-00-00 00:00:00'),
(416, 1, 1, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(417, 1, 2, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(418, 1, 3, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(419, 1, 10, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(420, 1, 11, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(421, 1, 12, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(422, 1, 13, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(423, 1, 20, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(424, 1, 21, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(425, 1, 22, '', '2016-06-03 12:05:13', '0000-00-00 00:00:00'),
(431, 1, 1, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(432, 1, 2, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(433, 1, 3, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(434, 1, 10, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(435, 1, 11, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(436, 1, 12, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(437, 1, 13, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(438, 1, 20, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(439, 1, 21, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(440, 1, 22, '', '2016-06-03 12:05:16', '0000-00-00 00:00:00'),
(446, 1, 1, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(447, 1, 2, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(448, 1, 3, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(449, 1, 10, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(450, 1, 11, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(451, 1, 12, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(452, 1, 13, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(453, 1, 20, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(454, 1, 21, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(455, 1, 22, '', '2016-06-03 12:05:21', '0000-00-00 00:00:00'),
(461, 1, 1, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(462, 1, 2, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(463, 1, 3, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(464, 1, 10, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(465, 1, 11, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(466, 1, 12, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(467, 1, 13, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(468, 1, 20, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(469, 1, 21, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(470, 1, 22, '', '2016-06-03 12:05:55', '0000-00-00 00:00:00'),
(476, 1, 1, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(477, 1, 2, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(478, 1, 3, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(479, 1, 10, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(480, 1, 11, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(481, 1, 12, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(482, 1, 13, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(483, 1, 20, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(484, 1, 21, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(485, 1, 22, '', '2016-06-03 12:06:13', '0000-00-00 00:00:00'),
(491, 1, 1, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(492, 1, 2, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(493, 1, 3, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(494, 1, 10, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(495, 1, 11, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(496, 1, 12, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(497, 1, 13, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(498, 1, 20, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(499, 1, 21, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(500, 1, 22, '', '2016-06-03 12:06:53', '0000-00-00 00:00:00'),
(506, 1, 1, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(507, 1, 2, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(508, 1, 3, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(509, 1, 10, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(510, 1, 11, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(511, 1, 12, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(512, 1, 13, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(513, 1, 20, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(514, 1, 21, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(515, 1, 22, '', '2016-06-03 12:15:49', '0000-00-00 00:00:00'),
(521, 1, 1, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(522, 1, 2, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(523, 1, 3, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(524, 1, 10, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(525, 1, 11, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(526, 1, 12, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(527, 1, 13, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(528, 1, 20, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(529, 1, 21, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(530, 1, 22, '', '2016-06-03 12:18:44', '0000-00-00 00:00:00'),
(536, 1, 1, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(537, 1, 2, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(538, 1, 3, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(539, 1, 10, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(540, 1, 11, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(541, 1, 12, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(542, 1, 13, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(543, 1, 20, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(544, 1, 21, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(545, 1, 22, '', '2016-06-03 12:18:53', '0000-00-00 00:00:00'),
(546, 1, 1, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(547, 1, 2, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(548, 1, 3, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(549, 1, 10, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(550, 1, 11, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(551, 1, 12, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(552, 1, 13, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(553, 1, 20, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(554, 1, 21, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00'),
(555, 1, 22, '', '2016-06-03 12:48:55', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `studentsessionsummary`
--

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
  `remarks` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `studyunits`
--

CREATE TABLE `studyunits` (
  `id` int(11) NOT NULL,
  `topicid` int(11) NOT NULL,
  `studyname` varchar(100) NOT NULL,
  `isparent` int(11) NOT NULL,
  `parentid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studyunits`
--

INSERT INTO `studyunits` (`id`, `topicid`, `studyname`, `isparent`, `parentid`) VALUES
(1, 1, 'Introduction to Accounting', 1, 0),
(2, 1, 'Day 1 Online Accounting', 0, 1),
(3, 1, 'Day 2 Describe the nature of Accounting', 0, 1),
(4, 1, 'Day 3 Explains the fucntion of accounting in business', 0, 1),
(5, 1, 'Day 4 Narrate the history/Origin of Accounting', 0, 1),
(6, 2, 'Branches of Accounting', 1, 0),
(7, 2, 'Day 5 Differentiate the branches of Accounting', 0, 6),
(8, 2, 'Day 6 Explain the kind/Type of service rendered in each of these branches', 0, 6);

-- --------------------------------------------------------

--
-- Table structure for table `testbuffer`
--

CREATE TABLE `testbuffer` (
  `id` int(11) NOT NULL COMMENT 'just a record id',
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
  `minutes` int(10) UNSIGNED NOT NULL COMMENT 'time duration for this question',
  `point` int(11) NOT NULL COMMENT 'points to be given for this question',
  `type` varchar(100) NOT NULL COMMENT 'easy | moderate | difficult'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `testhistory`
--

CREATE TABLE `testhistory` (
  `id` int(11) NOT NULL COMMENT 'just a record id',
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
  `minutes` int(10) UNSIGNED NOT NULL COMMENT 'time duration for this question',
  `point` int(11) NOT NULL COMMENT 'points to be given for this question',
  `type` varchar(100) NOT NULL COMMENT 'easy | moderate | difficult'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `topic_config`
--

CREATE TABLE `topic_config` (
  `id` int(10) NOT NULL,
  `topicID` int(10) NOT NULL,
  `testtype` varchar(45) NOT NULL,
  `itemseasy` int(10) NOT NULL,
  `itemsmoderate` int(10) NOT NULL,
  `itemsdifficult` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='topic configuration to be defined by the teacher or admin';

--
-- Dumping data for table `topic_config`
--

INSERT INTO `topic_config` (`id`, `topicID`, `testtype`, `itemseasy`, `itemsmoderate`, `itemsdifficult`) VALUES
(1, 1, 'pre-test', 3, 4, 3),
(2, 2, 'post-test', 4, 3, 3),
(4, 2, 'pre-test', 15, 5, 10),
(5, 1, 'post-test', 10, 10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `userlogs`
--

CREATE TABLE `userlogs` (
  `id` int(11) NOT NULL,
  `loguserid` int(11) NOT NULL,
  `logdate` date NOT NULL,
  `logdesc` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userlogs`
--

INSERT INTO `userlogs` (`id`, `loguserid`, `logdate`, `logdesc`) VALUES
(1, 0, '2016-05-28', 'Good Login'),
(2, 0, '2016-05-28', 'Good Login'),
(3, 0, '2016-05-28', 'Good Login'),
(4, 2, '2016-05-29', 'Good Login'),
(5, 2, '2016-05-29', 'Good Login'),
(6, 0, '2016-06-01', 'Good Login'),
(7, 0, '2016-06-03', 'Good Login'),
(8, 0, '2016-06-03', 'Good Login'),
(9, 0, '2016-06-03', 'Good Login'),
(10, 0, '2016-06-03', 'Good Login'),
(11, 0, '2016-06-03', 'Good Login'),
(12, 0, '2016-06-03', 'Good Login'),
(13, 0, '2016-06-03', 'Good Login');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `examquestion`
--
ALTER TABLE `examquestion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topicid` (`topicid`),
  ADD KEY `subjid` (`subjid`);

--
-- Indexes for table `personalinfo`
--
ALTER TABLE `personalinfo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviewsession`
--
ALTER TABLE `reviewsession`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviewtopic`
--
ALTER TABLE `reviewtopic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentsession`
--
ALTER TABLE `studentsession`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questionid` (`questionid`),
  ADD KEY `studentid` (`studentid`);

--
-- Indexes for table `studentsessionsummary`
--
ALTER TABLE `studentsessionsummary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testsessionid` (`testsessionid`);

--
-- Indexes for table `studyunits`
--
ALTER TABLE `studyunits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topicid` (`topicid`);

--
-- Indexes for table `testbuffer`
--
ALTER TABLE `testbuffer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testsessionid` (`testsessionid`);

--
-- Indexes for table `testhistory`
--
ALTER TABLE `testhistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testsessionid` (`testsessionid`);

--
-- Indexes for table `topic_config`
--
ALTER TABLE `topic_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topicID` (`topicID`);

--
-- Indexes for table `userlogs`
--
ALTER TABLE `userlogs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `examquestion`
--
ALTER TABLE `examquestion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=71;
--
-- AUTO_INCREMENT for table `personalinfo`
--
ALTER TABLE `personalinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `reviewsession`
--
ALTER TABLE `reviewsession`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `studentsession`
--
ALTER TABLE `studentsession`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=561;
--
-- AUTO_INCREMENT for table `testbuffer`
--
ALTER TABLE `testbuffer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'just a record id';
--
-- AUTO_INCREMENT for table `testhistory`
--
ALTER TABLE `testhistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'just a record id';
--
-- AUTO_INCREMENT for table `topic_config`
--
ALTER TABLE `topic_config`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `userlogs`
--
ALTER TABLE `userlogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `examquestion`
--
ALTER TABLE `examquestion`
  ADD CONSTRAINT `examquestion_ibfk_1` FOREIGN KEY (`topicid`) REFERENCES `reviewtopic` (`id`),
  ADD CONSTRAINT `examquestion_ibfk_2` FOREIGN KEY (`subjid`) REFERENCES `studyunits` (`id`);

--
-- Constraints for table `studentsession`
--
ALTER TABLE `studentsession`
  ADD CONSTRAINT `studentsession_ibfk_1` FOREIGN KEY (`questionid`) REFERENCES `examquestion` (`id`),
  ADD CONSTRAINT `studentsession_ibfk_2` FOREIGN KEY (`studentid`) REFERENCES `personalinfo` (`id`);

--
-- Constraints for table `studentsessionsummary`
--
ALTER TABLE `studentsessionsummary`
  ADD CONSTRAINT `studentsessionsummary_ibfk_1` FOREIGN KEY (`testsessionid`) REFERENCES `studentsession` (`id`);

--
-- Constraints for table `studyunits`
--
ALTER TABLE `studyunits`
  ADD CONSTRAINT `studyunits_ibfk_1` FOREIGN KEY (`topicid`) REFERENCES `reviewtopic` (`id`);

--
-- Constraints for table `testbuffer`
--
ALTER TABLE `testbuffer`
  ADD CONSTRAINT `testbuffer_ibfk_1` FOREIGN KEY (`testsessionid`) REFERENCES `studentsession` (`id`);

--
-- Constraints for table `testhistory`
--
ALTER TABLE `testhistory`
  ADD CONSTRAINT `testhistory_ibfk_1` FOREIGN KEY (`testsessionid`) REFERENCES `studentsession` (`id`);

--
-- Constraints for table `topic_config`
--
ALTER TABLE `topic_config`
  ADD CONSTRAINT `topic_config_ibfk_1` FOREIGN KEY (`topicID`) REFERENCES `reviewtopic` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
