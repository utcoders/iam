#!/usr/bin/python

import os, sys
selectTemplate('Basic WebLogic Server Domain')
loadTemplates()
showTemplates()
setOption('ServerStartMode','prod')
setOption('OverwriteDomain', 'true')
cd(r'/Security/base_domain/User/weblogic')
cmo.setPassword('###ADMIN_PASSWORD###')
cd(r'/Server/AdminServer')
cmo.setName('AdminServer')
cmo.setListenPort(###ADMIN_PORT###)
cmo.setListenAddress('###ADMIN_HOST###')
create('AdminServer','SSL')
cd('SSL/AdminServer')
cmo.setEnabled(true)
cmo.setListenPort(7002)
cmo.setHostnameVerificationIgnored(true)
cmo.setHostnameVerifier(None)
cmo.setTwoWaySSLEnabled(false)
writeDomain(r'###DOMAIN_HOME###')
closeTemplate()
exit()
