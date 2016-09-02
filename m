Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 12:01:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37387 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992029AbcIBKA3Inqtz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 12:00:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F3F5E4839EF45;
        Fri,  2 Sep 2016 11:00:09 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 11:00:12 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <lisa.parratt@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Qais Yousef <qsyousef@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/6] MIPS: smp.c: Introduce mechanism for freeing and allocating IPIs
Date:   Fri, 2 Sep 2016 10:59:52 +0100
Message-ID: <1472810395-21381-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54977
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

For the MIPS remote processor implementation, we need additional IPIs to
talk to the remote processor. Since MIPS GIC reserves exactly the right
number of IPI IRQs required by Linux for the number of VPs in the
system, this is not possible without releasing some recources.

This commit introduces mips_smp_ipi_allocate() which allocates IPIs to a
given cpumask. It is called as normal with the cpu_possible_mask at
bootup to initialise IPIs to all CPUs. mips_smp_ipi_free() may then be
used to free IPIs to a subset of those CPUs so that their hardware
resources can be reused.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/include/asm/smp.h | 14 +++++++++++
 arch/mips/kernel/smp.c      | 61 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 8bc6c70a4030..060f23ff1817 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -85,6 +85,20 @@ static inline void __cpu_die(unsigned int cpu)
 extern void play_dead(void);
 #endif
 
+/*
+ * This function will set up the necessary IPIs for Linux to communicate
+ * with the CPUs in mask.
+ * Return 0 on success.
+ */
+int mips_smp_ipi_allocate(const struct cpumask *mask);
+
+/*
+ * This function will free up IPIs allocated with mips_smp_ipi_allocate to the
+ * CPUs in mask, which must be a subset of the IPIs that have been configured.
+ * Return 0 on success.
+ */
+int mips_smp_ipi_free(const struct cpumask *mask);
+
 static inline void arch_send_call_function_single_ipi(int cpu)
 {
 	extern struct plat_smp_ops *mp_ops;	/* private */
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f95f094f36e4..afa06c2bb019 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -229,7 +229,7 @@ static struct irqaction irq_call = {
 	.name		= "IPI call"
 };
 
-static __init void smp_ipi_init_one(unsigned int virq,
+static void smp_ipi_init_one(unsigned int virq,
 				    struct irqaction *action)
 {
 	int ret;
@@ -239,9 +239,11 @@ static __init void smp_ipi_init_one(unsigned int virq,
 	BUG_ON(ret);
 }
 
-static int __init mips_smp_ipi_init(void)
+static unsigned int call_virq, sched_virq;
+
+int mips_smp_ipi_allocate(const struct cpumask *mask)
 {
-	unsigned int call_virq, sched_virq;
+	int virq;
 	struct irq_domain *ipidomain;
 	struct device_node *node;
 
@@ -268,16 +270,20 @@ static int __init mips_smp_ipi_init(void)
 	if (!ipidomain)
 		return 0;
 
-	call_virq = irq_reserve_ipi(ipidomain, cpu_possible_mask);
-	BUG_ON(!call_virq);
+	virq = irq_reserve_ipi(ipidomain, mask);
+	BUG_ON(!virq);
+	if (!call_virq)
+		call_virq = virq;
 
-	sched_virq = irq_reserve_ipi(ipidomain, cpu_possible_mask);
-	BUG_ON(!sched_virq);
+	virq = irq_reserve_ipi(ipidomain, mask);
+	BUG_ON(!virq);
+	if (!sched_virq)
+		sched_virq = virq;
 
 	if (irq_domain_is_ipi_per_cpu(ipidomain)) {
 		int cpu;
 
-		for_each_cpu(cpu, cpu_possible_mask) {
+		for_each_cpu(cpu, mask) {
 			smp_ipi_init_one(call_virq + cpu, &irq_call);
 			smp_ipi_init_one(sched_virq + cpu, &irq_resched);
 		}
@@ -286,6 +292,45 @@ static int __init mips_smp_ipi_init(void)
 		smp_ipi_init_one(sched_virq, &irq_resched);
 	}
 
+	return 0;
+}
+
+int mips_smp_ipi_free(const struct cpumask *mask)
+{
+	struct irq_domain *ipidomain;
+	struct device_node *node;
+
+	node = of_irq_find_parent(of_root);
+	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
+
+	/*
+	 * Some platforms have half DT setup. So if we found irq node but
+	 * didn't find an ipidomain, try to search for one that is not in the
+	 * DT.
+	 */
+	if (node && !ipidomain)
+		ipidomain = irq_find_matching_host(NULL, DOMAIN_BUS_IPI);
+
+	BUG_ON(!ipidomain);
+
+	if (irq_domain_is_ipi_per_cpu(ipidomain)) {
+		int cpu;
+
+		for_each_cpu(cpu, mask) {
+			remove_irq(call_virq + cpu, &irq_call);
+			remove_irq(sched_virq + cpu, &irq_resched);
+		}
+	}
+	irq_destroy_ipi(call_virq, mask);
+	irq_destroy_ipi(sched_virq, mask);
+	return 0;
+}
+
+
+static int __init mips_smp_ipi_init(void)
+{
+	mips_smp_ipi_allocate(cpu_possible_mask);
+
 	call_desc = irq_to_desc(call_virq);
 	sched_desc = irq_to_desc(sched_virq);
 
-- 
2.7.4
