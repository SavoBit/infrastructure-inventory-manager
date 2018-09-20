CREATE DATABASE topology;
USE topology;

CREATE TABLE `vm` (
  `tenantId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `userId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `location` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hostName` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hostIp` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `instanceId` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  `uuid` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `name` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `imageId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `state` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `resourceId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `reportedTime` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`instanceId`)
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

CREATE TABLE `vmnetworks` (
  `uuid` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `vmIp` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `networkId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `mac` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `iface` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `portId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `dhcp` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `segmentationId` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ovsId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `gateway` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `dns` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `resourceId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `reportedTime` BIGINT(20) DEFAULT NULL
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

CREATE TABLE `pm` (
  `hostname` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ip` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `location` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `networkId` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `state` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `resourceIdHost` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `resourceIdNic` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `reportedTime` BIGINT(20) DEFAULT NULL
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

CREATE TABLE `lte` (
  `UEId` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL,
  `mmeTeidS11` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `sgwTeidS11` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `epsBearerId` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IMSI` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `MCC` VARCHAR(5) COLLATE latin1_swedish_ci DEFAULT NULL,
  `MNC` VARCHAR(5) COLLATE latin1_swedish_ci DEFAULT NULL,
  `MMEIp` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `sgwTeidS1` VARCHAR(20) DEFAULT NULL,
  `enbTeidS1u` VARCHAR(20) DEFAULT NULL,
  `sgwIPS1U` VARCHAR(20) DEFAULT NULL,
  `enbIPS1U` VARCHAR(20) DEFAULT NULL,
  `UEIP` VARCHAR(20) DEFAULT NULL,
  `reportedTime` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`UEId`)
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;