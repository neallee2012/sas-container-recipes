#!/bin/bash

#
# Copyright 2018 SAS Institute Inc.
#
# This work is licensed under a Creative Commons Attribution 4.0 International License.
# You may obtain a copy of the License at https://creativecommons.org/licenses/by/4.0/ 
#

# name: start.sh
# thanks jozwal for the ideas

#
# Start Viya
#	Remove unnecessary services and start remaining (in order)
#
rm -f /etc/init.d/sas-viya-alert-track-default
rm -f /etc/init.d/sas-viya-backup-agent-default
rm -f /etc/init.d/sas-viya-ops-agent-default
rm -f /etc/init.d/sas-viya-watch-log-default

#/etc/init.d/sas-viya-all-services start

# Run python scoring
su -c '/opt/anaconda3/bin/python3 /home/sasdemo/data/PythonScore.py' sasdemo
# Run performance report
su -c 'cd /home/sasdemo/data && export SSLCALISTLOC=/opt/sas/viya/config/etc/SASSecurityCertificateFramework/cacerts/trustedcerts.pem && /opt/sas/spre/home/bin/sas /home/sasdemo/data/Create_Performance_Report.sas' sasdemo

exit 0
