Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 19:50:18 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:9856 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225473AbSLSTuS>;
	Thu, 19 Dec 2002 19:50:18 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 9B098D657; Thu, 19 Dec 2002 20:56:18 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: put show_regs in a header file
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 20:56:18 +0100
Message-ID: <m21y4dkckd.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this is the same place where it is exported in 32 bits.

Later, Juan.

Index: include/asm-mips64/ptrace.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/ptrace.h,v
retrieving revision 1.6.4.3
diff -u -r1.6.4.3 ptrace.h
--- include/asm-mips64/ptrace.h	27 Jun 2002 14:21:24 -0000	1.6.4.3
+++ include/asm-mips64/ptrace.h	19 Dec 2002 19:48:51 -0000
@@ -76,6 +76,7 @@
 #ifndef __ASSEMBLY__
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 
+extern void show_regs(struct pt_regs *);
 #endif /* !__ASSEMBLY__ */
 
 #endif


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
