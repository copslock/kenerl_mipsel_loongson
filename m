Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 11:06:42 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35231 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491991AbZGJJGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 11:06:14 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A967Iw024445
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 02:06:07 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 02:06:07 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A966Mj021857;
	Fri, 10 Jul 2009 02:06:06 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 2/2] Avoid queing multiple reschedule IPI's in SMTC
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 02:06:00 -0700
Message-ID: <20090710090600.26243.2749.stgit@linux-raghu>
In-Reply-To: <20090710090529.26243.22320.stgit@linux-raghu>
References: <20090710090529.26243.22320.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 09:06:07.0380 (UTC) FILETIME=[A9052540:01CA013D]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Jaidev Patwardhan <jaidev@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/include/asm/smtc_ipi.h |    5 +++--
 arch/mips/kernel/smtc.c          |   33 +++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/smtc_ipi.h b/arch/mips/include/asm/smtc_ipi.h
index 8ce5175..832b8be 100644
--- a/arch/mips/include/asm/smtc_ipi.h
+++ b/arch/mips/include/asm/smtc_ipi.h
@@ -23,8 +23,8 @@ struct smtc_ipi {
 	void *arg;
 	int dest;
 #ifdef	SMTC_IPI_DEBUG
-	int sender;
-	long stamp;
+	unsigned sender;
+	unsigned long long stamp;
 #endif /* SMTC_IPI_DEBUG */
 };
 
@@ -45,6 +45,7 @@ struct smtc_ipi_q {
 	spinlock_t lock;
 	struct smtc_ipi *tail;
 	int depth;
+	int resched_flag;	/* reschedule already queued */
 };
 
 static inline void smtc_ipi_nq(struct smtc_ipi_q *q, struct smtc_ipi *p)
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index c16bb6d..ed4c04c 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -75,7 +75,6 @@ unsigned long irq_hwmask[NR_IRQS];
 
 asiduse smtc_live_asid[MAX_SMTC_TLBS][MAX_SMTC_ASIDS];
 
-
 /*
  * Number of InterProcessor Interrupt (IPI) message buffers to allocate
  */
@@ -388,6 +387,7 @@ void smtc_prepare_cpus(int cpus)
 		IPIQ[i].head = IPIQ[i].tail = NULL;
 		spin_lock_init(&IPIQ[i].lock);
 		IPIQ[i].depth = 0;
+		IPIQ[i].resched_flag = 0; /* No reschedules queued initially */
 	}
 
 	/* cpu_data index starts at zero */
@@ -741,11 +741,24 @@ void smtc_forward_irq(unsigned int irq)
 static void smtc_ipi_qdump(void)
 {
 	int i;
+	struct smtc_ipi *temp;
 
 	for (i = 0; i < NR_CPUS ;i++) {
-		printk("IPIQ[%d]: head = 0x%x, tail = 0x%x, depth = %d\n",
+		pr_info("IPIQ[%d]: head = 0x%x, tail = 0x%x, depth = %d\n",
 			i, (unsigned)IPIQ[i].head, (unsigned)IPIQ[i].tail,
 			IPIQ[i].depth);
+		temp = IPIQ[i].head;
+
+		while (temp != IPIQ[i].tail) {
+			pr_debug("%d %d %d: ", temp->type, temp->dest,
+			       (int)temp->arg);
+#ifdef	SMTC_IPI_DEBUG
+		    pr_debug("%u %lu\n", temp->sender, temp->stamp);
+#else
+		    pr_debug("\n");
+#endif
+		    temp = temp->flink;
+		}
 	}
 }
 
@@ -784,11 +797,15 @@ void smtc_send_ipi(int cpu, int type, unsigned int action)
 	int mtflags;
 	unsigned long tcrestart;
 	extern void r4k_wait_irqoff(void), __pastwait(void);
+	int set_resched_flag = (type == LINUX_SMP_IPI &&
+				action == SMP_RESCHEDULE_YOURSELF);
 
 	if (cpu == smp_processor_id()) {
 		printk("Cannot Send IPI to self!\n");
 		return;
 	}
+	if (set_resched_flag && IPIQ[cpu].resched_flag != 0)
+		return; /* There is a reschedule queued already */
 	/* Set up a descriptor, to be delivered either promptly or queued */
 	pipi = smtc_ipi_dq(&freeIPIq);
 	if (pipi == NULL) {
@@ -801,6 +818,7 @@ void smtc_send_ipi(int cpu, int type, unsigned int action)
 	pipi->dest = cpu;
 	if (cpu_data[cpu].vpe_id != cpu_data[smp_processor_id()].vpe_id) {
 		/* If not on same VPE, enqueue and send cross-VPE interrupt */
+		IPIQ[cpu].resched_flag |= set_resched_flag;
 		smtc_ipi_nq(&IPIQ[cpu], pipi);
 		LOCK_CORE_PRA();
 		settc(cpu_data[cpu].tc_id);
@@ -847,6 +865,7 @@ void smtc_send_ipi(int cpu, int type, unsigned int action)
 			 */
 			write_tc_c0_tchalt(0);
 			UNLOCK_CORE_PRA();
+			IPIQ[cpu].resched_flag |= set_resched_flag;
 			smtc_ipi_nq(&IPIQ[cpu], pipi);
 		} else {
 postdirect:
@@ -996,12 +1015,15 @@ void deferred_smtc_ipi(void)
 		 * already enabled.
 		 */
 		local_irq_save(flags);
-
 		spin_lock(&q->lock);
 		pipi = __smtc_ipi_dq(q);
 		spin_unlock(&q->lock);
-		if (pipi != NULL)
+		if (pipi != NULL) {
+			if (pipi->type == LINUX_SMP_IPI &&
+			    (int)pipi->arg == SMP_RESCHEDULE_YOURSELF)
+				IPIQ[cpu].resched_flag = 0;
 			ipi_decode(pipi);
+		}
 		/*
 		 * The use of the __raw_local restore isn't
 		 * as obviously necessary here as in smtc_ipi_replay(),
@@ -1082,6 +1104,9 @@ static irqreturn_t ipi_interrupt(int irq, void *dev_idm)
 				 * with interrupts off
 				 */
 				local_irq_save(flags);
+				if (pipi->type == LINUX_SMP_IPI &&
+				    (int)pipi->arg == SMP_RESCHEDULE_YOURSELF)
+					IPIQ[cpu].resched_flag = 0;
 				ipi_decode(pipi);
 				local_irq_restore(flags);
 			}
