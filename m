Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1J0DxN02903
	for linux-mips-outgoing; Mon, 18 Feb 2002 16:13:59 -0800
Received: from smtp013.mail.yahoo.com (smtp013.mail.yahoo.com [216.136.173.57])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1J0Dv902900
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 16:13:57 -0800
Received: from g055068.ppp.asahi-net.or.jp (HELO nazneen) (211.132.55.68)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 18 Feb 2002 23:13:56 -0000
Message-ID: <002301c1b8d2$22a0efe0$443784d3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: <linux-mips@oss.sgi.com>
Subject: Page Size 16KB.
Date: Tue, 19 Feb 2002 08:15:18 +0900
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

hi, all.
while in the process of changing page size of kernel to 16KB i am facing a
strange problem. the kernel boots up & user command, currently statically
linked shell, loads. it displays first prompt.  pressing enter keys, the
serial device receives the interrupts but no activity on shell's part. where
could the shell possibly be stuck?
this is LSI MIPS EZ4021 implementation. please please help!!!
many thanks & regards,
girish.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
