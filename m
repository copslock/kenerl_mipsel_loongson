Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 14:02:16 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993418AbdKMNCJMGimS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 14:02:09 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 811EDAB7;
        Mon, 13 Nov 2017 13:02:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qsyousef@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 67/87] MIPS: SMP: Use a completion event to signal CPU up
Date:   Mon, 13 Nov 2017 13:56:24 +0100
Message-Id: <20171113125621.386609934@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171113125615.304035578@linuxfoundation.org>
References: <20171113125615.304035578@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit a00eeede507c975087b7b8df8cf2c9f88ba285de upstream.

If a secondary CPU failed to start, for any reason, the CPU requesting
the secondary to start would get stuck in the loop waiting for the
secondary to be present in the cpu_callin_map.

Rather than that, use a completion event to signal that the secondary
CPU has started and is waiting to synchronise counters.

Since the CPU presence will no longer be marked in cpu_callin_map,
remove the redundant test from arch_cpu_idle_dead().

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Maciej W. Rozycki <macro@imgtec.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Qais Yousef <qsyousef@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14502/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    4 +---
 arch/mips/kernel/smp.c     |   15 +++++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -50,9 +50,7 @@
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
-	/* What the heck is this check doing ? */
-	if (!cpumask_test_cpu(smp_processor_id(), &cpu_callin_map))
-		play_dead();
+	play_dead();
 }
 #endif
 
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
@@ -438,11 +439,13 @@ int __cpu_up(unsigned int cpu, struct ta
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
