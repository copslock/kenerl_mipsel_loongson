Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:37:54 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:51684 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225320AbSLRBhE>;
	Wed, 18 Dec 2002 01:37:04 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id DF6CBD657; Wed, 18 Dec 2002 02:43:00 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: remove unused label
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:00 +0100
Message-ID: <m2hedcqezf.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this label is not used in the code

Later, Juan.

Index: arch/mips/mm/fault.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/fault.c,v
retrieving revision 1.25.2.9
diff -u -r1.25.2.9 fault.c
--- arch/mips/mm/fault.c	14 Sep 2002 23:12:50 -0000	1.25.2.9
+++ arch/mips/mm/fault.c	18 Dec 2002 00:49:18 -0000
@@ -159,7 +159,6 @@
 bad_area:
 	up_read(&mm->mmap_sem);
 
-bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		tsk->thread.cp0_badvaddr = address;


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
