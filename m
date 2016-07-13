Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 19:19:34 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:36222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992067AbcGMRT06JpMI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 19:19:26 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1bNNoN-0005KL-2U; Wed, 13 Jul 2016 19:19:03 +0200
Message-Id: <20160713153337.054827168@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Wed, 13 Jul 2016 17:16:53 -0000
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, rt@linutronix.de,
        Richard Cochran <rcochran@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>, linux-mips@linux-mips.org,
        oprofile-list@lists.sf.net,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch V2 50/67] MIPS/Loongson-3: Convert oprofile to hotplug state
 machine
References: <20160713153219.128052238@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=0049-MIPS-Loongson-3-Convert-oprofile-to-hotplug-state-ma.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <anna-maria@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anna-maria@linutronix.de
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

From: Richard Cochran <rcochran@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Cc: oprofile-list@lists.sf.net
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/mips/oprofile/op_model_loongson3.c | 35 +++++++++++++--------------------
 include/linux/cpuhotplug.h              |  1 +
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson3.c b/arch/mips/oprofile/op_model_loongson3.c
index 8bcf7fc..85f3ee4 100644
--- a/arch/mips/oprofile/op_model_loongson3.c
+++ b/arch/mips/oprofile/op_model_loongson3.c
@@ -168,33 +168,26 @@ static int loongson3_perfcount_handler(void)
 	return handled;
 }
 
-static int loongson3_cpu_callback(struct notifier_block *nfb,
-	unsigned long action, void *hcpu)
+static int loongson3_starting_cpu(unsigned int cpu)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		write_c0_perflo1(reg.control1);
-		write_c0_perflo2(reg.control2);
-		break;
-	case CPU_DYING:
-	case CPU_DYING_FROZEN:
-		write_c0_perflo1(0xc0000000);
-		write_c0_perflo2(0x40000000);
-		break;
-	}
-
-	return NOTIFY_OK;
+	write_c0_perflo1(reg.control1);
+	write_c0_perflo2(reg.control2);
+	return 0;
 }
 
-static struct notifier_block loongson3_notifier_block = {
-	.notifier_call = loongson3_cpu_callback
-};
+static int loongson3_dying_cpu(unsigned int cpu)
+{
+	write_c0_perflo1(0xc0000000);
+	write_c0_perflo2(0x40000000);
+	return 0;
+}
 
 static int __init loongson3_init(void)
 {
 	on_each_cpu(reset_counters, NULL, 1);
-	register_hotcpu_notifier(&loongson3_notifier_block);
+	cpuhp_setup_state_nocalls(CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
+				  "AP_MIPS_OP_LOONGSON3_STARTING",
+				  loongson3_starting_cpu, loongson3_dying_cpu);
 	save_perf_irq = perf_irq;
 	perf_irq = loongson3_perfcount_handler;
 
@@ -204,7 +197,7 @@ static int __init loongson3_init(void)
 static void loongson3_exit(void)
 {
 	on_each_cpu(reset_counters, NULL, 1);
-	unregister_hotcpu_notifier(&loongson3_notifier_block);
+	cpuhp_remove_state_nocalls(CPUHP_AP_MIPS_OP_LOONGSON3_STARTING);
 	perf_irq = save_perf_irq;
 }
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f986963..18dbf7b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -36,6 +36,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
 	CPUHP_AP_PERF_METAG_STARTING,
+	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
-- 
2.8.1
