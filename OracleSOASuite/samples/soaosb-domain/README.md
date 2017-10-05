# AdminServer with one managed OSB and one managed SOA server

## Prerequisites
   - Create JDK 8 base image: https://github.com/oracle/docker-images/tree/master/OracleJava 
   - Create Oracle FMW Infrastructure base image: https://github.com/oracle/docker-images/tree/master/OracleFMWInfrastructure

## Setup
1. **FIRST TIME ONLY:**
   - Update the `OracleSOASuite/setenv.sh` file to point
     to the right locations for the following environment variables
     specific to your environment (See top of file):
     `DC_USERHOME`, `DC_REGISTRY_SOA`

2. Setup your current environment (running `bash`)

       # cd OracleSOASuite/samples/soaosb-domain
       # source setenv.sh

3. Setup and start the Database container
   - Ensure port 1521 is free for use for the database

         netstat -an | grep 1521
   - Start the DB Container

         docker-compose up -d soadb
         docker logs -f soadb

4. Starting the Admin Server (AS) container. 
    - **Ensure Database is up first**
    - Start AS - First Run will run RCU and create the SOA schemas, 
      Create the needed SOA-OSB Domain and Start the Admin Server
    - Subsequent runs will just start the already configured Admin Server

          docker-compose up -d soaosbas
          docker logs -f soaosbas

5.  Starting the Managed OSB Server (MS) container 
    - **Ensure the Admin Server is up first**, then run:

          docker-compose up -d soaosb-osbms
          docker logs -f osbms

6.  Starting the Managed SOA Server (MS) container 
    - **Ensure the Admin Server is up first**, then run:

          docker-compose up -d soaosb-soams
          docker logs -f soams
