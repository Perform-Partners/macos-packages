#!/bin/sh

#  assistAgentPostInstall.sh
#  ZohoAssistAgent
#
#  Created by Boopathy P on 15/12/16.
#  Copyright © 2016 Boopathy P. All rights reserved.

daemonPlistPath="/Library/LaunchDaemons/com.zoho.assist.ZohoUnattended.plist"
preLoginPlistPath="/Library/LaunchAgents/com.zoho.assist.ZAPreLogin.plist"
perUserPlistPath="/Library/LaunchAgents/com.zoho.assist.PerUserAgent.plist"

#give root permission

chown root:admin $daemonPlistPath
chown root:wheel $preLoginPlistPath
chown root:wheel $perUserPlistPath

echo "return code chown plist:$?"

chmod 644 $daemonPlistPath
chmod 644 $preLoginPlistPath
chmod 644 $perUserPlistPath

launchctl load -wF $preLoginPlistPath
list=$(users)
for user in $list
do
uid=$(id -u $user)
launchctl asuser $uid launchctl unload -wF $perUserPlistPath
launchctl asuser $uid launchctl load -wF $perUserPlistPath
done


launchctl load -wF $daemonPlistPath

echo "return code chown plist:$?"
