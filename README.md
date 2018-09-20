# Infrastructure Inventory Manager

-----
Key | Value
------------ | -------------
Name | Infrastructure Inventory Manager
Acronym | IIM
Use case | ALL
Instantiation | Physical Network Function (PNF) 
Type | Inventory Collector
Scope  | Resources
Management Protocol | XML
Deliverable | [3.4](https://github.com/Selfnet-5G/WP3_SO/blob/master/Doku/D3.4/D3.4_master.pdf) 

------

# Description

The IIM is a component that oversees making the persistence of all the topological changes being reported 
by both Topology Manager and LTE Topology Manager. The persistence is stored a MySQL data base with the following 
information model. The persistence is not a mere log but a complete management of the life cycle of the resource entities allow
to have a repository where the current state of a resource and its associated information to perform spatial aggregation 
in order to allow to be queried if required by a simple SELECT into the database. 

# Information Model

```sql
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
  PRIMARY KEY USING BTREE (`instanceId`)
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

CREATE TABLE `vmnetworks` (
  `instanceId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `vmIp` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `networkId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `mac` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `iface` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `portId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `dhcp` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `segmentationId` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ovsId` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `gateway` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `dns` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

CREATE TABLE `pm` (
  `hostname` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ip` VARCHAR(15) COLLATE latin1_swedish_ci DEFAULT NULL,
  `location` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `networkId` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `state` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL
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
  `sgwTeidS1` INTEGER(11) DEFAULT NULL,
  `enbTeidS1u` INTEGER(11) DEFAULT NULL,
  `sgwIPS1U` INTEGER(11) DEFAULT NULL,
  `enbIPS1U` INTEGER(11) DEFAULT NULL,
  `UEIP` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`UEId`)
) ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;
```
