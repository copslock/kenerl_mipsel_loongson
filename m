Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 17:09:36 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:60165 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225761AbVFNQJO>; Tue, 14 Jun 2005 17:09:14 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5EG6OdA026292;
	Tue, 14 Jun 2005 17:06:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5EG6N7X026291;
	Tue, 14 Jun 2005 17:06:23 +0100
Date:	Tue, 14 Jun 2005 17:06:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ton Truong <ttruong@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Member sc_sigset gone in latest 2.6.12-rc5 breaks strace.
Message-ID: <20050614160623.GE5183@linux-mips.org>
References: <20050606121640.GB6651@linux-mips.org> <200506091737.KAA22310@mon-irva-10.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506091737.KAA22310@mon-irva-10.broadcom.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 09, 2005 at 10:37:49AM -0700, Ton Truong wrote:

> I see that in the rc5 update, MIPS codes have now dropped 
> sc_sigset[4] from struct sigcontext, defined in asm-mips/sigcontext.h.  I'd
> appreciate it if someone provide a brief summary of what needs to be changed
> for strace to compile or where I can find an strace port that work with the
> new MIPS codes?
> 
> Much appreciated.

Things turned a little more complicated, unfortunately.  So the recent
support for the DSP ASE broke compilation of some code in strace that
wasn't functioning anyway.  Fixing that did collide with a RM9000 bug
workaround ...  So this is something that hopefully will work for any
processor and re-establish binary compatibility with debuggers.

Strace will need a separate patch.

Comments?

  Ralf

 arch/mips/kernel/signal-common.h                       |   34 ++++++++-
 arch/mips/kernel/signal.c                              |   59 +++++++----------
 arch/mips/kernel/signal32.c                            |   16 ++++
 arch/mips/kernel/signal_n32.c                          |   32 +++------
 include/asm-mips/cpu-features.h                        |   11 ---
 include/asm-mips/mach-ja/cpu-feature-overrides.h       |    6 -
 include/asm-mips/mach-ocelot3/cpu-feature-overrides.h  |    6 -
 include/asm-mips/mach-yosemite/cpu-feature-overrides.h |    6 -
 include/asm-mips/war.h                                 |   14 ++++
 9 files changed, 98 insertions(+), 86 deletions(-)

Index: linux-qa/include/asm-mips/mach-ocelot3/cpu-feature-overrides.h
===================================================================
--- linux-qa.orig/include/asm-mips/mach-ocelot3/cpu-feature-overrides.h	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/include/asm-mips/mach-ocelot3/cpu-feature-overrides.h	2005-06-14 14:25:12.000000000 +0100
@@ -40,10 +40,4 @@
 #define cpu_icache_line_size()	32
 #define cpu_scache_line_size()	32
 
-/*
- * On the RM9000 we need to ensure that I-cache lines being fetches only
- * contain valid instructions are funny things will happen.
- */
-#define PLAT_TRAMPOLINE_STUFF_LINE	32UL
-
 #endif /* __ASM_MACH_JA_CPU_FEATURE_OVERRIDES_H */
Index: linux-qa/include/asm-mips/cpu-features.h
===================================================================
--- linux-qa.orig/include/asm-mips/cpu-features.h	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/include/asm-mips/cpu-features.h	2005-06-14 14:25:12.000000000 +0100
@@ -109,17 +109,6 @@
 #define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
 #endif
 
-/*
- * Certain CPUs may throw bizarre exceptions if not the whole cacheline
- * contains valid instructions.  For these we ensure proper alignment of
- * signal trampolines and pad them to the size of a full cache lines with
- * nops.  This is also used in structure definitions so can't be a test macro
- * like the others.
- */
-#ifndef PLAT_TRAMPOLINE_STUFF_LINE
-#define PLAT_TRAMPOLINE_STUFF_LINE	0UL
-#endif
-
 #ifdef CONFIG_MIPS32
 # ifndef cpu_has_nofpuex
 # define cpu_has_nofpuex	(cpu_data[0].options & MIPS_CPU_NOFPUEX)
Index: linux-qa/include/asm-mips/mach-yosemite/cpu-feature-overrides.h
===================================================================
--- linux-qa.orig/include/asm-mips/mach-yosemite/cpu-feature-overrides.h	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/include/asm-mips/mach-yosemite/cpu-feature-overrides.h	2005-06-14 14:25:12.000000000 +0100
@@ -37,10 +37,4 @@
 #define cpu_icache_line_size()	32
 #define cpu_scache_line_size()	32
 
-/*
- * On the RM9000 we need to ensure that I-cache lines being fetches only
- * contain valid instructions are funny things will happen.
- */
-#define PLAT_TRAMPOLINE_STUFF_LINE	32UL
-
 #endif /* __ASM_MACH_YOSEMITE_CPU_FEATURE_OVERRIDES_H */
Index: linux-qa/arch/mips/kernel/signal_n32.c
===================================================================
--- linux-qa.orig/arch/mips/kernel/signal_n32.c	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/arch/mips/kernel/signal_n32.c	2005-06-14 15:47:37.000000000 +0100
@@ -15,6 +15,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
+#include <linux/cache.h>
+#include <linux/sched.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -36,6 +38,7 @@
 #include <asm/system.h>
 #include <asm/fpu.h>
 #include <asm/cpu-features.h>
+#include <asm/war.h>
 
 #include "signal-common.h"
 
@@ -62,17 +65,18 @@
 	sigset_t            uc_sigmask;   /* mask last for extensibility */
 };
 
-#if PLAT_TRAMPOLINE_STUFF_LINE
-#define __tramp __attribute__((aligned(PLAT_TRAMPOLINE_STUFF_LINE)))
-#else
-#define __tramp
-#endif
-
 struct rt_sigframe_n32 {
 	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_code[2] __tramp;		/* signal trampoline */
-	struct siginfo rs_info __tramp;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 rs_pad[2];
+#else
+	u32 rs_code[2];			/* signal trampoline */
+#endif
+	struct siginfo rs_info;
 	struct ucontextn32 rs_uc;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 rs_code[8] ____cacheline_aligned;		/* signal trampoline */
+#endif
 };
 
 save_static_function(sysn32_rt_sigreturn);
@@ -137,17 +141,7 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/*
-	 * Set up the return code ...
-	 *
-	 *         li      v0, __NR_rt_sigreturn
-	 *         syscall
-	 */
-	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		__clear_user(frame->rs_code, PLAT_TRAMPOLINE_STUFF_LINE);
-	err |= __put_user(0x24020000 + __NR_N32_rt_sigreturn, frame->rs_code + 0);
-	err |= __put_user(0x0000000c                        , frame->rs_code + 1);
-	flush_cache_sigtramp((unsigned long) frame->rs_code);
+	install_sigtramp(frame->rs_code, __NR_N32_rt_sigreturn);
 
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
Index: linux-qa/arch/mips/kernel/signal.c
===================================================================
--- linux-qa.orig/arch/mips/kernel/signal.c	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/arch/mips/kernel/signal.c	2005-06-14 16:37:36.000000000 +0100
@@ -8,6 +8,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #include <linux/config.h>
+#include <linux/cache.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/personality.h>
@@ -30,6 +31,7 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
+#include <asm/war.h>
 
 #include "signal-common.h"
 
@@ -157,26 +159,39 @@
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-#if PLAT_TRAMPOLINE_STUFF_LINE
-#define __tramp __attribute__((aligned(PLAT_TRAMPOLINE_STUFF_LINE)))
-#else
-#define __tramp
-#endif
-
+/*
+ * Horribly complicated - with the bloody RM9000 workarounds enabled
+ * the signal trampolines is moving to the end of the structure so we can
+ * increase the alignment without breaking software compatibility.
+ */
 #ifdef CONFIG_TRAD_SIGNALS
 struct sigframe {
 	u32 sf_ass[4];			/* argument save space for o32 */
-	u32 sf_code[2] __tramp;		/* signal trampoline */
-	struct sigcontext sf_sc __tramp;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 sf_pad[2];
+#else
+	u32 sf_code[2];			/* signal trampoline */
+#endif
+	struct sigcontext sf_sc;
 	sigset_t sf_mask;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
+#endif
 };
 #endif
 
 struct rt_sigframe {
 	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_code[2] __tramp;		/* signal trampoline */
-	struct siginfo rs_info __tramp;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 rs_pad[2];
+#else
+	u32 rs_code[2];			/* signal trampoline */
+#endif
+	struct siginfo rs_info;
 	struct ucontext rs_uc;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 rs_code[8] ____cacheline_aligned;	/* signal trampoline */
+#endif
 };
 
 #ifdef CONFIG_TRAD_SIGNALS
@@ -273,17 +288,7 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/*
-	 * Set up the return code ...
-	 *
-	 *         li      v0, __NR_sigreturn
-	 *         syscall
-	 */
-	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		__clear_user(frame->sf_code, PLAT_TRAMPOLINE_STUFF_LINE);
-	err |= __put_user(0x24020000 + __NR_sigreturn, frame->sf_code + 0);
-	err |= __put_user(0x0000000c                 , frame->sf_code + 1);
-	flush_cache_sigtramp((unsigned long) frame->sf_code);
+	install_sigtramp(frame->sf_code, __NR_sigreturn);
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
@@ -329,17 +334,7 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/*
-	 * Set up the return code ...
-	 *
-	 *         li      v0, __NR_rt_sigreturn
-	 *         syscall
-	 */
-	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		__clear_user(frame->rs_code, PLAT_TRAMPOLINE_STUFF_LINE);
-	err |= __put_user(0x24020000 + __NR_rt_sigreturn, frame->rs_code + 0);
-	err |= __put_user(0x0000000c                    , frame->rs_code + 1);
-	flush_cache_sigtramp((unsigned long) frame->rs_code);
+	install_sigtramp(frame->rs_code, __NR_rt_sigreturn);
 
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
Index: linux-qa/include/asm-mips/mach-ja/cpu-feature-overrides.h
===================================================================
--- linux-qa.orig/include/asm-mips/mach-ja/cpu-feature-overrides.h	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/include/asm-mips/mach-ja/cpu-feature-overrides.h	2005-06-14 14:25:12.000000000 +0100
@@ -37,10 +37,4 @@
 #define cpu_icache_line_size()	32
 #define cpu_scache_line_size()	32
 
-/*
- * On the RM9000 we need to ensure that I-cache lines being fetches only
- * contain valid instructions are funny things will happen.
- */
-#define PLAT_TRAMPOLINE_STUFF_LINE	32UL
-
 #endif /* __ASM_MACH_JA_CPU_FEATURE_OVERRIDES_H */
Index: linux-qa/arch/mips/kernel/signal-common.h
===================================================================
--- linux-qa.orig/arch/mips/kernel/signal-common.h	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/arch/mips/kernel/signal-common.h	2005-06-14 14:25:12.000000000 +0100
@@ -160,7 +160,7 @@
 static inline void *
 get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
 {
-	unsigned long sp, almask;
+	unsigned long sp;
 
 	/* Default to using normal stack */
 	sp = regs->regs[29];
@@ -176,10 +176,32 @@
 	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		almask = ~(PLAT_TRAMPOLINE_STUFF_LINE - 1);
-	else
-		almask = ALMASK;
+	return (void *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? 32 : ALMASK));
+}
+
+static inline int install_sigtramp(unsigned int __user *tramp,
+	unsigned int syscall)
+{
+	int err;
+
+	/*
+	 * Set up the return code ...
+	 *
+	 *         li      v0, __NR__foo_sigreturn
+	 *         syscall
+	 */
+
+	err |= __put_user(0x24020000 + syscall, tramp + 0);
+	err |= __put_user(0x0000000c          , tramp + 1);
+	if (ICACHE_REFILLS_WORKAROUND_WAR) {
+		err |= __put_user(0, tramp + 2);
+		err |= __put_user(0, tramp + 3);
+		err |= __put_user(0, tramp + 4);
+		err |= __put_user(0, tramp + 5);
+		err |= __put_user(0, tramp + 6);
+		err |= __put_user(0, tramp + 7);
+	}
+	flush_cache_sigtramp((unsigned long) tramp);
 
-	return (void *)((sp - frame_size) & almask);
+	return err;
 }
Index: linux-qa/include/asm-mips/war.h
===================================================================
--- linux-qa.orig/include/asm-mips/war.h	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/include/asm-mips/war.h	2005-06-14 14:25:12.000000000 +0100
@@ -177,6 +177,17 @@
 #endif
 
 /*
+ * The RM9000 has a bug (though PMC-Sierra opposes it being called that)
+ * where invalid instructions in the same I-cache line worth of instructions
+ * being fetched may case spurious exceptions.
+ */
+#if defined(CONFIG_MOMENCO_JAGUAR_ATX) || defined(CONFIG_MOMENCO_OCELOT_3) || \
+    defined(CONFIG_PMC_YOSEMITE)
+#define ICACHE_REFILLS_WORKAROUND_WAR	1
+#endif
+
+
+/*
  * ON the R10000 upto version 2.6 (not sure about 2.7) there is a bug that
  * may cause ll / sc and lld / scd sequences to execute non-atomically.
  */
@@ -187,6 +198,9 @@
 /*
  * Workarounds default to off
  */
+#ifndef ICACHE_REFILLS_WORKAROUND_WAR
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#endif
 #ifndef R4600_V1_INDEX_ICACHEOP_WAR
 #define R4600_V1_INDEX_ICACHEOP_WAR	0
 #endif
Index: linux-qa/arch/mips/kernel/signal32.c
===================================================================
--- linux-qa.orig/arch/mips/kernel/signal32.c	2005-06-14 12:53:28.000000000 +0100
+++ linux-qa/arch/mips/kernel/signal32.c	2005-06-14 15:47:24.000000000 +0100
@@ -7,6 +7,7 @@
  * Copyright (C) 1994 - 2000  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+#include <linux/cache.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -30,6 +31,7 @@
 #include <asm/ucontext.h>
 #include <asm/system.h>
 #include <asm/fpu.h>
+#include <asm/war.h>
 
 #define SI_PAD_SIZE32   ((SI_MAX_SIZE/sizeof(int)) - 3)
 
@@ -392,16 +394,30 @@
 
 struct sigframe {
 	u32 sf_ass[4];			/* argument save space for o32 */
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 sf_pad[2];
+#else
 	u32 sf_code[2];			/* signal trampoline */
+#endif
 	struct sigcontext32 sf_sc;
 	sigset_t sf_mask;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
+#endif
 };
 
 struct rt_sigframe32 {
 	u32 rs_ass[4];			/* argument save space for o32 */
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 rs_pad[2];
+#else
 	u32 rs_code[2];			/* signal trampoline */
+#endif
 	compat_siginfo_t rs_info;
 	struct ucontext32 rs_uc;
+#if ICACHE_REFILLS_WORKAROUND_WAR
+	u32 rs_code[8] __attribute__((aligned(32)));	/* signal trampoline */
+#endif
 };
 
 int copy_siginfo_to_user32(compat_siginfo_t *to, siginfo_t *from)
