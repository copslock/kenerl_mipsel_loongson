Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 12:43:32 +0000 (GMT)
Received: from smtp1.infineon.com ([IPv6:::ffff:194.175.117.76]:8076 "EHLO
	smtp1.infineon.com") by linux-mips.org with ESMTP
	id <S8225261AbTCDMnb>; Tue, 4 Mar 2003 12:43:31 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp1.infineon.com (8.12.2/8.12.2) with ESMTP id h24CYuKq002220
	for <linux-mips@linux-mips.org>; Tue, 4 Mar 2003 13:34:56 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <G2XXNXDF>; Tue, 4 Mar 2003 13:43:23 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B308@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: linux-mips@linux-mips.org
Subject: MIPS Linux NFS installation
Date: Tue, 4 Mar 2003 13:43:21 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

Hi everyone,
  I downloaded the RedHat 7.3 installation tar ball  from MIPS ftp server
and tried to install it from NFS server to a Malta board with an IDE hard
disk, but the kernel executed to the following place, it stopped.

YAMON> go

LINUX started...
..................................................  
Welcome to the MIPS installation of RedHat RPMS.

Install method (CD-ROM, NFS) [CD-ROM] NFS

IP-address of target system: [192.168.201.68] 192.168.149.116

IP-address of NFS server: [192.168.201.198] 192.168.149.5
Specify full path to RedHat-directory: [/export/RedHat]
/sbin/init: ./install.script: No such file or directory Kernel panic:
Attempted to kill init!



  Do you know the reason of this problem? 
  Thanks in advance!

  Best regards,

  Yidan Zhou 
