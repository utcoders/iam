#!/bin/bash
set -x
sed -i -e "s|###ADMIN_PASSWORD###|$ADMIN_PASSWORD|g" "$1"
sed -i -e "s|###DB_SCHEMA_PASSWORD###|$DB_SCHEMA_PASSWORD|g" "$1"
sed -i -e "s|###OIM_HOST###|$OIM_HOST|g" "$1"
sed -i -e "s|###SOA_HOST###|$SOA_HOST|g" "$1"
sed -i -e "s|###CONNECTION_STRING###|$CONNECTION_STRING|g" "$1"
sed -i -e "s|###DOMAIN_HOME###|$DOMAIN_HOME|g" "$1"
sed -i -e "s|###DOMAIN_NAME###|$DOMAIN_NAME|g" "$1"
sed -i -e "s|###ORACLE_HOME###|$ORACLE_HOME|g" "$1"
sed -i -e "s|###ADMIN_HOST###|$ADMIN_HOST|g" "$1"
sed -i -e "s|###ADMIN_PORT###|$ADMIN_PORT|g" "$1"
sed -i -e "s|###MW_HOME###|$MW_HOME|g" "$1"
sed -i -e "s|###RCUPREFIX###|$RCUPREFIX|g" "$1"
sed -i -e "s|###KEYSTORE_PASSWORD###|$KEYSTORE_PASSWORD|g" "$1"
sed -i -e "s|###ADMIN_USER###|$ADMIN_USER|g" "$1"