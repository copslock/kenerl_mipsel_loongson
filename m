Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 00:34:27 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4746 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903408Ab2IEWdL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2012 00:33:11 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 05 Sep 2012 15:31:58 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 5 Sep 2012 15:32:53 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 3B1D49F9F5; Wed, 5
 Sep 2012 15:32:53 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     ddaney.cavm@gmail.com, cernekee@gmail.com,
        "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH V4 3/3] MIPS: make funcs preempt-safe for non-mipsr2
 cpus
Date:   Wed, 5 Sep 2012 18:32:47 -0400
Message-ID: <1346884367-6906-4-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1346884367-6906-1-git-send-email-jim2101024@gmail.com>
References: <1346884367-6906-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C590D543MK28706377-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34431
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
 arch/mips/include/asm/irqflags.h |  207 ++++++++++++++------------------------
 arch/mips/lib/Makefile           |    3 +-
 arch/mips/lib/mips-atomic.c      |  176 ++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+), 133 deletions(-)
 create mode 100644 arch/mips/lib/mips-atomic.c

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 309cbcd..9f3384c 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -16,83 +16,13 @@
 #include <linux/compiler.h>
 #include <asm/hazards.h>
 
-__asm__(
-	"	.macro	arch_local_irq_enable				\n"
-	"	.set	push						\n"
-	"	.set	reorder						\n"
-	"	.set	noat						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	$1, $2, 1	# SMTC - clear TCStatus.IXMT	\n"
-	"	ori	$1, 0x400					\n"
-	"	xori	$1, 0x400					\n"
-	"	mtc0	$1, $2, 1					\n"
-#elif defined(CONFIG_CPU_MIPSR2)
-	"	ei							\n"
-#else
-	"	mfc0	$1,$12						\n"
-	"	ori	$1,0x1f						\n"
-	"	xori	$1,0x1e						\n"
-	"	mtc0	$1,$12						\n"
-#endif
-	"	irq_enable_hazard					\n"
-	"	.set	pop						\n"
-	"	.endm");
+#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MIPS_MT_SMTC)
 
-extern void smtc_ipi_replay(void);
-
-static inline void arch_local_irq_enable(void)
-{
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC kernel needs to do a software replay of queued
-	 * IPIs, at the cost of call overhead on each local_irq_enable()
-	 */
-	smtc_ipi_replay();
-#endif
-	__asm__ __volatile__(
-		"arch_local_irq_enable"
-		: /* no outputs */
-		: /* no inputs */
-		: "memory");
-}
-
-
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
@@ -106,46 +36,14 @@ static inline void arch_local_irq_disable(void)
 		: "memory");
 }
 
-__asm__(
-	"	.macro	arch_local_save_flags flags			\n"
-	"	.set	push						\n"
-	"	.set	reorder						\n"
-#ifdef CONFIG_MIPS_MT_SMTC
-	"	mfc0	\\flags, $2, 1					\n"
-#else
-	"	mfc0	\\flags, $12					\n"
-#endif
-	"	.set	pop						\n"
-	"	.endm							\n");
-
-static inline unsigned long arch_local_save_flags(void)
-{
-	unsigned long flags;
-	asm volatile("arch_local_save_flags %0" : "=r" (flags));
-	return flags;
-}
 
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
@@ -160,61 +58,37 @@ static inline unsigned long arch_local_irq_save(void)
 	return flags;
 }
 
+
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
 	 */
 	"	beqz	\\flags, 1f					\n"
-	"	 di							\n"
+	"	di							\n"
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
 	"	.endm							\n");
 
-
 static inline void arch_local_irq_restore(unsigned long flags)
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
@@ -232,6 +106,75 @@ static inline void __arch_local_irq_restore(unsigned long flags)
 		: "0" (flags)
 		: "memory");
 }
+#else
+/* Functions that require preempt_{dis,en}able() are in mips-atomic.c */
+void arch_local_irq_disable(void);
+unsigned long arch_local_irq_save(void);
+void arch_local_irq_restore(unsigned long flags);
+void __arch_local_irq_restore(unsigned long flags);
+#endif /* if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_MIPS_MT_SMTC) */
+
+
+__asm__(
+	"	.macro	arch_local_irq_enable				\n"
+	"	.set	push						\n"
+	"	.set	reorder						\n"
+	"	.set	noat						\n"
+#ifdef CONFIG_MIPS_MT_SMTC
+	"	mfc0	$1, $2, 1	# SMTC - clear TCStatus.IXMT	\n"
+	"	ori	$1, 0x400					\n"
+	"	xori	$1, 0x400					\n"
+	"	mtc0	$1, $2, 1					\n"
+#elif defined(CONFIG_CPU_MIPSR2)
+	"	ei							\n"
+#else
+	"	mfc0	$1,$12						\n"
+	"	ori	$1,0x1f						\n"
+	"	xori	$1,0x1e						\n"
+	"	mtc0	$1,$12						\n"
+#endif
+	"	irq_enable_hazard					\n"
+	"	.set	pop						\n"
+	"	.endm");
+
+extern void smtc_ipi_replay(void);
+
+static inline void arch_local_irq_enable(void)
+{
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC kernel needs to do a software replay of queued
+	 * IPIs, at the cost of call overhead on each local_irq_enable()
+	 */
+	smtc_ipi_replay();
+#endif
+	__asm__ __volatile__(
+		"arch_local_irq_enable"
+		: /* no outputs */
+		: /* no inputs */
+		: "memory");
+}
+
+
+__asm__(
+	"	.macro	arch_local_save_flags flags			\n"
+	"	.set	push						\n"
+	"	.set	reorder						\n"
+#ifdef CONFIG_MIPS_MT_SMTC
+	"	mfc0	\\flags, $2, 1					\n"
+#else
+	"	mfc0	\\flags, $12					\n"
+#endif
+	"	.set	pop						\n"
+	"	.endm							\n");
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	asm volatile("arch_local_save_flags %0" : "=r" (flags));
+	return flags;
+}
+
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
@@ -245,7 +188,7 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 #endif
 }
 
-#endif
+#endif /* #ifndef __ASSEMBLY__ */
 
 /*
  * Do the CPU's IRQ-state tracing from assembly code.
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
index 0000000..e091430
--- /dev/null
+++ b/arch/mips/lib/mips-atomic.c
@@ -0,0 +1,176 @@
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
+#include <linux/export.h>
+
+#if !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC)
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
+	preempt_disable();
+	__asm__ __volatile__(
+		"arch_local_irq_disable"
+		: /* no outputs */
+		: /* no inputs */
+		: "memory");
+	preempt_enable();
+}
+EXPORT_SYMBOL(arch_local_irq_disable);
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
+	preempt_disable();
+	asm volatile("arch_local_irq_save\t%0"
+		     : "=r" (flags)
+		     : /* no inputs */
+		     : "memory");
+	preempt_enable();
+	return flags;
+}
+EXPORT_SYMBOL(arch_local_irq_save);
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
+	preempt_disable();
+	__asm__ __volatile__(
+		"arch_local_irq_restore\t%0"
+		: "=r" (__tmp1)
+		: "0" (flags)
+		: "memory");
+	preempt_enable();
+}
+EXPORT_SYMBOL(arch_local_irq_restore);
+
+
+void __arch_local_irq_restore(unsigned long flags)
+{
+	unsigned long __tmp1;
+
+	preempt_disable();
+	__asm__ __volatile__(
+		"arch_local_irq_restore\t%0"
+		: "=r" (__tmp1)
+		: "0" (flags)
+		: "memory");
+	preempt_enable();
+}
+EXPORT_SYMBOL(__arch_local_irq_restore);
+
+#endif /* !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC) */
-- 
1.7.6
