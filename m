Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 00:35:19 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3574 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903258Ab2H2Wev (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2012 00:34:51 +0200
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 29 Aug 2012 15:32:29 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 29 Aug 2012 15:34:32 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 81D009FA03; Wed, 29
 Aug 2012 15:34:31 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH V2 2/2] MIPS: irqflags.h: make funcs preempt-safe for
 non-mipsr2
Date:   Wed, 29 Aug 2012 18:34:07 -0400
Message-ID: <1346279647-27955-2-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
References: <y> <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C2047F749824978150-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34378
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
index 309cbcd..d6e71ed 100644
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
