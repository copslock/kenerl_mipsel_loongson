Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0Q8sfu17921
	for linux-mips-outgoing; Sat, 26 Jan 2002 00:54:41 -0800
Received: from smtp016.mail.yahoo.com (smtp016.mail.yahoo.com [216.136.174.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0Q8sbP17910
	for <linux-mips@oss.sgi.com>; Sat, 26 Jan 2002 00:54:37 -0800
Received: from e147195.ppp.asahi-net.or.jp (HELO nazneen) (211.13.147.195)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 26 Jan 2002 07:54:34 -0000
Message-ID: <009b01c1a63e$bf045580$c3930dd3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "Kevin D. Kissell" <kevink@mips.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <3C505900.9685DDE3@cotw.com> <003901c1a532$d01576e0$de920dd3@gol.com> <20020124174521.B8860@dea.linux-mips.net> <002b01c1a5c3$f1b71d80$10eca8c0@grendel>
Subject: Re: MIPS/Linux NonSGI
Date: Sat, 26 Jan 2002 16:54:53 +0900
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


hi, again.
thanks a lot for quick reply. re-compiled the kernels, using egcc-2.91, but
no luck. is there still older version i should be using? & i guess you were
referring to file arch/mips/mm/r4xx.c. the board support is detected &
load_mmu_r4k() is called. so this looks okay.
yes, LSI CPUs differ from the main stream, right in the cache opcodes. but
this problem apart, as i have been using kernel in un-cached mode & anyway i
have build almost all the commands by static linking. hence shared library
issue i shall deal with later.
***right now my main concern is file system getting corrupted. the
bdflush/update processes flushes the inode buffers & corrupts the fs. to be
precise the "update" process wakes up & writes some buffers to the disk from
the function sync_old_buffers() in fs/buffer.c. the pci-ide bus mastering
controller is non standard & that the driver is also self written. however
since reads from the disk are working as i can see all the commands getting
loaded & executed, the writes also should be working properly, as they
differ only in a command to the controller.
so where could be the problem? please help me.
many thanks & best regards,
girish.

ps. ralf, liked your comment abt my caps lock getting stuck;-) it just shows
how desperate i'm in solving this problem.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
