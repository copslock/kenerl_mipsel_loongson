Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2017 12:13:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29000 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992054AbdIGKNYB0BxL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Sep 2017 12:13:24 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0422A1B5149ED;
        Thu,  7 Sep 2017 10:57:37 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 7 Sep 2017 10:57:40 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        "# v4 . 1+" <stable@vger.kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-mips@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: SMP: Fix deadlock & online race
Date:   Thu, 7 Sep 2017 10:57:34 +0100
Message-ID: <1504778254-24380-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59953
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

Commit 6f542ebeaee0 ("MIPS: Fix race on setting and getting
cpu_online_mask") effectively reverted commit 8f46cca1e6c06 ("MIPS: SMP:
Fix possibility of deadlock when bringing CPUs online") and thus has
reinstated the possibility of deadlock.

The commit was based on testing of kernel v4.4, where the CPU hotplug
core code issued a BUG() if the starting CPU is not marked online when
the boot CPU returns from __cpu_up. The commit fixes this race (in
v4.4), but re-introduces the deadlock situation.

As noted in the commit message, upstream differs in this area. Commit
8df3e07e7f21f ("cpu/hotplug: Let upcoming cpu bring itself fully up")
adds a completion event in the CPU hotplug core code, making this race
impossible. However, people were unhappy with relying on the core code
to do the right thing.

To address the issues both commits were trying to fix, add a second
completion event in the MIPS smp hotplug path. It removes the
possibility of a race, since the MIPS smp hotplug code now synchronises
both the boot and secondary CPUs before they return to the hotplug core
code. It also addresses the deadlock by ensuring that the secondary CPU
is not marked online before it's counters are synchronised.

This fix should also be backported to fix the race condition introduced
by the backport of commit 8f46cca1e6c06 ("MIPS: SMP: Fix possibility of
deadlock when bringing CPUs online"), through really that race only
existed before commit 8df3e07e7f21f ("cpu/hotplug: Let upcoming cpu
bring itself fully up").
To apply cleanly it requires both commit a00eeede507c10 ("MIPS: SMP: Use
a completion event to signal CPU up") and commit 6f542ebeaee0 ("MIPS:
Fix race on setting and getting cpu_online_mask") to be applied.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
CC: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Fixes: 6f542ebeaee0 ("MIPS: Fix race on setting and getting cpu_online_mask")
Cc: <stable@vger.kernel.org> # v4.1+
Seires-cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/smp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 6bace7695788..20d7bc5f0eb5 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -66,6 +66,7 @@ EXPORT_SYMBOL(cpu_sibling_map);
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
+static DECLARE_COMPLETION(cpu_starting);
 static DECLARE_COMPLETION(cpu_running);
 
 /*
@@ -376,6 +377,12 @@ asmlinkage void start_secondary(void)
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
+	/* Notify boot CPU that we're starting & ready to sync counters */
+	complete(&cpu_starting);
+
+	synchronise_count_slave(cpu);
+
+	/* The CPU is running and counters synchronised, now mark it online */
 	set_cpu_online(cpu, true);
 
 	set_cpu_sibling_map(cpu);
@@ -383,8 +390,11 @@ asmlinkage void start_secondary(void)
 
 	calculate_cpu_foreign_map();
 
+	/*
+	 * Notify boot CPU that we're up & online and it can safely return
+	 * from __cpu_up
+	 */
 	complete(&cpu_running);
-	synchronise_count_slave(cpu);
 
 	/*
 	 * irq will be enabled in ->smp_finish(), enabling it too early
@@ -443,17 +453,17 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	mp_ops->boot_secondary(cpu, tidle);
 
-	/*
-	 * We must check for timeout here, as the CPU will not be marked
-	 * online until the counters are synchronised.
-	 */
-	if (!wait_for_completion_timeout(&cpu_running,
+	/* Wait for CPU to start and be ready to sync counters */
+	if (!wait_for_completion_timeout(&cpu_starting,
 					 msecs_to_jiffies(1000))) {
 		pr_crit("CPU%u: failed to start\n", cpu);
 		return -EIO;
 	}
 
 	synchronise_count_master(cpu);
+
+	/* Wait for CPU to finish startup & mark itself online before return */
+	wait_for_completion(&cpu_running);
 	return 0;
 }
 
-- 
2.7.4
