Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 18:44:15 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:27525 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225541AbSLTSoO>;
	Fri, 20 Dec 2002 18:44:14 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 66D3FD657; Fri, 20 Dec 2002 19:50:23 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: put prototype of arc_console_init()
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 19:50:23 +0100
Message-ID: <m2hed8frtc.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this prototype is missing from that file.

Later, Juan.

Index: drivers/char/tty_io.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/tty_io.c,v
retrieving revision 1.62.2.8
diff -u -r1.62.2.8 tty_io.c
--- drivers/char/tty_io.c	11 Dec 2002 06:12:30 -0000	1.62.2.8
+++ drivers/char/tty_io.c	20 Dec 2002 18:39:50 -0000
@@ -159,6 +159,7 @@
 extern void tub3270_init(void);
 extern void rs285_console_init(void);
 extern void sa1100_rs_console_init(void);
+extern void arc_console_init(void);
 extern void sgi_serial_console_init(void);
 extern void sci_console_init(void);
 extern void dec_serial_console_init(void);


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
