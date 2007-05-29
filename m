Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2007 15:04:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:46340 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022734AbXE2OEb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 May 2007 15:04:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 348C5E1C92;
	Tue, 29 May 2007 16:03:50 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VngYWRDBcvRZ; Tue, 29 May 2007 16:03:49 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B6ADCE1C63;
	Tue, 29 May 2007 16:03:49 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l4TE40Hc002134;
	Tue, 29 May 2007 16:04:00 +0200
Date:	Tue, 29 May 2007 15:03:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] die(): Properly declare as non-returning
Message-ID: <Pine.LNX.4.64N.0705291456520.14456@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3322/Tue May 29 11:46:18 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This marks the declaration of die() correctly, removing "control reaches 
end of non-void function" warnings from non-void functions that die() at 
the end.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 I've noticed there is an ongoing discussion about the use of NORET_TYPE 
and ATTRIB_NORET, but until that is resolved this change is useful.

 Please apply.

  Maciej

patch-mips-2.6.21-20070502-die-noret-0
diff -up --recursive --new-file linux-mips-2.6.21-20070502.macro/include/asm-mips/ptrace.h linux-mips-2.6.21-20070502/include/asm-mips/ptrace.h
--- linux-mips-2.6.21-20070502.macro/include/asm-mips/ptrace.h	2007-02-21 05:57:58.000000000 +0000
+++ linux-mips-2.6.21-20070502/include/asm-mips/ptrace.h	2007-05-27 21:15:00.000000000 +0000
@@ -86,7 +86,7 @@ struct pt_regs {
 
 extern asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit);
 
-extern NORET_TYPE void die(const char *, struct pt_regs *);
+extern NORET_TYPE void die(const char *, struct pt_regs *) ATTRIB_NORET;
 
 static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 {
