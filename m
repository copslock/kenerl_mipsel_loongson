Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2012 02:57:56 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4339 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903552Ab2H0A5s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Aug 2012 02:57:48 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 26 Aug 2012 17:56:38 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sun, 26 Aug 2012 17:56:53 -0700
Received: from stb-irva-01.irv.broadcom.com (stb-irva-01 [10.11.18.102])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 3EBC49F9F5; Sun,
 26 Aug 2012 17:57:31 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH 1/2] asm-offsets.c: adding #define to break circular
 dependency
Date:   Sun, 26 Aug 2012 17:56:49 -0700
Message-ID: <1346029009-20199-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
MIME-Version: 1.0
X-WSS-ID: 7C241A4C3MK24743185-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34362
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
X-Status: A

irqflags.h depends on asm-offsets.h, but asm-offsets.h depends
on irqflags.h when generating asm-offsets.h.  Adding a definition
to the top of asm-offsets.c allows us to break this circle.  There
is a similar define in bounds.c

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/kernel/asm-offsets.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 6b30fb2..035f167 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -8,6 +8,7 @@
  * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.
  */
+#define __GENERATING_OFFSETS_S
 #include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-- 
1.7.6


>From ab76333c041140e4fc1835b581044ff42906881c Mon Sep 17 00:00:00 2001
From: Jim Quinlan <jim2101024@gmail.com>
Date: Sun, 26 Aug 2012 18:08:43 -0400
Subject: [PATCH 2/2] MIPS: irqflags.h: make funcs preempt-safe for non-mipsr2

For non MIPSr2 processors, such as the BMIPS 5000, calls to
arch_local_irq_disable() and others may be preempted, and in doing
so a stale value may be restored to c0_status.  This fix disables
preemption for such processors prior to the call and enables it
after the call.

This bug was observed in a BMIPS 5000, occuring once every few hours
in a continuous reboot test.  It was traced to the write_lock_irq()
function which was being invoked in release_task() in exit.c.
By placing a number of "nops" inbetween the mfc0/mtc0 pair in
arch_local_irq_disable(), which is called by write_lock_irq(), we
were able to greatly increase the occurance of this bug.  Similarly,
the application of this commit silenced the bug.

It is better to use the preemption functions declared in <linux/preempt.h>
rather than defining new ones as is done in this commit.  However,
including that file from irqflags effected many compiler errors.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/irqflags.h |   81 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 309cbcd..2732f5f 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -16,6 +16,71 @@
 #include <linux/compiler.h>
 #include <asm/hazards.h>
 
+#if defined(__GENERATING_BOUNDS_H) || defined(__GENERATING_OFFSETS_S)
+#define __TI_PRE_COUNT (-1)
+#else
+#include <asm/asm-offsets.h>
+#define __TI_PRE_COUNT TI_PRE_COUNT
+#endif
+
+
+/* 
+ * Non-mipsr2 processors executing functions such as arch_local_irq_disable()
+ * are not preempt-safe: if preemption occurs between the mfc0 and the mtc0,
+ * a stale status value may be stored.  To prevent this, we define 
+ * here arch_local_preempt_disable() and arch_local_preempt_enable(), which 
+ * are called before the mfc0 and after the mtc0, respectively.  A better 
+ * solution would "#include <linux/preempt.h> and use its declared routines, 
+ * but that is not viable due to numerous compile errors.
+ *
+ * MipsR2 processors with atomic interrupt enable/disable instructions 
+ * (ei/di) do not have this issue.
+ */
+__asm__(
+	"	.macro	arch_local_preempt_disable ti_pre_count		\n"
+	"	.set	push						\n"
+	"	.set	noat						\n"
+	"	lw	$1, \\ti_pre_count($28)				\n"
+	"	addi	$1, $1, 1					\n"
+	"	sw	$1, \\ti_pre_count($28)				\n"
+	"	.set	pop						\n"
+	"	.endm");
+static inline void arch_local_preempt_disable(void)
+{
+#if defined(CONFIG_PREEMPT) && !defined(CONFIG_CPU_MIPSR2)
+	__asm__ __volatile__(
+		"arch_local_preempt_disable\t%0"
+		: /* no outputs */
+		: "n" (__TI_PRE_COUNT)
+		: "memory");
+	barrier();
+#endif
+}
+
+
+__asm__(
+	"	.macro	arch_local_preempt_enable ti_pre_count		\n"
+	"	.set	push						\n"
+	"	.set	noat						\n"
+	"	lw	$1, \\ti_pre_count($28)				\n"
+	"	addi	$1, $1, -1					\n"
+	"	sw	$1, \\ti_pre_count($28)				\n"
+	"	.set	pop						\n"
+	"	.endm");
+
+static inline void arch_local_preempt_enable(void)
+{
+#if defined(CONFIG_PREEMPT) && !defined(CONFIG_CPU_MIPSR2)
+	__asm__ __volatile__(
+		"arch_local_preempt_enable\t%0"
+		: /* no outputs */
+		: "n" (__TI_PRE_COUNT)
+		: "memory");
+	barrier();
+#endif
+}
+
+
 __asm__(
 	"	.macro	arch_local_irq_enable				\n"
 	"	.set	push						\n"
@@ -99,11 +164,15 @@ __asm__(
 
 static inline void arch_local_irq_disable(void)
 {
+	arch_local_preempt_disable();
+
 	__asm__ __volatile__(
 		"arch_local_irq_disable"
 		: /* no outputs */
 		: /* no inputs */
 		: "memory");
+
+	arch_local_preempt_enable();
 }
 
 __asm__(
@@ -153,10 +222,15 @@ __asm__(
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
+
+	arch_local_preempt_disable();
+
 	asm volatile("arch_local_irq_save\t%0"
 		     : "=r" (flags)
 		     : /* no inputs */
 		     : "memory");
+
+	arch_local_preempt_enable();
 	return flags;
 }
 
@@ -214,23 +288,30 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	if (unlikely(!(flags & 0x0400)))
 		smtc_ipi_replay();
 #endif
+	arch_local_preempt_disable();
 
 	__asm__ __volatile__(
 		"arch_local_irq_restore\t%0"
 		: "=r" (__tmp1)
 		: "0" (flags)
 		: "memory");
+
+	arch_local_preempt_enable();
 }
 
 static inline void __arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
+	arch_local_preempt_disable();
+
 	__asm__ __volatile__(
 		"arch_local_irq_restore\t%0"
 		: "=r" (__tmp1)
 		: "0" (flags)
 		: "memory");
+
+	arch_local_preempt_enable();
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
-- 
1.7.6
