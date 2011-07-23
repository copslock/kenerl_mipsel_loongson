Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:42:24 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491188Ab1GWMlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:23 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWF-0003ui-HM; Sat, 23 Jul 2011 14:41:23 +0200
Message-Id: <20110723124016.049746199@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:23 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 2/7] mips: ftrace: Fix the CONFIG_DYNAMIC_FTRACE=n compile
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline;
 filename=mips-ftrace-fix-non-dynamic-crappola.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16785

arch/mips/kernel/ftrace.c: In function ‘ftrace_get_parent_ra_addr’:
arch/mips/kernel/ftrace.c:212: error: implicit declaration of function ‘in_kernel_space’
arch/mips/kernel/ftrace.c: In function ‘prepare_ftrace_return’:
arch/mips/kernel/ftrace.c:314: error: ‘MCOUNT_OFFSET_INSNS’ undeclared (first use in this function)
arch/mips/kernel/ftrace.c:314: error: (Each undeclared identifier is reported only once
arch/mips/kernel/ftrace.c:314: error: for each function it appears in.)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/ftrace.c |   39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

Index: linux-2.6/arch/mips/kernel/ftrace.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ftrace.c
+++ linux-2.6/arch/mips/kernel/ftrace.c
@@ -19,6 +19,26 @@
 
 #include <asm-generic/sections.h>
 
+#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
+#define MCOUNT_OFFSET_INSNS 5
+#else
+#define MCOUNT_OFFSET_INSNS 4
+#endif
+
+/*
+ * Check if the address is in kernel space
+ *
+ * Clone core_kernel_text() from kernel/extable.c, but doesn't call
+ * init_kernel_text() for Ftrace doesn't trace functions in init sections.
+ */
+static inline int in_kernel_space(unsigned long ip)
+{
+	if (ip >= (unsigned long)_stext &&
+	    ip <= (unsigned long)_etext)
+		return 1;
+	return 0;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
@@ -54,20 +74,6 @@ static inline void ftrace_dyn_arch_init_
 #endif
 }
 
-/*
- * Check if the address is in kernel space
- *
- * Clone core_kernel_text() from kernel/extable.c, but doesn't call
- * init_kernel_text() for Ftrace doesn't trace functions in init sections.
- */
-static inline int in_kernel_space(unsigned long ip)
-{
-	if (ip >= (unsigned long)_stext &&
-	    ip <= (unsigned long)_etext)
-		return 1;
-	return 0;
-}
-
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
 	int faulted;
@@ -112,11 +118,6 @@ static int ftrace_modify_code(unsigned l
  *                                  1: offset = 4 instructions
  */
 
-#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
-#define MCOUNT_OFFSET_INSNS 5
-#else
-#define MCOUNT_OFFSET_INSNS 4
-#endif
 #define INSN_B_1F (0x10000000 | MCOUNT_OFFSET_INSNS)
 
 int ftrace_make_nop(struct module *mod,
