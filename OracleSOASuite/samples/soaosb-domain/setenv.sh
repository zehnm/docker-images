#!/bin/sh
#
#===============================================
# MUST: Customize this to your local env
#===============================================
#
# Directory where all domains/db data etc are 
# kept. Directories will be created here
export DC_USERHOME=/docker/containers/oracle
#/mnt/Data/docker/containers/oracle

# Registry names where requisite standard images
# can be found
export DC_REGISTRY_SOA="localhost"

# Proxy Environment
export http_proxy=""
export https_proxy=""
export no_proxy=""

#===============================================
exportComposeEnv() {
  #
  export DC_HOSTNAME=`hostname -f`
  #
  # Used by Docker Compose from the env
  # Oracle DB Parameters
  #
  export DC_ORCL_PORT=1521
  export DC_ORCL_OEM_PORT=5500
  export DC_ORCL_SID=soadb
  export DC_ORCL_PDB=soapdb
  export DC_ORCL_SYSPWD=BFPrMz5C9Nk=1
#manager
  #
  export DC_ORCL_DBDATA=${DC_USERHOME}/dbdata-12.1
  #
  # AdminServer Password
  #
  export DC_ADMIN_PWD=manager1
  #
  # RCU Common password for all schemas + Prefix Names
  #
  export DC_RCU_SCHPWD=manager1
  export DC_RCU_SOAPFX=SOAOSB01
  #
  # Domain directories for the various domain types
  #
  export DC_DDIR_SOA=${DC_USERHOME}/soaosbdomain
  #
  # Default version to use for compose images
  #
  export DC_SOA_VERSION=12.2.1.2
}

#===============================================
createDirs() {
  mkdir -p ${DC_ORCL_DBDATA} ${DC_DDIR_SOA}
  chmod 777 ${DC_ORCL_DBDATA} ${DC_DDIR_SOA}
}

#===============================================
#== MAIN starts here
#===============================================
#
echo "INFO: Setting up SOA Docker Environment..."
exportComposeEnv
createDirs
echo "INFO: Environment variables"
env | grep -e "DC_" | sort
