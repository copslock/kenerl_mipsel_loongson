Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2IFCZv31067
	for linux-mips-outgoing; Mon, 18 Mar 2002 07:12:35 -0800
Received: from smtp016.mail.yahoo.com (smtp016.mail.yahoo.com [216.136.174.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2IFCW931064
	for <linux-mips@oss.sgi.com>; Mon, 18 Mar 2002 07:12:32 -0800
Received: from girishvg (AUTH login) at g054124.ppp.asahi-net.or.jp (HELO nazneen) (girishvg@211.132.54.124)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 18 Mar 2002 15:13:58 -0000
Message-ID: <033401c1ce8f$cbec7100$ebcc7d3d@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: PCI VGA Card Initilization (SIS6326 / PT80)
Date: Tue, 19 Mar 2002 00:15:51 +0900
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
i have a PCI/VGA card PT80 with SIS6326 chipset. i am using MILO BIOS source
code. but i am not able to access the internal buffer which is typically at
0xA0000. even the BIOS ROM (0xC0000) read fails to show default value
0xA5A5. the expansion ROM is enabled in PCI by setting D0 bit to 1. however
IO seems okay because the monitor actually switches from power down mode to
normal mode. i have tried using both vgaraw1.c and vgaraw2.c files, but no
success. could anybody help me to solve this problem.
many thanks.
girish.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
