Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0P0upE31404
	for linux-mips-outgoing; Thu, 24 Jan 2002 16:56:51 -0800
Received: from smtp015.mail.yahoo.com (smtp015.mail.yahoo.com [216.136.173.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0P0ujP31359
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 16:56:45 -0800
Received: from e146222.ppp.asahi-net.or.jp (HELO nazneen) (211.13.146.222)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 24 Jan 2002 23:56:41 -0000
Message-ID: <003901c1a532$d01576e0$de920dd3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <3C505900.9685DDE3@cotw.com>
Subject: MIPS/Linux NonSGI
Date: Fri, 25 Jan 2002 08:41:10 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello all.
i'm trying to bringup linux 2.4.[2|9] on our board based on LSI mips r4k
core.
right now the kernel compiled with gcc-3.0, boots up & can only work with
statically linked commands. hence the root file system mounted from
ramdisk,nfs, & de-dream ide-disk can show some-prompt only if ash.static is
invoked.
this is seen with 2.4.3 & ditto with 2.4.9. the kernel is in un-cached
mode,since we have page-size problem with our core in cached, write
through/back
both, modes. so question is WHY THE COMMANDS WITH SHARED LIBRARY DONOT WORK.
FAILS TO LOAD SHARED LIBRARIES.

the problem no.2 is root on ide-disk. the disk is paritioned & formatted
using a linux pentium-pc. using a master disk the above said statically
linked commands are downloaded to slave disk. the board boots up. however
the bdflush/update process corrupts file-system. the UPDATE PROCESS CORRUPTS
SUPERBLOCK AND INODES WHILE FLUSHING THE DIRTY BUFERS.

PLEASE! PLEASE!! HELP ME ON THIS. THIS NEWSGROUP IS MY LAST HOPE.

many thanks in advance with regards,
girish.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
