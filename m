Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48HLtwJ003572
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 10:21:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48HLtoe003571
	for linux-mips-outgoing; Wed, 8 May 2002 10:21:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48HLqwJ003567
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 10:21:52 -0700
Received: from whrrusek (whnat1.weiderpub.com [65.115.104.67])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g48HNJF01827
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 10:23:19 -0700
From: "Robert Rusek" <rrusek@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: Indy SCSI Errors
Date: Wed, 8 May 2002 10:23:18 -0700
Message-ID: <C0F41630CD8B9C4680F2412914C1CF070164BD@WH-EXCHANGE1.AD.WEIDERPUB.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am currently running kernel 2.4.17 and am getting sparatice errors
like the following.  I seen that there had been bugs in the scsi driver
in the earlier kernel versions.  Has anyone encountered this?  Is there
a newer kernal that maybe addresses this?


EXT2-fs error (device sd(8,1)): ext2_check_page: bad entry in directory
#110030: unaligned
 directory entry - offset=0, inode=6226015, rec_len=95, name_len=95

Thank you in advance,
--
Robert Rusek
