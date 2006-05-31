Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 18:00:19 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:465 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133543AbWEaP7s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 17:59:48 +0200
Received: from localhost (p5040-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C4C97B720; Thu,  1 Jun 2006 00:59:44 +0900 (JST)
Date:	Thu, 01 Jun 2006 01:00:39 +0900 (JST)
Message-Id: <20060601.010039.93207406.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix some sparse warnings (constant is so big)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix following warnings:
linux/arch/mips/kernel/setup.c:249:12: warning: constant 0xffffffff00000000 is so big it is unsigned long
linux/arch/mips/kernel/cpu-bugs64.c:209:10: warning: constant 0xffffffffffffdb9a is so big it is unsigned long
linux/arch/mips/kernel/cpu-bugs64.c:227:10: warning: constant 0xffffffffffffdb9a is so big it is unsigned long
linux/arch/mips/kernel/cpu-bugs64.c:283:10: warning: constant 0xffffffffffffdb9a is so big it is unsigned long
linux/arch/mips/kernel/cpu-bugs64.c:299:10: warning: constant 0xffffffffffffdb9a is so big it is unsigned long

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index 47a087b..d268827 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -206,7 +206,7 @@ static inline void check_daddi(void)
 		"daddi	%0, %1, %3\n\t"
 		".set	pop"
 		: "=r" (v), "=&r" (tmp)
-		: "I" (0xffffffffffffdb9a), "I" (0x1234));
+		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 	set_except_vector(12, handler);
 	local_irq_restore(flags);
 
@@ -224,7 +224,7 @@ static inline void check_daddi(void)
 		"dsrl	%1, %1, 1\n\t"
 		"daddi	%0, %1, %3"
 		: "=r" (v), "=&r" (tmp)
-		: "I" (0xffffffffffffdb9a), "I" (0x1234));
+		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 	set_except_vector(12, handler);
 	local_irq_restore(flags);
 
@@ -280,7 +280,7 @@ static inline void check_daddiu(void)
 		"daddu	%1, %2\n\t"
 		".set	pop"
 		: "=&r" (v), "=&r" (w), "=&r" (tmp)
-		: "I" (0xffffffffffffdb9a), "I" (0x1234));
+		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 
 	if (v == w) {
 		printk("no.\n");
@@ -296,7 +296,7 @@ static inline void check_daddiu(void)
 		"addiu	%1, $0, %4\n\t"
 		"daddu	%1, %2"
 		: "=&r" (v), "=&r" (w), "=&r" (tmp)
-		: "I" (0xffffffffffffdb9a), "I" (0x1234));
+		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 
 	if (v == w) {
 		printk("yes.\n");
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bcf1b10..132b65d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -246,7 +246,7 @@ static inline int parse_rd_cmdline(unsig
 #ifdef CONFIG_64BIT
 	/* HACK: Guess if the sign extension was forgotten */
 	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
-		start |= 0xffffffff00000000;
+		start |= 0xffffffff00000000UL;
 #endif
 
 	end = start + size;
