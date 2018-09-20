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

# Interfaces

There is one main interface used to receive the topology information. This is a JSON interface and uses exactly the same data model available in the information model. To see an example of the JSON just see the documentation of the senders. 


# Usage

- ./start.sh -i -> To show all the interfaces available in the system and identify their IDs
- ./start.sh -i 5 -> To start the FMA listening trafic on interface with ID 5
- ./start.sh -f filename.pcap -> to start the FMA from pcap file
- ./start.sh -z eth0 -> to start the FMA from pcap file

# Configuration File (config.ini)
-------------------------------------
The key value is the "NOTIFICATION METHOD" > "screen" only shown on screen. "rabbitmq" publsih it in RabbitMQ and "kafka" publish it on KAFKA. See the config.xml example available in the root folder where you can find a complete information for the meaning of all the configuration parameters of the tool. 

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
<properties>
<comment>IIM Configuration</comment>

<entry key="DB_URL">jdbc:mysql://10.10.0.11/topology</entry>
<entry key="DB_USER">root</entry>
<entry key="DB_PASS">password</entry>
<entry key="DB_DRIVER">com.mysql.jdbc.Driver</entry>

<entry key="NUMBER_OF_SUBSCRIPTIONS">1</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_VHOST">selfnet</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_IP">10.10.0.11</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_USER">selfnet</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_PASS">selfnet</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_PORT">5672</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_EXCHAGE_TYPE">topic</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_EXCHAGE_NAME">topology_events</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_QUEUE_NAME">iim</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_ROUTING_KEY">topology_events</entry>
<entry key="SUBSCRIPTION_0_RABBITMQ_QUEUE_HANDLER">org.uws.iim.logic.VirtualInfrastructureHandler</entry>

<entry key="DEBUG">false</entry>
</properties>
```

# Dependencies
It requires JDK 1.8 and the following libraries: (distributed for convenience)
- MySQL

# License
## Authors
5G Flow Monitoring Agent. Copyright (C) 2016-2018 Jose M. Alcaraz Calero, Enrique Chirivella Perez, Qi wang. University of the West of Scotland
  
## License
Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  
# Acknowledge
Software Supported by H2020 5G-PPP SELFNET PROJECT with project ID H2020-ICT-2014-2;



