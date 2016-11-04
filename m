Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 10:29:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23692 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990864AbcKDJ3KqB0n0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 10:29:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 50CBC9C9A8911;
        Fri,  4 Nov 2016 09:29:02 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 4 Nov 2016 09:29:04 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qsyousef@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] MIPS: smp: Use a completion event to signal CPU up
Date:   Fri, 4 Nov 2016 09:28:56 +0000
Message-ID: <1478251738-13593-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

If a secondary CPU failed to start, for any reason, the CPU requesting
the secondary to start would get stuck in the loop waiting for the
secondary to be present in the cpu_callin_map.

Rather than that, use a completion event to signal that the secondary
CPU has started and is waiting to synchronise counters.

Since the CPU presence will no longer be marked in cpu_callin_map,
remove the redundant test from arch_cpu_idle_dead().

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/kernel/process.c |  4 +---
 arch/mips/kernel/smp.c     | 15 +++++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 9514e5f2209f..9a8f61d7c83e 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -49,9 +49,7 @@
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
-	/* What the heck is this check doing ? */
-	if (!cpumask_test_cpu(smp_processor_id(), &cpu_callin_map))
-		play_dead();
+	play_dead();
 }
 #endif
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 7ebb1918e2ac..03daf9008124 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -68,6 +68,8 @@ EXPORT_SYMBOL(cpu_sibling_map);
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
+static DECLARE_COMPLETION(cpu_running);
+
 /*
  * A logcal cpu mask containing only one VPE per core to
  * reduce the number of IPIs on large MT systems.
@@ -369,7 +371,7 @@ asmlinkage void start_secondary(void)
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
-	cpumask_set_cpu(cpu, &cpu_callin_map);
+	complete(&cpu_running);
 	synchronise_count_slave(cpu);
 
 	set_cpu_online(cpu, true);
@@ -430,7 +432,6 @@ void smp_prepare_boot_cpu(void)
 {
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
-	cpumask_set_cpu(0, &cpu_callin_map);
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
@@ -438,11 +439,13 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	mp_ops->boot_secondary(cpu, tidle);
 
 	/*
-	 * Trust is futile.  We should really have timeouts ...
+	 * We must check for timeout here, as the CPU will not be marked
+	 * online until the counters are synchronised.
 	 */
-	while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
-		udelay(100);
-		schedule();
+	if (!wait_for_completion_timeout(&cpu_running,
+					 msecs_to_jiffies(1000))) {
+		pr_crit("CPU%u: failed to start\n", cpu);
+		return -EIO;
 	}
 
 	synchronise_count_master(cpu);
-- 
2.7.4
