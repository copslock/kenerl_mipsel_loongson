Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:58:46 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:23788 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225415AbSLSK5k>;
	Thu, 19 Dec 2002 10:57:40 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 6D0BAD657; Thu, 19 Dec 2002 12:03:44 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	linux mips mailing list <linux-mips@linux-mips.org>
Subject: [PATCH]: minor code cleanup
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:03:44 +0100
Message-ID: <m265tql17z.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        once reading arc_con, found this.

Index: arch/mips/arc/arc_con.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/arc_con.c,v
retrieving revision 1.1.4.5
diff -u -r1.1.4.5 arc_con.c
--- arch/mips/arc/arc_con.c	7 Nov 2002 01:47:45 -0000	1.1.4.5
+++ arch/mips/arc/arc_con.c	19 Dec 2002 10:17:47 -0000
@@ -32,10 +32,7 @@
 
 static int __init prom_console_setup(struct console *co, char *options)
 {
-	if (prom_flags & PROM_FLAG_USE_AS_CONSOLE)
-		return 0;
-	else
-		return 1;
+	return !(prom_flags & PROM_FLAG_USE_AS_CONSOLE);
 }
 
 static struct console arc_cons = {


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
