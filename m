Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47869C07E85
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 03:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED07B2054F
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 03:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g9F9T7Jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED07B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeLEDjE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:39:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41824 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEDir (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 22:38:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so9344669plm.8
        for <linux-mips@vger.kernel.org>; Tue, 04 Dec 2018 19:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3THBjWzjQXWbSnYzPOBcOrKHiHUCpkDIlcc8muGNWU4=;
        b=g9F9T7JxPRI5D5hvgjVninsp1yEqur0YgDLJ16iWwez46PrUJR6ucHaNMCg72Kn/LN
         vPW5wiUjS4E+w3Z5MgVQIrzDOt9koXM0x/sFjzkNRHbITffT7C4HU1lU0TZSsqqVagRw
         2UJvdoA3Ahr6nQuhmEO8giqCs5Oe2z7mZjSi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3THBjWzjQXWbSnYzPOBcOrKHiHUCpkDIlcc8muGNWU4=;
        b=NqNzFROMlsXUXI/rndR5+hVS3/x+kmSN+jb6WONTh7cx6c25qQN03WO4ox8InRh0OC
         5hskKM2TYSAd+JJvMs1v1CwcTfHi6jFnlgNR64gDKOssvGtfGsEAjtBQGZ6b8/boeRFh
         tkd0NB3wPIlCZulcWqz8JVOuqqVTTryLFg+ldLryYgrMFgvE3lMVyXRFs2bqsGhUI+Ou
         zERkG5/rFUAO3WmyMB//8J+qO5svW9hNTwJ7d3Nj829Gj0pwkBtg9MM6BKnFAtB5QZn4
         xSCNyFO5pxpxwH0Ck4eWPGzNlsHsZ2J4xmiXJ8s7GF4MRcyWL0oWTxDLN/JIelNwrx23
         9D1A==
X-Gm-Message-State: AA+aEWZH5d76STO5e7aE8h2W6dOVyLhbS2snHqBcRO1pyMt9ZNEJftl7
        WuDCr6CehVFJXpzSKScKAnRcWw==
X-Google-Smtp-Source: AFSGD/VrWy1eS2/qAya6CGyYhEtfzWxmgUohRjtnyYVFJEGq+sikzph76UhzccwCIXn45rlc9mwztA==
X-Received: by 2002:a17:902:2887:: with SMTP id f7mr21876855plb.176.1543981127069;
        Tue, 04 Dec 2018 19:38:47 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z62sm26456939pfl.33.2018.12.04.19.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:38:46 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [REPOST PATCH v6 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
Date:   Tue,  4 Dec 2018 19:38:26 -0800
Message-Id: <20181205033828.6156-3-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205033828.6156-1-dianders@chromium.org>
References: <20181205033828.6156-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

When I had lockdep turned on and dropped into kgdb I got a nice splat
on my system.  Specifically it hit:
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)

Specifically it looked like this:
  sysrq: SysRq : DEBUG
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)
  WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
  pstate: 604003c9 (nZCv DAIF +PAN -UAO)
  pc : lockdep_hardirqs_on+0xf0/0x160
  ...
  Call trace:
   lockdep_hardirqs_on+0xf0/0x160
   trace_hardirqs_on+0x188/0x1ac
   kgdb_roundup_cpus+0x14/0x3c
   kgdb_cpu_enter+0x53c/0x5cc
   kgdb_handle_exception+0x180/0x1d4
   kgdb_compiled_brk_fn+0x30/0x3c
   brk_handler+0x134/0x178
   do_debug_exception+0xfc/0x178
   el1_dbg+0x18/0x78
   kgdb_breakpoint+0x34/0x58
   sysrq_handle_dbg+0x54/0x5c
   __handle_sysrq+0x114/0x21c
   handle_sysrq+0x30/0x3c
   qcom_geni_serial_isr+0x2dc/0x30c
  ...
  ...
  irq event stamp: ...45
  hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
  hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
  softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
  softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
  ---[ end trace adf21f830c46e638 ]---

Looking closely at it, it seems like a really bad idea to be calling
local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
like it could violate spinlock semantics and cause a deadlock.

Instead, let's use a private csd alongside
smp_call_function_single_async() to round up the other CPUs.  Using
smp_call_function_single_async() doesn't require interrupts to be
enabled so we can remove the offending bit of code.

In order to avoid duplicating this across all the architectures that
use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
to debug_core.c.

Looking at all the people who previously had copies of this code,
there were a few variants.  I've attempted to keep the variants
working like they used to.  Specifically:
* For arch/arc we passed NULL to kgdb_nmicallback() instead of
  get_irq_regs().
* For arch/mips there was a bit of extra code around
  kgdb_nmicallback()

NOTE: In this patch we will still get into trouble if we try to round
up a CPU that failed to round up before.  We'll try to round it up
again and potentially hang when we try to grab the csd lock.  That's
not new behavior but we'll still try to do better in a future patch.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---

Changes in v6:
- Moved smp_call_function_single_async() error check to patch 3.

Changes in v5:
- Add a comment about get_irq_regs().
- get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
- for_each_cpu() => for_each_online_cpu()
- Error check smp_call_function_single_async()

Changes in v4: None
Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 -----------
 arch/arm64/kernel/kgdb.c   | 12 -----------
 arch/hexagon/kernel/kgdb.c | 27 -------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  4 ++--
 arch/sh/kernel/kgdb.c      | 12 -----------
 include/linux/kgdb.h       | 15 ++++++++++++--
 kernel/debug/debug_core.c  | 41 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 59 insertions(+), 83 deletions(-)

diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
index 0932851028e0..68d9fe4b5aa7 100644
--- a/arch/arc/kernel/kgdb.c
+++ b/arch/arc/kernel/kgdb.c
@@ -192,18 +192,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 	instruction_pointer(regs) = ip;
 }
 
-static void kgdb_call_nmi_hook(void *ignored)
+void kgdb_call_nmi_hook(void *ignored)
 {
+	/* Default implementation passes get_irq_regs() but we don't */
 	kgdb_nmicallback(raw_smp_processor_id(), NULL);
 }
 
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 struct kgdb_arch arch_kgdb_ops = {
 	/* breakpoint instruction: TRAP_S 0x3 */
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index f21077b077be..d9a69e941463 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -170,18 +170,6 @@ static struct undef_hook kgdb_compiled_brkpt_hook = {
 	.fn			= kgdb_compiled_brk_fn
 };
 
-static void kgdb_call_nmi_hook(void *ignored)
-{
-       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-       local_irq_enable();
-       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-       local_irq_disable();
-}
-
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
 	struct pt_regs *regs = args->regs;
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 12c339ff6e75..da880247c734 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -284,18 +284,6 @@ static struct step_hook kgdb_step_hook = {
 	.fn		= kgdb_step_brk_fn
 };
 
-static void kgdb_call_nmi_hook(void *ignored)
-{
-	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
 	struct pt_regs *regs = args->regs;
diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
index 012e0e230ac2..b95d12038a4e 100644
--- a/arch/hexagon/kernel/kgdb.c
+++ b/arch/hexagon/kernel/kgdb.c
@@ -115,33 +115,6 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	instruction_pointer(regs) = pc;
 }
 
-#ifdef CONFIG_SMP
-
-/**
- * kgdb_roundup_cpus - Get other CPUs into a holding pattern
- *
- * On SMP systems, we need to get the attention of the other CPUs
- * and get them be in a known state.  This should do what is needed
- * to get the other CPUs to call kgdb_wait(). Note that on some arches,
- * the NMI approach is not used for rounding up all the CPUs. For example,
- * in case of MIPS, smp_call_function() is used to roundup CPUs.
- *
- * On non-SMP systems, this is not called.
- */
-
-static void hexagon_kgdb_nmi_hook(void *ignored)
-{
-	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-#endif
-
 
 /*  Not yet working  */
 void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index 2b05effc17b4..42f057a6c215 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -207,7 +207,7 @@ void arch_kgdb_breakpoint(void)
 		".set\treorder");
 }
 
-static void kgdb_call_nmi_hook(void *ignored)
+void kgdb_call_nmi_hook(void *ignored)
 {
 	mm_segment_t old_fs;
 
@@ -219,13 +219,6 @@ static void kgdb_call_nmi_hook(void *ignored)
 	set_fs(old_fs);
 }
 
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 static int compute_signal(int tt)
 {
 	struct hard_trap_info *ht;
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index b0e804844be0..b4ce54d73337 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -117,7 +117,7 @@ int kgdb_skipexception(int exception, struct pt_regs *regs)
 	return kgdb_isremovedbreak(regs->nip);
 }
 
-static int kgdb_call_nmi_hook(struct pt_regs *regs)
+static int kgdb_debugger_ipi(struct pt_regs *regs)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), regs);
 	return 0;
@@ -502,7 +502,7 @@ int kgdb_arch_init(void)
 	old__debugger_break_match = __debugger_break_match;
 	old__debugger_fault_handler = __debugger_fault_handler;
 
-	__debugger_ipi = kgdb_call_nmi_hook;
+	__debugger_ipi = kgdb_debugger_ipi;
 	__debugger = kgdb_debugger;
 	__debugger_bpt = kgdb_handle_breakpoint;
 	__debugger_sstep = kgdb_singlestep;
diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index cc57630f6bf2..14e012ad7c57 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -314,18 +314,6 @@ BUILD_TRAP_HANDLER(singlestep)
 	local_irq_restore(flags);
 }
 
-static void kgdb_call_nmi_hook(void *ignored)
-{
-	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
 	int ret;
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 05e5b2eb0d32..24422865cd18 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -176,14 +176,25 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
 			   char *remcom_out_buffer,
 			   struct pt_regs *regs);
 
+/**
+ *	kgdb_call_nmi_hook - Call kgdb_nmicallback() on the current CPU
+ *	@ignored: This parameter is only here to match the prototype.
+ *
+ *	If you're using the default implementation of kgdb_roundup_cpus()
+ *	this function will be called per CPU.  If you don't implement
+ *	kgdb_call_nmi_hook() a default will be used.
+ */
+
+extern void kgdb_call_nmi_hook(void *ignored);
+
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them into a known state.  This should do what is needed
  *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
- *	the NMI approach is not used for rounding up all the CPUs. For example,
- *	in case of MIPS, smp_call_function() is used to roundup CPUs.
+ *	the NMI approach is not used for rounding up all the CPUs.  Normally
+ *	those architectures can just not implement this and get the default.
  *
  *	On non-SMP systems, this is not called.
  */
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index f3cadda45f07..10db2833a423 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -55,6 +55,7 @@
 #include <linux/mm.h>
 #include <linux/vmacache.h>
 #include <linux/rcupdate.h>
+#include <linux/irq.h>
 
 #include <asm/cacheflush.h>
 #include <asm/byteorder.h>
@@ -220,6 +221,46 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+
+/*
+ * Default (weak) implementation for kgdb_roundup_cpus
+ */
+
+static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
+
+void __weak kgdb_call_nmi_hook(void *ignored)
+{
+	/*
+	 * NOTE: get_irq_regs() is supposed to get the registers from
+	 * before the IPI interrupt happened and so is supposed to
+	 * show where the processor was.  In some situations it's
+	 * possible we might be called without an IPI, so it might be
+	 * safer to figure out how to make kgdb_breakpoint() work
+	 * properly here.
+	 */
+	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
+}
+
+void __weak kgdb_roundup_cpus(void)
+{
+	call_single_data_t *csd;
+	int this_cpu = raw_smp_processor_id();
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		/* No need to roundup ourselves */
+		if (cpu == this_cpu)
+			continue;
+
+		csd = &per_cpu(kgdb_roundup_csd, cpu);
+		csd->func = kgdb_call_nmi_hook;
+		smp_call_function_single_async(cpu, csd);
+	}
+}
+
+#endif
+
 /*
  * Some architectures need cache flushes when we set/clear a
  * breakpoint:
-- 
2.20.0.rc1.387.gf8505762e3-goog

