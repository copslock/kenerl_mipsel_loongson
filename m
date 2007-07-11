Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 15:29:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:9970 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021458AbXGKO3u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 15:29:50 +0100
Received: from localhost (p7242-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ABB00B5FA; Wed, 11 Jul 2007 23:29:46 +0900 (JST)
Date:	Wed, 11 Jul 2007 23:30:40 +0900 (JST)
Message-Id: <20070711.233040.74565287.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Change names of local variables to silence sparse (part 2)
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
X-archive-position: 15693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch is an workaround for these sparse warnings:

include2/asm/mmu_context.h:172:2: warning: symbol 'flags' shadows an earlier one
include2/asm/mmu_context.h:133:16: originally declared here
include2/asm/mmu_context.h:232:2: warning: symbol 'flags' shadows an earlier one
include2/asm/mmu_context.h:203:16: originally declared here
include2/asm/mmu_context.h:277:3: warning: symbol 'flags' shadows an earlier one
include2/asm/mmu_context.h:250:16: originally declared here

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/mipsregs.h b/include/asm-mips/mipsregs.h
index 706b369..18f47f1 100644
--- a/include/asm-mips/mipsregs.h
+++ b/include/asm-mips/mipsregs.h
@@ -707,10 +707,10 @@ do {									\
  */
 #define __read_64bit_c0_split(source, sel)				\
 ({									\
-	unsigned long long val;						\
-	unsigned long flags;						\
+	unsigned long long __val;					\
+	unsigned long __flags;						\
 									\
-	local_irq_save(flags);						\
+	local_irq_save(__flags);					\
 	if (sel == 0)							\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
@@ -719,7 +719,7 @@ do {									\
 			"dsrl\t%M0, %M0, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
 			".set\tmips0"					\
-			: "=r" (val));					\
+			: "=r" (__val));				\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
@@ -728,17 +728,17 @@ do {									\
 			"dsrl\t%M0, %M0, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
 			".set\tmips0"					\
-			: "=r" (val));					\
-	local_irq_restore(flags);					\
+			: "=r" (__val));				\
+	local_irq_restore(__flags);					\
 									\
-	val;								\
+	__val;								\
 })
 
 #define __write_64bit_c0_split(source, sel, val)			\
 do {									\
-	unsigned long flags;						\
+	unsigned long __flags;						\
 									\
-	local_irq_save(flags);						\
+	local_irq_save(__flags);					\
 	if (sel == 0)							\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
@@ -759,7 +759,7 @@ do {									\
 			"dmtc0\t%L0, " #source ", " #sel "\n\t"		\
 			".set\tmips0"					\
 			: : "r" (val));					\
-	local_irq_restore(flags);					\
+	local_irq_restore(__flags);					\
 } while (0)
 
 #define read_c0_index()		__read_32bit_c0_register($0, 0)
