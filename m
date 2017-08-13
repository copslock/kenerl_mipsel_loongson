Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:57:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30079 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992110AbdHMCy6zSSI6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:54:58 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 151E3E5E2E912;
        Sun, 13 Aug 2017 03:54:50 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:54:51 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 16/19] MIPS: SMP: Allow boot_secondary SMP op to return errors
Date:   Sat, 12 Aug 2017 19:49:40 -0700
Message-ID: <20170813024943.14989-17-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Allow the boot_secondary SMP op to return an error to __cpu_up(), which
will in turn return it to its caller.

This will allow SMP implementations to return errors quickly in cases
they they know have failed, rather than relying upon __cpu_up()
eventually timing out waiting for the cpu_running completion.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/cavium-octeon/smp.c         | 8 ++++++--
 arch/mips/include/asm/smp-ops.h       | 2 +-
 arch/mips/kernel/smp-bmips.c          | 4 +++-
 arch/mips/kernel/smp-cmp.c            | 3 ++-
 arch/mips/kernel/smp-cps.c            | 3 ++-
 arch/mips/kernel/smp-mt.c             | 4 +++-
 arch/mips/kernel/smp-up.c             | 3 ++-
 arch/mips/kernel/smp.c                | 6 +++++-
 arch/mips/loongson64/loongson-3/smp.c | 3 ++-
 arch/mips/netlogic/common/smp.c       | 4 +++-
 arch/mips/paravirt/paravirt-smp.c     | 3 ++-
 arch/mips/sgi-ip27/ip27-smp.c         | 3 ++-
 arch/mips/sibyte/bcm1480/smp.c        | 3 ++-
 arch/mips/sibyte/sb1250/smp.c         | 3 ++-
 14 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 163663a5363d..75e7c8625659 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -205,7 +205,7 @@ int plat_post_relocation(long offset)
  * Firmware CPU startup hook
  *
  */
-static void octeon_boot_secondary(int cpu, struct task_struct *idle)
+static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int count;
 
@@ -223,8 +223,12 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
 		udelay(1);
 		count--;
 	}
-	if (count == 0)
+	if (count == 0) {
 		pr_err("Secondary boot timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 38859e7b1f1f..e5f49dd453c7 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -26,7 +26,7 @@ struct plat_smp_ops {
 	void (*send_ipi_mask)(const struct cpumask *mask, unsigned int action);
 	void (*init_secondary)(void);
 	void (*smp_finish)(void);
-	void (*boot_secondary)(int cpu, struct task_struct *idle);
+	int (*boot_secondary)(int cpu, struct task_struct *idle);
 	void (*smp_setup)(void);
 	void (*prepare_cpus)(unsigned int max_cpus);
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 4ac576c68034..406072e26752 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -179,7 +179,7 @@ static void bmips_prepare_cpus(unsigned int max_cpus)
 /*
  * Tell the hardware to boot CPUx - runs on CPU0
  */
-static void bmips_boot_secondary(int cpu, struct task_struct *idle)
+static int bmips_boot_secondary(int cpu, struct task_struct *idle)
 {
 	bmips_smp_boot_sp = __KSTK_TOS(idle);
 	bmips_smp_boot_gp = (unsigned long)task_thread_info(idle);
@@ -231,6 +231,8 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 		}
 		cpumask_set_cpu(cpu, &bmips_booted_mask);
 	}
+
+	return 0;
 }
 
 /*
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 1acffdee88f4..04b21deea4f2 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -78,7 +78,7 @@ static void cmp_smp_finish(void)
  * __KSTK_TOS(idle) is apparently the stack pointer
  * (unsigned long)idle->thread_info the gp
  */
-static void cmp_boot_secondary(int cpu, struct task_struct *idle)
+static int cmp_boot_secondary(int cpu, struct task_struct *idle)
 {
 	struct thread_info *gp = task_thread_info(idle);
 	unsigned long sp = __KSTK_TOS(idle);
@@ -95,6 +95,7 @@ static void cmp_boot_secondary(int cpu, struct task_struct *idle)
 #endif
 
 	amon_cpu_start(cpu, pc, sp, (unsigned long)gp, a0);
+	return 0;
 }
 
 /*
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 7aac84ffc2af..4a4a25c722f1 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -288,7 +288,7 @@ static void remote_vpe_boot(void *dummy)
 	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(&current_cpu_data));
 }
 
-static void cps_boot_secondary(int cpu, struct task_struct *idle)
+static int cps_boot_secondary(int cpu, struct task_struct *idle)
 {
 	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
@@ -346,6 +346,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 	mips_cps_boot_vpes(core_cfg, vpe_id);
 out:
 	preempt_enable();
+	return 0;
 }
 
 static void cps_init_secondary(void)
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 5a7b5857d083..30415a74f312 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -152,7 +152,7 @@ static void vsmp_smp_finish(void)
  * (unsigned long)idle->thread_info the gp
  * assumes a 1:1 mapping of TC => VPE
  */
-static void vsmp_boot_secondary(int cpu, struct task_struct *idle)
+static int vsmp_boot_secondary(int cpu, struct task_struct *idle)
 {
 	struct thread_info *gp = task_thread_info(idle);
 	dvpe();
@@ -184,6 +184,8 @@ static void vsmp_boot_secondary(int cpu, struct task_struct *idle)
 	clear_c0_mvpcontrol(MVPCONTROL_VPC);
 
 	evpe(EVPE_ENABLE);
+
+	return 0;
 }
 
 /*
diff --git a/arch/mips/kernel/smp-up.c b/arch/mips/kernel/smp-up.c
index 4cf015a624d1..525d3196f793 100644
--- a/arch/mips/kernel/smp-up.c
+++ b/arch/mips/kernel/smp-up.c
@@ -39,8 +39,9 @@ static void up_smp_finish(void)
 /*
  * Firmware CPU startup hook
  */
-static void up_boot_secondary(int cpu, struct task_struct *idle)
+static int up_boot_secondary(int cpu, struct task_struct *idle)
 {
+	return 0;
 }
 
 static void __init up_smp_setup(void)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 6248a5a3ec9e..a4a59ed0164c 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -439,7 +439,11 @@ void smp_prepare_boot_cpu(void)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	mp_ops->boot_secondary(cpu, tidle);
+	int err;
+
+	err = mp_ops->boot_secondary(cpu, tidle);
+	if (err)
+		return err;
 
 	/*
 	 * We must check for timeout here, as the CPU will not be marked
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index bde64b0f1e47..8501109bb0f0 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -400,7 +400,7 @@ static void __init loongson3_prepare_cpus(unsigned int max_cpus)
 /*
  * Setup the PC, SP, and GP of a secondary processor and start it runing!
  */
-static void loongson3_boot_secondary(int cpu, struct task_struct *idle)
+static int loongson3_boot_secondary(int cpu, struct task_struct *idle)
 {
 	unsigned long startargs[4];
 
@@ -423,6 +423,7 @@ static void loongson3_boot_secondary(int cpu, struct task_struct *idle)
 			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x8));
 	loongson3_ipi_write64(startargs[0],
 			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
+	return 0;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 615027863f54..39a300bd6cc2 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -147,7 +147,7 @@ unsigned long nlm_next_gp;
 unsigned long nlm_next_sp;
 static cpumask_t phys_cpu_present_mask;
 
-void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
+int nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 {
 	uint64_t picbase;
 	int hwtid;
@@ -161,6 +161,8 @@ void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 	/* barrier for sp/gp store above */
 	__sync();
 	nlm_pic_send_ipi(picbase, hwtid, 1, 1);  /* NMI */
+
+	return 0;
 }
 
 void __init nlm_smp_setup(void)
diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
index b61b26ccf601..107d9f90d668 100644
--- a/arch/mips/paravirt/paravirt-smp.c
+++ b/arch/mips/paravirt/paravirt-smp.c
@@ -100,11 +100,12 @@ static void paravirt_smp_finish(void)
 	local_irq_enable();
 }
 
-static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
+static int paravirt_boot_secondary(int cpu, struct task_struct *idle)
 {
 	paravirt_smp_gp[cpu] = (unsigned long)task_thread_info(idle);
 	smp_wmb();
 	paravirt_smp_sp[cpu] = __KSTK_TOS(idle);
+	return 0;
 }
 
 static irqreturn_t paravirt_reched_interrupt(int irq, void *dev_id)
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 85ee974a1582..545446dfe7fa 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -195,7 +195,7 @@ static void ip27_smp_finish(void)
  * set sp to the kernel stack of the newly created idle process, gp to the proc
  * struct so that current_thread_info() will work.
  */
-static void ip27_boot_secondary(int cpu, struct task_struct *idle)
+static int ip27_boot_secondary(int cpu, struct task_struct *idle)
 {
 	unsigned long gp = (unsigned long)task_thread_info(idle);
 	unsigned long sp = __KSTK_TOS(idle);
@@ -203,6 +203,7 @@ static void ip27_boot_secondary(int cpu, struct task_struct *idle)
 	LAUNCH_SLAVE(cputonasid(cpu), cputoslice(cpu),
 		(launch_proc_t)MAPPED_KERN_RW_TO_K0(smp_bootstrap),
 		0, (void *) sp, (void *) gp);
+	return 0;
 }
 
 static void __init ip27_smp_setup(void)
diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.c
index 20091d5fe5a1..90c9d1255ad7 100644
--- a/arch/mips/sibyte/bcm1480/smp.c
+++ b/arch/mips/sibyte/bcm1480/smp.c
@@ -117,7 +117,7 @@ static void bcm1480_smp_finish(void)
  * Setup the PC, SP, and GP of a secondary processor and start it
  * running!
  */
-static void bcm1480_boot_secondary(int cpu, struct task_struct *idle)
+static int bcm1480_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int retval;
 
@@ -126,6 +126,7 @@ static void bcm1480_boot_secondary(int cpu, struct task_struct *idle)
 			       (unsigned long)task_thread_info(idle), 0);
 	if (retval != 0)
 		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
+	return retval;
 }
 
 /*
diff --git a/arch/mips/sibyte/sb1250/smp.c b/arch/mips/sibyte/sb1250/smp.c
index 46ce1298c27d..5baabca52f25 100644
--- a/arch/mips/sibyte/sb1250/smp.c
+++ b/arch/mips/sibyte/sb1250/smp.c
@@ -106,7 +106,7 @@ static void sb1250_smp_finish(void)
  * Setup the PC, SP, and GP of a secondary processor and start it
  * running!
  */
-static void sb1250_boot_secondary(int cpu, struct task_struct *idle)
+static int sb1250_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int retval;
 
@@ -115,6 +115,7 @@ static void sb1250_boot_secondary(int cpu, struct task_struct *idle)
 			       (unsigned long)task_thread_info(idle), 0);
 	if (retval != 0)
 		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
+	return retval;
 }
 
 /*
-- 
2.14.0
