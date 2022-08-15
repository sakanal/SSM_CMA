/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80028
Source Host           : localhost:3306
Source Database       : cma

Target Server Type    : MYSQL
Target Server Version : 80028
File Encoding         : 65001

Date: 2022-08-15 17:48:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cma_admin
-- ----------------------------
DROP TABLE IF EXISTS `cma_admin`;
CREATE TABLE `cma_admin` (
  `admin_id` int NOT NULL COMMENT '管理员id',
  `admin_name` varchar(25) NOT NULL,
  `admin_password` varchar(20) NOT NULL COMMENT '管理员密码',
  `admin_authority` int NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for cma_clazz
-- ----------------------------
DROP TABLE IF EXISTS `cma_clazz`;
CREATE TABLE `cma_clazz` (
  `clazz_id` int NOT NULL COMMENT '班级号',
  `clazz_tch` int NOT NULL COMMENT '教师id',
  KEY `clazz_tch` (`clazz_tch`),
  CONSTRAINT `cma_clazz_ibfk_1` FOREIGN KEY (`clazz_tch`) REFERENCES `cma_teacher` (`tch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for cma_college
-- ----------------------------
DROP TABLE IF EXISTS `cma_college`;
CREATE TABLE `cma_college` (
  `id` int NOT NULL,
  `college_name` varchar(35) NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for cma_major
-- ----------------------------
DROP TABLE IF EXISTS `cma_major`;
CREATE TABLE `cma_major` (
  `id` int NOT NULL AUTO_INCREMENT,
  `major_name` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业名称',
  `college_id` int NOT NULL COMMENT '学院ID',
  PRIMARY KEY (`id`),
  KEY `college_id` (`college_id`),
  CONSTRAINT `cma_major_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `cma_college` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for cma_student
-- ----------------------------
DROP TABLE IF EXISTS `cma_student`;
CREATE TABLE `cma_student` (
  `stu_id` bigint NOT NULL COMMENT '学生ID',
  `stu_name` varchar(20) NOT NULL COMMENT '学生姓名',
  `stu_password` varchar(25) NOT NULL COMMENT '学生密码',
  `stu_gender` varchar(5) DEFAULT NULL COMMENT '学生性别',
  `stu_phone` bigint DEFAULT NULL COMMENT '学生电话',
  `stu_birthday` date DEFAULT NULL COMMENT '学生生日',
  `stu_address` varchar(100) DEFAULT NULL COMMENT '学生地址',
  `stu_email` varchar(50) DEFAULT NULL COMMENT '学生邮箱',
  `stu_class` varchar(15) DEFAULT NULL COMMENT '学生班级',
  `stu_college` int DEFAULT NULL COMMENT '学生学院',
  `stu_major` int DEFAULT NULL COMMENT '学生专业',
  PRIMARY KEY (`stu_id`),
  KEY `stu_major` (`stu_major`),
  KEY `cma_student_ibfk_1` (`stu_college`),
  CONSTRAINT `cma_student_ibfk_1` FOREIGN KEY (`stu_college`) REFERENCES `cma_college` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cma_student_ibfk_2` FOREIGN KEY (`stu_major`) REFERENCES `cma_major` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for cma_teacher
-- ----------------------------
DROP TABLE IF EXISTS `cma_teacher`;
CREATE TABLE `cma_teacher` (
  `tch_id` int NOT NULL COMMENT '教师ID',
  `tch_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教师姓名',
  `tch_password` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教师密码',
  `tch_gender` varchar(5) DEFAULT NULL COMMENT '教师性别',
  `tch_phone` bigint DEFAULT NULL COMMENT '教师电话',
  `tch_birthday` date DEFAULT NULL COMMENT '教师生日',
  `tch_address` varchar(100) DEFAULT NULL COMMENT '教师地址',
  `tch_email` varchar(50) DEFAULT NULL COMMENT '教师邮箱',
  `tch_college` int DEFAULT NULL COMMENT '教师学院',
  PRIMARY KEY (`tch_id`),
  KEY `tch_college` (`tch_college`),
  CONSTRAINT `cma_teacher_ibfk_1` FOREIGN KEY (`tch_college`) REFERENCES `cma_college` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
