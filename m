Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2012 23:53:16 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:3191 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903348Ab2ICVxH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2012 23:53:07 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 03 Sep 2012 14:51:21 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 3 Sep 2012 14:52:44 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id CE7059F9F5; Mon, 3
 Sep 2012 14:52:43 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     ddaney.cavm@gmail.com, cernekee@gmail.com,
        "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH V3 2/2] MIPS: make funcs preempt-safe for non-mipsr2
 cpus
Date:   Mon, 3 Sep 2012 17:52:17 -0400
Message-ID: <1346709137-3448-2-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1346709137-3448-1-git-send-email-jim2101024@gmail.com>
References: <y> <1346709137-3448-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C5BF9D33NK22813710-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

For non MIPSr2 processors, such as the BMIPS 5000, calls to
arch_local_irq_disable() and others may be preempted, and in doing
so a stale value may be restored to c0_status.  This fix disables
preemption for such processors prior to the call and enables it
after the call.

Those functions that needed this fix have been "outlined" to
mips-atomic.c, as they are no longer good candidates for inlining.

This bug was observed in a BMIPS 5000, occuring once every few hours
in a continuous reboot test.  It was traced to the write_lock_irq()
function which was being invoked in release_task() in exit.c.
By placing a number of "nops" inbetween the mfc0/mtc0 pair in
arch_local_irq_disable(), which is called by write_lock_irq(), we
were able to greatly increase the occurance of this bug.  Similarly,
the application of this commit silenced the bug.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/irqflags.h |   92 +++++---------------
 arch/mips/lib/Makefile           |    3 +-
 arch/mips/lib/mips-atomic.c      |  179 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 72 deletions(-)
 create mode 100644 arch/mips/lib/mips-atomic.c

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 309cbcd..9174d88 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -16,6 +16,15 @@
 #include <linux/compiler.h>
 #include <asm/hazards.h>
 
+#if !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MT_SMTC)
+/* Functions that require preempt_{dis,en}able() are in mips-atomic.c */
+extern void arch_local_irq_disable(void);
+extern unsigned long arch_local_irq_save(void);
+extern void arch_local_irq_restore(unsigned long flags);
+extern void __arch_local_irq_restore(unsigned long flags);
+#endif
+
+
 __asm__(
 	"	.macro	arch_local_irq_enable				\n"
 	"	.set	push						\n"
@@ -57,42 +66,12 @@ static inline void arch_local_irq_enable(void)
 }
 
 
-/*
- * For cli() we have to insert nops to make sure that the new value
- * has actually arrived in the status register before the end of this
- * macro.
- * R4000/R4400 need three nops, the R4600 two nops and the R10000 needs
- * no nops at all.
- */
-/*
- * For TX49, operating only IE bit is not enough.
- *
- * If mfc0 $12 follows store and the mfc0 is last instruction of a
- * page and fetching the next instruction causes TLB miss, the result
- * of the mfc0 might wrongly contain EXL bit.
- *
- * ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
- *
- * Workaround: mask EXL bit of the result or place a nop before mfc0.
- */
+#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MT_SMTC)
 __asm__(
 	"	.macro	arch_local_irq_disable\n"
 	"	.set	push						\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	$1, $2, 1					\n"
-	"	ori	$1, 0x400					\n"
-	"	.set	noreorder					\n"
-	"	mtc0	$1, $2, 1					\n"
-#elif defined(CONFIG_CPU_MIPSR2)
 	"	di							\n"
-#else
-	"	mfc0	$1,$12						\n"
-	"	ori	$1,0x1f						\n"
-	"	xori	$1,0x1f						\n"
-	"	.set	noreorder					\n"
-	"	mtc0	$1,$12						\n"
-#endif
 	"	irq_disable_hazard					\n"
 	"	.set	pop						\n"
 	"	.endm							\n");
@@ -105,6 +84,8 @@ static inline void arch_local_irq_disable(void)
 		: /* no inputs */
 		: "memory");
 }
+#endif
+
 
 __asm__(
 	"	.macro	arch_local_save_flags flags			\n"
@@ -125,27 +106,15 @@ static inline unsigned long arch_local_save_flags(void)
 	return flags;
 }
 
+
+#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MT_SMTC)
 __asm__(
 	"	.macro	arch_local_irq_save result			\n"
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	\\result, $2, 1					\n"
-	"	ori	$1, \\result, 0x400				\n"
-	"	.set	noreorder					\n"
-	"	mtc0	$1, $2, 1					\n"
-	"	andi	\\result, \\result, 0x400			\n"
-#elif defined(CONFIG_CPU_MIPSR2)
 	"	di	\\result					\n"
 	"	andi	\\result, 1					\n"
-#else
-	"	mfc0	\\result, $12					\n"
-	"	ori	$1, \\result, 0x1f				\n"
-	"	xori	$1, 0x1f					\n"
-	"	.set	noreorder					\n"
-	"	mtc0	$1, $12						\n"
-#endif
 	"	irq_disable_hazard					\n"
 	"	.set	pop						\n"
 	"	.endm							\n");
@@ -159,20 +128,16 @@ static inline unsigned long arch_local_irq_save(void)
 		     : "memory");
 	return flags;
 }
+#endif
 
+
+#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MT_SMTC)
 __asm__(
 	"	.macro	arch_local_irq_restore flags			\n"
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"mfc0	$1, $2, 1						\n"
-	"andi	\\flags, 0x400						\n"
-	"ori	$1, 0x400						\n"
-	"xori	$1, 0x400						\n"
-	"or	\\flags, $1						\n"
-	"mtc0	\\flags, $2, 1						\n"
-#elif defined(CONFIG_CPU_MIPSR2) && defined(CONFIG_IRQ_CPU)
+#if defined(CONFIG_IRQ_CPU)
 	/*
 	 * Slow, but doesn't suffer from a relatively unlikely race
 	 * condition we're having since days 1.
@@ -181,20 +146,13 @@ __asm__(
 	"	 di							\n"
 	"	ei							\n"
 	"1:								\n"
-#elif defined(CONFIG_CPU_MIPSR2)
+#else
 	/*
 	 * Fast, dangerous.  Life is fun, life is good.
 	 */
 	"	mfc0	$1, $12						\n"
 	"	ins	$1, \\flags, 0, 1				\n"
 	"	mtc0	$1, $12						\n"
-#else
-	"	mfc0	$1, $12						\n"
-	"	andi	\\flags, 1					\n"
-	"	ori	$1, 0x1f					\n"
-	"	xori	$1, 0x1f					\n"
-	"	or	\\flags, $1					\n"
-	"	mtc0	\\flags, $12					\n"
 #endif
 	"	irq_disable_hazard					\n"
 	"	.set	pop						\n"
@@ -205,16 +163,6 @@ static inline void arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC kernel needs to do a software replay of queued
-	 * IPIs, at the cost of branch and call overhead on each
-	 * local_irq_restore()
-	 */
-	if (unlikely(!(flags & 0x0400)))
-		smtc_ipi_replay();
-#endif
-
 	__asm__ __volatile__(
 		"arch_local_irq_restore\t%0"
 		: "=r" (__tmp1)
@@ -232,6 +180,8 @@ static inline void __arch_local_irq_restore(unsigned long flags)
 		: "0" (flags)
 		: "memory");
 }
+#endif
+
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index a7b8937..eeddc58 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -3,7 +3,8 @@
 #
 
 lib-y	+= bitops.o csum_partial.o delay.o memcpy.o memset.o \
-	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o
+	   mips-atomic.o strlen_user.o strncpy_user.o \
+	   strnlen_user.o uncached.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
new file mode 100644
index 0000000..546eb25
--- /dev/null
+++ b/arch/mips/lib/mips-atomic.c
@@ -0,0 +1,179 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994, 95, 96, 97, 98, 99, 2003 by Ralf Baechle
+ * Copyright (C) 1996 by Paul M. Antoine
+ * Copyright (C) 1999 Silicon Graphics
+ * Copyright (C) 2000 MIPS Technologies, Inc.
+ */
+#include <asm/irqflags.h>
+#include <asm/hazards.h>
+#include <linux/compiler.h>
+#include <linux/preempt.h>
+
+#if !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC)
+
+#if defined(CONFIG_PREEMPT)
+#define arch_local_preempt_enable() preempt_enable()
+#define arch_local_preempt_disable() preempt_disable()
+#else
+#define arch_local_preempt_enable()
+#define arch_local_preempt_disable()
+#endif
+
+
+/*
+ * For cli() we have to insert nops to make sure that the new value
+ * has actually arrived in the status register before the end of this
+ * macro.
+ * R4000/R4400 need three nops, the R4600 two nops and the R10000 needs
+ * no nops at all.
+ */
+/*
+ * For TX49, operating only IE bit is not enough.
+ *
+ * If mfc0 $12 follows store and the mfc0 is last instruction of a
+ * page and fetching the next instruction causes TLB miss, the result
+ * of the mfc0 might wrongly contain EXL bit.
+ *
+ * ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
+ *
+ * Workaround: mask EXL bit of the result or place a nop before mfc0.
+ */
+__asm__(
+	"	.macro	arch_local_irq_disable\n"
+	"	.set	push						\n"
+	"	.set	noat						\n"
+#ifdef CONFIG_MIPS_MT_SMTC
+	"	mfc0	$1, $2, 1					\n"
+	"	ori	$1, 0x400					\n"
+	"	.set	noreorder					\n"
+	"	mtc0	$1, $2, 1					\n"
+#elif defined(CONFIG_CPU_MIPSR2)
+	/* see irqflags.h for inline function */
+#else
+	"	mfc0	$1,$12						\n"
+	"	ori	$1,0x1f						\n"
+	"	xori	$1,0x1f						\n"
+	"	.set	noreorder					\n"
+	"	mtc0	$1,$12						\n"
+#endif
+	"	irq_disable_hazard					\n"
+	"	.set	pop						\n"
+	"	.endm							\n");
+
+void arch_local_irq_disable(void)
+{
+	arch_local_preempt_disable();
+	__asm__ __volatile__(
+		"arch_local_irq_disable"
+		: /* no outputs */
+		: /* no inputs */
+		: "memory");
+	arch_local_preempt_enable();
+}
+
+
+__asm__(
+	"	.macro	arch_local_irq_save result			\n"
+	"	.set	push						\n"
+	"	.set	reorder						\n"
+	"	.set	noat						\n"
+#ifdef CONFIG_MIPS_MT_SMTC
+	"	mfc0	\\result, $2, 1					\n"
+	"	ori	$1, \\result, 0x400				\n"
+	"	.set	noreorder					\n"
+	"	mtc0	$1, $2, 1					\n"
+	"	andi	\\result, \\result, 0x400			\n"
+#elif defined(CONFIG_CPU_MIPSR2)
+	/* see irqflags.h for inline function */
+#else
+	"	mfc0	\\result, $12					\n"
+	"	ori	$1, \\result, 0x1f				\n"
+	"	xori	$1, 0x1f					\n"
+	"	.set	noreorder					\n"
+	"	mtc0	$1, $12						\n"
+#endif
+	"	irq_disable_hazard					\n"
+	"	.set	pop						\n"
+	"	.endm							\n");
+
+unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	arch_local_preempt_disable();
+	asm volatile("arch_local_irq_save\t%0"
+		     : "=r" (flags)
+		     : /* no inputs */
+		     : "memory");
+	arch_local_preempt_enable();
+	return flags;
+}
+
+
+__asm__(
+	"	.macro	arch_local_irq_restore flags			\n"
+	"	.set	push						\n"
+	"	.set	noreorder					\n"
+	"	.set	noat						\n"
+#ifdef CONFIG_MIPS_MT_SMTC
+	"mfc0	$1, $2, 1						\n"
+	"andi	\\flags, 0x400						\n"
+	"ori	$1, 0x400						\n"
+	"xori	$1, 0x400						\n"
+	"or	\\flags, $1						\n"
+	"mtc0	\\flags, $2, 1						\n"
+#elif defined(CONFIG_CPU_MIPSR2) && defined(CONFIG_IRQ_CPU)
+	/* see irqflags.h for inline function */
+#elif defined(CONFIG_CPU_MIPSR2)
+	/* see irqflags.h for inline function */
+#else
+	"	mfc0	$1, $12						\n"
+	"	andi	\\flags, 1					\n"
+	"	ori	$1, 0x1f					\n"
+	"	xori	$1, 0x1f					\n"
+	"	or	\\flags, $1					\n"
+	"	mtc0	\\flags, $12					\n"
+#endif
+	"	irq_disable_hazard					\n"
+	"	.set	pop						\n"
+	"	.endm							\n");
+
+void arch_local_irq_restore(unsigned long flags)
+{
+	unsigned long __tmp1;
+
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC kernel needs to do a software replay of queued
+	 * IPIs, at the cost of branch and call overhead on each
+	 * local_irq_restore()
+	 */
+	if (unlikely(!(flags & 0x0400)))
+		smtc_ipi_replay();
+#endif
+	arch_local_preempt_disable();
+	__asm__ __volatile__(
+		"arch_local_irq_restore\t%0"
+		: "=r" (__tmp1)
+		: "0" (flags)
+		: "memory");
+	arch_local_preempt_enable();
+}
+
+void __arch_local_irq_restore(unsigned long flags)
+{
+	unsigned long __tmp1;
+
+	arch_local_preempt_disable();
+	__asm__ __volatile__(
+		"arch_local_irq_restore\t%0"
+		: "=r" (__tmp1)
+		: "0" (flags)
+		: "memory");
+	arch_local_preempt_enable();
+}
+
+#endif /* !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC) */
-- 
1.7.6
