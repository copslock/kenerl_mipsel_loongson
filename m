Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2H1T2P16970
	for linux-mips-outgoing; Sat, 16 Mar 2002 17:29:02 -0800
Received: from smtp012.mail.yahoo.com (smtp012.mail.yahoo.com [216.136.173.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2H1Sx916967
	for <linux-mips@oss.sgi.com>; Sat, 16 Mar 2002 17:28:59 -0800
Received: from girishvg (AUTH login) at g054140.ppp.asahi-net.or.jp (HELO nazneen) (girishvg@211.132.54.140)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 17 Mar 2002 01:30:27 -0000
Message-ID: <00f601c1cd53$9c862060$8c3684d3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: Error loading shared libraries.
Date: Sun, 17 Mar 2002 10:32:30 +0900
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


Hello, all.
I know this is kind of weird problem at this point of time. I have a MIPS
board booted up with Linux 2.4.3 kernel. But it fails on the "init". I get
an error in the init process:

init: error in loading shared libraries
libutil.so.1: cannot map file data: Bad file descriptor ...

The compiler used is EGCS 2.91.66, downloaded from the net. Such error is
seen while loading any executable. I have a statically linked shell running.
Basically I dont know where the problem is. Please help me.
Many thanks in advance.
Girish.




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
