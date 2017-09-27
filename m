Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 11:13:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16981 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990513AbdI0JNhOcpou (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 11:13:37 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 923CC18626AA8;
        Wed, 27 Sep 2017 10:13:27 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 27 Sep 2017 10:13:30 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        "# v4 . 1+ : 8f46cca1e6c0 : MIPS: SMP: Fix possibility of deadlock when
        bringing CPUs online" <stable@vger.kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>, Ying Huang <ying.huang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2] MIPS: SMP: Fix deadlock & online race
Date:   Wed, 27 Sep 2017 10:13:25 +0100
Message-ID: <1506503605-19369-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60172
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

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Fixes: 6f542ebeaee0 ("MIPS: Fix race on setting and getting cpu_online_mask")
CC: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc: <stable@vger.kernel.org> # v4.1+: 8f46cca1e6c0: "MIPS: SMP: Fix possibility of deadlock when bringing CPUs online"
Cc: <stable@vger.kernel.org> # v4.1+: a00eeede507c: "MIPS: SMP: Use a completion event to signal CPU up"
Cc: <stable@vger.kernel.org> # v4.1+: 6f542ebeaee0: "MIPS: Fix race on setting and getting cpu_online_mask"
Cc: <stable@vger.kernel.org> # v4.1+
---

Changes in v2:
Machine readable stable backport dependencies in commit message

 arch/mips/kernel/smp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index bbe19b64def5..02a741ffb163 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -66,6 +66,7 @@ EXPORT_SYMBOL(cpu_sibling_map);
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
+static DECLARE_COMPLETION(cpu_starting);
 static DECLARE_COMPLETION(cpu_running);
 
 /*
@@ -374,6 +375,12 @@ asmlinkage void start_secondary(void)
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
@@ -381,8 +388,11 @@ asmlinkage void start_secondary(void)
 
 	calculate_cpu_foreign_map();
 
+	/*
+	 * Notify boot CPU that we're up & online and it can safely return
+	 * from __cpu_up
+	 */
 	complete(&cpu_running);
-	synchronise_count_slave(cpu);
 
 	/*
 	 * irq will be enabled in ->smp_finish(), enabling it too early
@@ -445,17 +455,17 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	if (err)
 		return err;
 
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
