Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0V0N2629451
	for linux-mips-outgoing; Wed, 30 Jan 2002 16:23:02 -0800
Received: from smtp014.mail.yahoo.com (smtp014.mail.yahoo.com [216.136.173.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0V0Mxd29448
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 16:22:59 -0800
Received: from i206042.ppp.asahi-net.or.jp (HELO nazneen) (61.125.206.42)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 30 Jan 2002 23:04:01 -0000
Message-ID: <006901c1a9e2$7c1c0a40$2ace7d3d@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: how to change page alignment.
Date: Thu, 31 Jan 2002 08:04:32 +0900
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

hello, all.

i am trying to bring up linux kernel 2.4.9 on LSI ez4021. our cpu core
supports page size of 16K. hence the mmu code is changed accordingly, for
kernel 2.4.9. but any command load fails giving page alignment error. seems
some problem from binfmt_elf.c file.

a command, say a shell ash, is build using egcc-2.91.66. to change the page
alignment the option given was "--n16384". this option is surely wrong,
hence could you tell me what is correct option? HOW TO CHANGE PAGE ALIGNMENT
TO 16K WHILE LINKING USER COMMANDS??

many thanks in advance & best regards,
girish.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
