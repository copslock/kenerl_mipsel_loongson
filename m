Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 22:03:23 +0200 (CEST)
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:50590 "EHLO
        e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835054Ab3F0UDDVHcog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 22:03:03 +0200
Received: from /spool/local
        by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
        Fri, 28 Jun 2013 01:26:44 +0530
Received: from d28dlp03.in.ibm.com (9.184.220.128)
        by e28smtp03.in.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 28 Jun 2013 01:26:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
        by d28dlp03.in.ibm.com (Postfix) with ESMTP id 089841258056;
        Fri, 28 Jun 2013 01:31:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
        by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r5RK33V729950110;
        Fri, 28 Jun 2013 01:33:03 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
        by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r5RK2hE3017261;
        Thu, 27 Jun 2013 20:02:45 GMT
Received: from srivatsabhat.in.ibm.com ([9.79.209.72])
        by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id r5RK2fHO017109;
        Thu, 27 Jun 2013 20:02:41 GMT
From:   "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 38/45] MIPS: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To:     tglx@linutronix.de, peterz@infradead.org, tj@kernel.org,
        oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au,
        mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org,
        walken@google.com, vincent.guittot@linaro.org,
        laijs@cn.fujitsu.com, David.Laight@aculab.com
Cc:     rostedt@goodmis.org, wangyun@linux.vnet.ibm.com,
        xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, fweisbec@gmail.com,
        zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
        srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Yong Zhang <yong.zhang0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sanjay Lal <sanjayl@kymasys.com>,
        "Steven J. Hill" <sjhill@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        linux-mips@linux-mips.org,
        "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date:   Fri, 28 Jun 2013 01:29:28 +0530
Message-ID: <20130627195927.29830.84671.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: No
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13062719-3864-0000-0000-000008D5E93A
Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srivatsa.bhat@linux.vnet.ibm.com
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

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Yong Zhang <yong.zhang0@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Cc: "Steven J. Hill" <sjhill@mips.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/mips/kernel/cevt-smtc.c |    7 +++++++
 arch/mips/kernel/smp.c       |   16 ++++++++--------
 arch/mips/kernel/smtc.c      |   12 ++++++++++++
 arch/mips/mm/c-octeon.c      |    4 ++--
 arch/mips/mm/c-r4k.c         |    5 +++--
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
index 9de5ed7..2e6c0cd 100644
--- a/arch/mips/kernel/cevt-smtc.c
+++ b/arch/mips/kernel/cevt-smtc.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/irq.h>
 
 #include <asm/smtc_ipi.h>
@@ -84,6 +85,8 @@ static int mips_next_event(unsigned long delta,
 	unsigned long nextcomp = 0L;
 	int vpe = current_cpu_data.vpe_id;
 	int cpu = smp_processor_id();
+
+	get_online_cpus_atomic();
 	local_irq_save(flags);
 	mtflags = dmt();
 
@@ -164,6 +167,7 @@ static int mips_next_event(unsigned long delta,
 	}
 	emt(mtflags);
 	local_irq_restore(flags);
+	put_online_cpus_atomic();
 	return 0;
 }
 
@@ -177,6 +181,7 @@ void smtc_distribute_timer(int vpe)
 	unsigned long nextstamp;
 	unsigned long reference;
 
+	get_online_cpus_atomic();
 
 repeat:
 	nextstamp = 0L;
@@ -229,6 +234,8 @@ repeat:
 			> (unsigned long)LONG_MAX)
 				goto repeat;
 	}
+
+	put_online_cpus_atomic();
 }
 
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 6e7862a..be152b6 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -250,12 +250,12 @@ static inline void smp_on_other_tlbs(void (*func) (void *info), void *info)
 
 static inline void smp_on_each_tlb(void (*func) (void *info), void *info)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	smp_on_other_tlbs(func, info);
 	func(info);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 /*
@@ -273,7 +273,7 @@ static inline void smp_on_each_tlb(void (*func) (void *info), void *info)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
 		smp_on_other_tlbs(flush_tlb_mm_ipi, mm);
@@ -287,7 +287,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 	}
 	local_flush_tlb_mm(mm);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 struct flush_tlb_data {
@@ -307,7 +307,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned l
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
 		struct flush_tlb_data fd = {
 			.vma = vma,
@@ -325,7 +325,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned l
 		}
 	}
 	local_flush_tlb_range(vma, start, end);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 static void flush_tlb_kernel_range_ipi(void *info)
@@ -354,7 +354,7 @@ static void flush_tlb_page_ipi(void *info)
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 	if ((atomic_read(&vma->vm_mm->mm_users) != 1) || (current->mm != vma->vm_mm)) {
 		struct flush_tlb_data fd = {
 			.vma = vma,
@@ -371,7 +371,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 		}
 	}
 	local_flush_tlb_page(vma, page);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 static void flush_tlb_one_ipi(void *info)
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 75a4fd7..3cda8eb 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
@@ -1143,6 +1144,8 @@ static irqreturn_t ipi_interrupt(int irq, void *dev_idm)
 	 * for the current TC, so we ought not to have to do it explicitly here.
 	 */
 
+	get_online_cpus_atomic();
+
 	for_each_online_cpu(cpu) {
 		if (cpu_data[cpu].vpe_id != my_vpe)
 			continue;
@@ -1180,6 +1183,8 @@ static irqreturn_t ipi_interrupt(int irq, void *dev_idm)
 		}
 	}
 
+	put_online_cpus_atomic();
+
 	return IRQ_HANDLED;
 }
 
@@ -1383,6 +1388,7 @@ void smtc_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 	 * them, let's be really careful...
 	 */
 
+	get_online_cpus_atomic();
 	local_irq_save(flags);
 	if (smtc_status & SMTC_TLB_SHARED) {
 		mtflags = dvpe();
@@ -1438,6 +1444,7 @@ void smtc_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 	else
 		emt(mtflags);
 	local_irq_restore(flags);
+	put_online_cpus_atomic();
 }
 
 /*
@@ -1496,6 +1503,7 @@ void smtc_cflush_lockdown(void)
 {
 	int cpu;
 
+	get_online_cpus_atomic();
 	for_each_online_cpu(cpu) {
 		if (cpu != smp_processor_id()) {
 			settc(cpu_data[cpu].tc_id);
@@ -1504,6 +1512,7 @@ void smtc_cflush_lockdown(void)
 		}
 	}
 	mips_ihb();
+	put_online_cpus_atomic();
 }
 
 /* It would be cheating to change the cpu_online states during a flush! */
@@ -1512,6 +1521,8 @@ void smtc_cflush_release(void)
 {
 	int cpu;
 
+	get_online_cpus_atomic();
+
 	/*
 	 * Start with a hazard barrier to ensure
 	 * that all CACHE ops have played through.
@@ -1525,4 +1536,5 @@ void smtc_cflush_release(void)
 		}
 	}
 	mips_ihb();
+	put_online_cpus_atomic();
 }
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 8557fb5..8e1bcf6 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -73,7 +73,7 @@ static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
 	mb();
 	octeon_local_flush_icache();
 #ifdef CONFIG_SMP
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpu = smp_processor_id();
 
 	/*
@@ -88,7 +88,7 @@ static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
 	for_each_cpu(cpu, &mask)
 		octeon_send_ipi_single(cpu, SMP_ICACHE_FLUSH);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 #endif
 }
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 21813be..86c8b3e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -14,6 +14,7 @@
 #include <linux/linkage.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
@@ -46,13 +47,13 @@
  */
 static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 
 #if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
 	smp_call_function(func, info, 1);
 #endif
 	func(info);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 #if defined(CONFIG_MIPS_CMP)
