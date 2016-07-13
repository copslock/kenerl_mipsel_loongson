Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:16:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28768 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993197AbcGMNNjlmBrh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 71C93F60527C8;
        Wed, 13 Jul 2016 14:13:30 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, Paul Burton
        <paul.burton@imgtec.com>, Leonid Yegoshin <leonid.yegoshin@imgtec.com>, Felix
 Fietkau <nbd@nbd.name>, Jayachandran C. <jchandra@broadcom.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 09/13] MIPS: c-r4k: Exclude sibling CPUs in SMP calls
Date:   Wed, 13 Jul 2016 14:12:52 +0100
Message-ID: <1468415576-12600-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
References: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When performing SMP calls to foreign cores, exclude sibling CPUs from
the provided map, as we already handle the local core on the current
CPU. This prevents an SMP call from for example core 0, VPE 1 to VPE 0
on the same core.

In the process the cpu_foreign_map cpumask is turned into an array of
cpumasks, so that each CPU has its own version of it which excludes
sibling CPUs. r4k_op_needs_ipi() is also updated to reflect that cache
management SMP calls are not needed when all CPUs are siblings (i.e.
there are no foreign CPUs according to the new cpu_foreign_map[]
semantics which exclude siblings).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Jayachandran C. <jchandra@broadcom.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/smp.h |  2 +-
 arch/mips/kernel/smp.c      |  6 ++++--
 arch/mips/mm/c-r4k.c        | 17 +++++++++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 0c534a03bb36..8bc6c70a4030 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -23,7 +23,7 @@
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
-extern cpumask_t cpu_foreign_map;
+extern cpumask_t cpu_foreign_map[];
 
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 783d5f50ab9d..f95f094f36e4 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -72,7 +72,7 @@ EXPORT_SYMBOL(cpu_core_map);
  * A logcal cpu mask containing only one VPE per core to
  * reduce the number of IPIs on large MT systems.
  */
-cpumask_t cpu_foreign_map __read_mostly;
+cpumask_t cpu_foreign_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_foreign_map);
 
 /* representing cpus for which sibling maps can be computed */
@@ -141,7 +141,9 @@ void calculate_cpu_foreign_map(void)
 			cpumask_set_cpu(i, &temp_foreign_map);
 	}
 
-	cpumask_copy(&cpu_foreign_map, &temp_foreign_map);
+	for_each_online_cpu(i)
+		cpumask_andnot(&cpu_foreign_map[i],
+			       &temp_foreign_map, &cpu_sibling_map[i]);
 }
 
 struct plat_smp_ops *mp_ops;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2a4bb5057ebc..57374f0c33f2 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -56,7 +56,9 @@
  * @type:	Type of cache operations (R4K_HIT or R4K_INDEX).
  *
  * Decides whether a cache op needs to be performed on every core in the system.
- * This may change depending on the @type of cache operation.
+ * This may change depending on the @type of cache operation, as well as the set
+ * of online CPUs, so preemption should be disabled by the caller to prevent CPU
+ * hotplug from changing the result.
  *
  * Returns:	1 if the cache operation @type should be done on every core in
  *		the system.
@@ -71,9 +73,15 @@ static inline bool r4k_op_needs_ipi(unsigned int type)
 
 	/*
 	 * Hardware doesn't globalize the required cache ops, so SMP calls may
-	 * be needed.
+	 * be needed, but only if there are foreign CPUs (non-siblings with
+	 * separate caches).
 	 */
-	return true;
+	/* cpu_foreign_map[] undeclared when !CONFIG_SMP */
+#ifdef CONFIG_SMP
+	return !cpumask_empty(&cpu_foreign_map[0]);
+#else
+	return false;
+#endif
 }
 
 /*
@@ -90,7 +98,8 @@ static inline void r4k_on_each_cpu(unsigned int type,
 {
 	preempt_disable();
 	if (r4k_op_needs_ipi(type))
-		smp_call_function_many(&cpu_foreign_map, func, info, 1);
+		smp_call_function_many(&cpu_foreign_map[smp_processor_id()],
+				       func, info, 1);
 	func(info);
 	preempt_enable();
 }
-- 
2.4.10
