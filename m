Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2009 22:05:32 +0000 (GMT)
Received: from relay3.sgi.com ([192.48.171.31]:36230 "EHLO relay.sgi.com")
	by ftp.linux-mips.org with ESMTP id S21103411AbZALWFa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2009 22:05:30 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [150.166.39.100])
	by relay3.corp.sgi.com (Postfix) with ESMTP id 5D242AC00A;
	Mon, 12 Jan 2009 14:05:21 -0800 (PST)
Received: from polaris-admin.engr.sgi.com (polaris-admin.engr.sgi.com [150.166.41.54])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id n0CM5KF7012556;
	Mon, 12 Jan 2009 14:05:20 -0800
Received: by polaris-admin.engr.sgi.com (Postfix, from userid 5508)
	id 671C25646613; Mon, 12 Jan 2009 14:05:20 -0800 (PST)
Message-Id: <20090112220520.303833000@polaris-admin.engr.sgi.com>
References: <20090112220519.566749000@polaris-admin.engr.sgi.com>
User-Agent: quilt/0.46-1
Date:	Mon, 12 Jan 2009 14:05:24 -0800
From:	Mike Travis <travis@sgi.com>
To:	Ingo Molnar <mingo@redhat.com>
Cc:	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/8] mips irq: update mips for new irq_desc
Content-Disposition: inline; filename=irq:update-mips-to-new-irq_desc
Return-Path: <travis@cthulhu.engr.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: travis@sgi.com
Precedence: bulk
X-list: linux-mips

Impact: cleanup, update to new cpumask API

Irq_desc.affinity and irq_desc.pending_mask are now cpumask_var_t's
so access to them should be using the new cpumask API.

Signed-off-by: Mike Travis <travis@sgi.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
---
 arch/mips/include/asm/irq.h      |    2 +-
 arch/mips/kernel/irq-gic.c       |    2 +-
 arch/mips/kernel/smtc.c          |    2 +-
 arch/mips/mti-malta/malta-smtc.c |    5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6-for-ingo.orig/arch/mips/include/asm/irq.h
+++ linux-2.6-for-ingo/arch/mips/include/asm/irq.h
@@ -66,7 +66,7 @@ extern void smtc_forward_irq(unsigned in
  */
 #define IRQ_AFFINITY_HOOK(irq)						\
 do {									\
-    if (!cpu_isset(smp_processor_id(), irq_desc[irq].affinity)) {	\
+    if (!cpumask_test_cpu(smp_processor_id(), irq_desc[irq].affinity)) {\
 	smtc_forward_irq(irq);						\
 	irq_exit();							\
 	return;								\
--- linux-2.6-for-ingo.orig/arch/mips/kernel/irq-gic.c
+++ linux-2.6-for-ingo/arch/mips/kernel/irq-gic.c
@@ -187,7 +187,7 @@ static void gic_set_affinity(unsigned in
 		set_bit(irq, pcpu_masks[first_cpu(tmp)].pcpu_mask);
 
 	}
-	irq_desc[irq].affinity = *cpumask;
+	cpumask_copy(irq_desc[irq].affinity, cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 }
--- linux-2.6-for-ingo.orig/arch/mips/kernel/smtc.c
+++ linux-2.6-for-ingo/arch/mips/kernel/smtc.c
@@ -686,7 +686,7 @@ void smtc_forward_irq(unsigned int irq)
 	 * and efficiency, we just pick the easiest one to find.
 	 */
 
-	target = first_cpu(irq_desc[irq].affinity);
+	target = cpumask_first(irq_desc[irq].affinity);
 
 	/*
 	 * We depend on the platform code to have correctly processed
--- linux-2.6-for-ingo.orig/arch/mips/mti-malta/malta-smtc.c
+++ linux-2.6-for-ingo/arch/mips/mti-malta/malta-smtc.c
@@ -116,7 +116,7 @@ struct plat_smp_ops msmtc_smp_ops = {
 
 void plat_set_irq_affinity(unsigned int irq, const struct cpumask *affinity)
 {
-	cpumask_t tmask = *affinity;
+	cpumask_t tmask;
 	int cpu = 0;
 	void smtc_set_irq_affinity(unsigned int irq, cpumask_t aff);
 
@@ -139,11 +139,12 @@ void plat_set_irq_affinity(unsigned int 
 	 * be made to forward to an offline "CPU".
 	 */
 
+	cpumask_copy(&tmask, affinity);
 	for_each_cpu(cpu, affinity) {
 		if ((cpu_data[cpu].vpe_id != 0) || !cpu_online(cpu))
 			cpu_clear(cpu, tmask);
 	}
-	irq_desc[irq].affinity = tmask;
+	cpumask_copy(irq_desc[irq].affinity, &tmask);
 
 	if (cpus_empty(tmask))
 		/*

-- 
