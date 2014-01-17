Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 17:19:43 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:54822 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827435AbaAQQTWPPMun (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 17:19:22 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1W4C8T-0005A3-Sd; Fri, 17 Jan 2014 10:19:09 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     blogic@openwrt.org
Subject: [PATCH 2/3] MIPS: CMP: Malta: Add support for CPU hotplugging.
Date:   Fri, 17 Jan 2014 10:18:54 -0600
Message-Id: <1389975535-62279-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
References: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Adds support for CPU hotplugging on the Malta platform.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/amon.h     |    1 +
 arch/mips/mti-malta/malta-amon.c |  107 +++++++++++++++++++++++++++++++-------
 arch/mips/mti-malta/malta-int.c  |    2 +-
 3 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
index 3cc03c6..a71e82d 100644
--- a/arch/mips/include/asm/amon.h
+++ b/arch/mips/include/asm/amon.h
@@ -10,3 +10,4 @@
 int amon_cpu_avail(int cpu);
 int amon_cpu_start(int cpu, unsigned long pc, unsigned long sp,
 		   unsigned long gp, unsigned long a0);
+void amon_cpu_dead(void);
diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 0319ad8..80ad67a 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -3,10 +3,10 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Arbitrary Monitor Interface
+ *
  * Copyright (C) 2007 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2013 Imagination Technologies Ltd.
- *
- * Arbitrary Monitor Interface
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -22,40 +22,49 @@ int amon_cpu_avail(int cpu)
 	struct cpulaunch *launch = (struct cpulaunch *)CKSEG0ADDR(CPULAUNCH);
 
 	if (cpu < 0 || cpu >= NCPULAUNCH) {
-		pr_debug("avail: cpu%d is out of range\n", cpu);
+		pr_debug("%s: CPU%d is out of range\n", __func__, cpu);
 		return 0;
 	}
 
 	launch += cpu;
-	if (!(launch->flags & LAUNCH_FREADY)) {
-		pr_debug("avail: cpu%d is not ready\n", cpu);
-		return 0;
-	}
-	if (launch->flags & (LAUNCH_FGO|LAUNCH_FGONE)) {
-		pr_debug("avail: too late.. cpu%d is already gone\n", cpu);
-		return 0;
-	}
-
-	return 1;
+	if (launch->flags == LAUNCH_FREADY) {
+		pr_debug("%s: CPU%d is available\n", __func__, cpu);
+		return LAUNCH_FREADY;
+	} else if (launch->flags & LAUNCH_FGONE) {
+		pr_debug("%s: CPU%d is already gone\n", __func__, cpu);
+		return LAUNCH_FGONE;
+	} else if (launch->flags & LAUNCH_FGO) {
+		pr_debug("%s: CPU%d is going\n", __func__, cpu);
+		return LAUNCH_FGO;
+	} else {
+		pr_debug("%s: CPU%d is unavailable\n", __func__, cpu);
+ 		return 0;
+ 	}
 }
 
 int amon_cpu_start(int cpu,
-		    unsigned long pc, unsigned long sp,
-		    unsigned long gp, unsigned long a0)
+		   unsigned long pc, unsigned long sp,
+		   unsigned long gp, unsigned long a0)
 {
+	int this_cpu;
 	volatile struct cpulaunch *launch =
 		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
 
 	if (!amon_cpu_avail(cpu))
 		return -1;
-	if (cpu == smp_processor_id()) {
+
+	preempt_disable();
+	this_cpu = smp_processor_id();
+	preempt_enable();
+
+	if (cpu == this_cpu) {
 		pr_debug("launch: I am cpu%d!\n", cpu);
 		return -1;
 	}
-	launch += cpu;
 
 	pr_debug("launch: starting cpu%d\n", cpu);
 
+	launch += cpu;
 	launch->pc = pc;
 	launch->gp = gp;
 	launch->sp = sp;
@@ -67,12 +76,74 @@ int amon_cpu_start(int cpu,
 
 	while ((launch->flags & LAUNCH_FGONE) == 0)
 		;
-	smp_rmb();	/* Target will be updating flags soon */
+	smp_rmb();		/* Target will be updating flags soon */
 	pr_debug("launch: cpu%d gone!\n", cpu);
 
 	return 0;
 }
 
+/*
+ * Restart the CPU ready for amon_cpu_start again
+ * A bit of a hack... it duplicates the CPU startup code that
+ * lives somewhere in the boot monitor.
+ */
+void amon_cpu_dead(void)
+{
+	struct cpulaunch *launch;
+	unsigned int r0;
+	int cpufreq;
+
+	launch = (struct cpulaunch *)CKSEG0ADDR(CPULAUNCH);
+	launch += smp_processor_id();
+
+	launch->pc = 0;
+	launch->gp = 0;
+	launch->sp = 0;
+	launch->a0 = 0;
+	launch->flags = LAUNCH_FREADY;
+
+	cpufreq = 500000000;	/* FIXME: Correct value? */
+
+	__asm__ __volatile__ (
+	"	.set	push\n\t"
+	"	.set	noreorder\n\t"
+	"1:\n\t"
+	"	lw	%[r0],%[LAUNCH_FLAGS](%[launch])\n\t"
+	"	andi	%[r0],%[FGO]\n\t"
+	"	bnez    %[r0],1f\n\t"
+	"	 nop\n\t"
+	"	mfc0	%[r0],$9\n\t"	/* Read Count */
+	"	addu    %[r0],%[waitperiod]\n\t"
+	"	mtc0	%[r0],$11\n\t"	/* Write Compare */
+	"	wait\n\t"
+	"	b	1b\n\t"
+	"	 nop\n\t"
+	"1:	lw	$ra,%[LAUNCH_PC](%[launch])\n\t"
+	"	lw	$gp,%[LAUNCH_GP](%[launch])\n\t"
+	"	lw	$sp,%[LAUNCH_SP](%[launch])\n\t"
+	"	lw	$a0,%[LAUNCH_A0](%[launch])\n\t"
+	"	move	$a1,$zero\n\t"
+	"	move	$a2,$zero\n\t"
+	"	move	$a3,$zero\n\t"
+	"	lw	%[r0],%[LAUNCH_FLAGS](%[launch])\n\t"
+	"	ori	%[r0],%[FGONE]\n\t"
+	"	jr	$ra\n\t"
+	"	 sw	%[r0],%[LAUNCH_FLAGS](%[launch])\n\t"
+	"	.set	pop\n\t"
+	: [r0] "=&r" (r0)
+	: [launch] "r" (launch),
+	  [FGONE] "i" (LAUNCH_FGONE),
+	  [FGO] "i" (LAUNCH_FGO),
+	  [LAUNCH_PC] "i" (offsetof(struct cpulaunch, pc)),
+	  [LAUNCH_GP] "i" (offsetof(struct cpulaunch, gp)),
+	  [LAUNCH_SP] "i" (offsetof(struct cpulaunch, sp)),
+	  [LAUNCH_A0] "i" (offsetof(struct cpulaunch, a0)),
+	  [LAUNCH_FLAGS] "i" (offsetof(struct cpulaunch, flags)),
+	  [waitperiod] "i" ((cpufreq / 2) / 100)	/* delay of ~10ms  */
+	: "ra", "a0", "a1", "a2", "a3", "sp" /* ,"gp" */
+	);
+}
+
 #ifdef CONFIG_MIPS_VPE_LOADER
 int vpe_run(struct vpe *v)
 {
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index ca3e3a4..136c4fc 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -39,7 +39,7 @@
 
 int gcmp_present = -1;
 static unsigned long _msc01_biu_base;
-static unsigned long _gcmp_base;
+unsigned long _gcmp_base;
 static unsigned int ipi_map[NR_CPUS];
 
 static DEFINE_RAW_SPINLOCK(mips_irq_lock);
-- 
1.7.10.4
