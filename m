Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5FsYZ09049
	for linux-mips-outgoing; Wed, 5 Dec 2001 07:54:34 -0800
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5FsVo09044
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 07:54:31 -0800
Received: from 63.70.210.4 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 05 Dec 2001 06:54:16 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from dns-blr-2.blr.broadcom.com ([10.132.16.11]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id GAA21793 for
 <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 06:54:28 -0800 (PST)
Received: from adm-blr-001.blr.broadcom.com (adm-blr-001 [10.132.16.111]
 ) by dns-blr-2.blr.broadcom.com (8.9.1b+Sun/8.9.1) with ESMTP id
 UAA12488 for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 20:17:14 +0530 (
 IST)
Received: from broadcom.com ([10.132.64.110]) by
 adm-blr-001.blr.broadcom.com (8.9.1/8.9.1) with ESMTP id UAA18381 for
 <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 20:17:18 +0530 (IST)
Message-ID: <3C0E3628.9096FFF6@broadcom.com>
Date: Wed, 05 Dec 2001 20:28:48 +0530
From: Nitin <nitin.borle@broadcom.com>
X-Mailer: Mozilla 4.51 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Booting from IDE
X-WSS-ID: 1010EA92127799-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
I have a very basic query. I have a MIPS Malta board. I attached a IDE
hard disk to it and installed linux as per the instructions. At the end
of the installation, system rebooted and control gone to the board
monitor program(Yamon). How can I get the linux prompt? Do I need to
write an application program which will read boot sector from hard disk,

store it in memory and pass on control to that particular location?(If
yes, is such application already available?) Or is there a other way of
doing it.

Thanks,
Nitin
