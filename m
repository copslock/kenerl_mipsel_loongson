Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Apr 2007 12:03:21 +0100 (BST)
Received: from topsns2.0.225.230.202.in-addr.arpa ([202.230.225.126]:41652
	"EHLO topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022423AbXDLLDU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Apr 2007 12:03:20 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 12 Apr 2007 20:03:18 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2B67F420D1;
	Thu, 12 Apr 2007 20:02:55 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 17AF7261FB;
	Thu, 12 Apr 2007 20:02:55 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l3CB2sW0059360;
	Thu, 12 Apr 2007 20:02:54 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 12 Apr 2007 20:02:54 +0900 (JST)
Message-Id: <20070412.200254.128619887.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix BUG(), BUG_ON() handling
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

With commit 63dc68a8cf60cb110b147dab1704d990808b39e2, kernel can not
handle BUG() and BUG_ON() properly since get_user() returns false for
kernel code.  Use __get_user() to skip unnecessary access_ok().  This
patch also make BRK_BUG code encoded in the TNE instruction.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7d76a85..56a770c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -650,7 +650,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
 	unsigned int opcode, bcode;
 	siginfo_t info;
 
-	if (get_user(opcode, (unsigned int __user *) exception_epc(regs)))
+	if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
 		goto out_sigsegv;
 
 	/*
@@ -700,7 +700,7 @@ asmlinkage void do_tr(struct pt_regs *regs)
 	unsigned int opcode, tcode = 0;
 	siginfo_t info;
 
-	if (get_user(opcode, (unsigned int __user *) exception_epc(regs)))
+	if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
 		goto out_sigsegv;
 
 	/* Immediate versions don't provide a code.  */
diff --git a/include/asm-mips/bug.h b/include/asm-mips/bug.h
index 4d560a5..7eb63de 100644
--- a/include/asm-mips/bug.h
+++ b/include/asm-mips/bug.h
@@ -18,7 +18,8 @@ do {									\
 
 #define BUG_ON(condition)						\
 do {									\
-	__asm__ __volatile__("tne $0, %0" : : "r" (condition));		\
+	__asm__ __volatile__("tne $0, %0, %1"				\
+			     : : "r" (condition), "i" (BRK_BUG));	\
 } while (0)
 
 #define HAVE_ARCH_BUG_ON
