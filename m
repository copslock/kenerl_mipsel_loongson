Received:  by oss.sgi.com id <S305230AbQCaOxV>;
	Fri, 31 Mar 2000 06:53:21 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:2170 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305228AbQCaOxA>;
	Fri, 31 Mar 2000 06:53:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA00295; Fri, 31 Mar 2000 06:48:18 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA61407
	for linux-list;
	Fri, 31 Mar 2000 06:44:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA61815
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 06:44:49 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03252
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 06:44:43 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 96F1F7F4; Fri, 31 Mar 2000 16:44:42 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 058878FC3; Fri, 31 Mar 2000 16:35:07 +0200 (CEST)
Date:   Fri, 31 Mar 2000 16:35:07 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: obsolete/duplicate SCSI Config.in options
Message-ID: <20000331163507.E4726@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
small patch - Does show up more than once 


Index: drivers/scsi/Config.in
===================================================================
RCS file: /cvs/linux/drivers/scsi/Config.in,v
retrieving revision 1.25
diff -u -r1.25 Config.in
--- drivers/scsi/Config.in	2000/03/19 01:28:47	1.25
+++ drivers/scsi/Config.in	2000/03/31 14:36:14
@@ -40,16 +40,6 @@
    dep_tristate 'DEC SII Scsi Driver' CONFIG_SCSI_DECSII $CONFIG_SCSI
 fi
 
-if [ "$CONFIG_SGI_IP22" = "y" ]; then
-   dep_tristate 'SGI WD93C93 SCSI Driver' CONFIG_SCSI_SGIWD93 $CONFIG_SCSI
-fi
-if [ "$CONFIG_DECSTATION" = "y" ]; then
-   if [ "$CONFIG_TC" = "y" ]; then
-      dep_tristate 'DEC NCR53C94 Scsi Driver' CONFIG_SCSI_DECNCR $CONFIG_SCSI
-   fi
-   dep_tristate 'DEC SII Scsi Driver' CONFIG_SCSI_DECSII $CONFIG_SCSI
-fi
-
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate '3ware Hardware ATA-RAID support' CONFIG_BLK_DEV_3W_XXXX_RAID $CONFIG_SCSI
 fi

-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
