Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 15:37:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57305 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdBNOhVH6NxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 15:37:21 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id 7ED56BEE7106A;
        Tue, 14 Feb 2017 14:37:11 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Feb 2017 14:37:14 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 1/4] MIPS: SMP: Constify smp ops
Date:   Tue, 14 Feb 2017 14:37:05 +0000
Message-ID: <1487083028-19724-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56811
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

smp_ops providers do not modify their ops structures, so they may be
made const.

This change saves 128 bytes of kernel text on a pistachio_defconfig.
Before:
   text	   data	    bss	    dec	    hex	filename
7187239	1772752	 470224	9430215	 8fe4c7	vmlinux
After:
   text	   data	    bss	    dec	    hex	filename
7187111	1772752	 470224	9430087	 8fe447	vmlinux

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/include/asm/smp-ops.h | 10 +++++-----
 arch/mips/include/asm/smp.h     | 10 +++++-----
 arch/mips/kernel/smp-cps.c      |  4 ++--
 arch/mips/kernel/smp-mt.c       |  2 +-
 arch/mips/kernel/smp-up.c       |  2 +-
 arch/mips/kernel/smp.c          |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index db7c322f057f..cf12bde3aa78 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -35,11 +35,11 @@ struct plat_smp_ops {
 #endif
 };
 
-extern void register_smp_ops(struct plat_smp_ops *ops);
+extern void register_smp_ops(const struct plat_smp_ops *ops);
 
 static inline void plat_smp_setup(void)
 {
-	extern struct plat_smp_ops *mp_ops;	/* private */
+	extern const struct plat_smp_ops *mp_ops;	/* private */
 
 	mp_ops->smp_setup();
 }
@@ -66,7 +66,7 @@ static inline void register_smp_ops(struct plat_smp_ops *ops)
 static inline int register_up_smp_ops(void)
 {
 #ifdef CONFIG_SMP_UP
-	extern struct plat_smp_ops up_smp_ops;
+	extern const struct plat_smp_ops up_smp_ops;
 
 	register_smp_ops(&up_smp_ops);
 
@@ -79,7 +79,7 @@ static inline int register_up_smp_ops(void)
 static inline int register_cmp_smp_ops(void)
 {
 #ifdef CONFIG_MIPS_CMP
-	extern struct plat_smp_ops cmp_smp_ops;
+	extern const struct plat_smp_ops cmp_smp_ops;
 
 	if (!mips_cm_present())
 		return -ENODEV;
@@ -95,7 +95,7 @@ static inline int register_cmp_smp_ops(void)
 static inline int register_vsmp_smp_ops(void)
 {
 #ifdef CONFIG_MIPS_MT_SMP
-	extern struct plat_smp_ops vsmp_smp_ops;
+	extern const struct plat_smp_ops vsmp_smp_ops;
 
 	register_smp_ops(&vsmp_smp_ops);
 
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 98a117a05fbc..572191ac2961 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -58,7 +58,7 @@ extern void calculate_cpu_foreign_map(void);
  */
 static inline void smp_send_reschedule(int cpu)
 {
-	extern struct plat_smp_ops *mp_ops;	/* private */
+	extern const struct plat_smp_ops *mp_ops;	/* private */
 
 	mp_ops->send_ipi_single(cpu, SMP_RESCHEDULE_YOURSELF);
 }
@@ -66,14 +66,14 @@ static inline void smp_send_reschedule(int cpu)
 #ifdef CONFIG_HOTPLUG_CPU
 static inline int __cpu_disable(void)
 {
-	extern struct plat_smp_ops *mp_ops;	/* private */
+	extern const struct plat_smp_ops *mp_ops;	/* private */
 
 	return mp_ops->cpu_disable();
 }
 
 static inline void __cpu_die(unsigned int cpu)
 {
-	extern struct plat_smp_ops *mp_ops;	/* private */
+	extern const struct plat_smp_ops *mp_ops;	/* private */
 
 	mp_ops->cpu_die(cpu);
 }
@@ -97,14 +97,14 @@ int mips_smp_ipi_free(const struct cpumask *mask);
 
 static inline void arch_send_call_function_single_ipi(int cpu)
 {
-	extern struct plat_smp_ops *mp_ops;	/* private */
+	extern const struct plat_smp_ops *mp_ops;	/* private */
 
 	mp_ops->send_ipi_mask(cpumask_of(cpu), SMP_CALL_FUNCTION);
 }
 
 static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
-	extern struct plat_smp_ops *mp_ops;	/* private */
+	extern const struct plat_smp_ops *mp_ops;	/* private */
 
 	mp_ops->send_ipi_mask(mask, SMP_CALL_FUNCTION);
 }
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index a2544c2394e4..77c0db4d46e2 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -549,7 +549,7 @@ static void cps_cpu_die(unsigned int cpu)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static struct plat_smp_ops cps_smp_ops = {
+static const struct plat_smp_ops cps_smp_ops = {
 	.smp_setup		= cps_smp_setup,
 	.prepare_cpus		= cps_prepare_cpus,
 	.boot_secondary		= cps_boot_secondary,
@@ -565,7 +565,7 @@ static struct plat_smp_ops cps_smp_ops = {
 
 bool mips_cps_smp_in_use(void)
 {
-	extern struct plat_smp_ops *mp_ops;
+	extern const struct plat_smp_ops *mp_ops;
 	return mp_ops == &cps_smp_ops;
 }
 
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index e077ea3e11fb..22db83be8349 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -279,7 +279,7 @@ static void __init vsmp_prepare_cpus(unsigned int max_cpus)
 	mips_mt_set_cpuoptions();
 }
 
-struct plat_smp_ops vsmp_smp_ops = {
+const struct plat_smp_ops vsmp_smp_ops = {
 	.send_ipi_single	= vsmp_send_ipi_single,
 	.send_ipi_mask		= vsmp_send_ipi_mask,
 	.init_secondary		= vsmp_init_secondary,
diff --git a/arch/mips/kernel/smp-up.c b/arch/mips/kernel/smp-up.c
index 17878d71ef2b..4cf015a624d1 100644
--- a/arch/mips/kernel/smp-up.c
+++ b/arch/mips/kernel/smp-up.c
@@ -63,7 +63,7 @@ static void up_cpu_die(unsigned int cpu)
 }
 #endif
 
-struct plat_smp_ops up_smp_ops = {
+const struct plat_smp_ops up_smp_ops = {
 	.send_ipi_single	= up_send_ipi_single,
 	.send_ipi_mask		= up_send_ipi_mask,
 	.init_secondary		= up_init_secondary,
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 8c60a296294c..9f01a6f28f49 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -146,10 +146,10 @@ void calculate_cpu_foreign_map(void)
 			       &temp_foreign_map, &cpu_sibling_map[i]);
 }
 
-struct plat_smp_ops *mp_ops;
+const struct plat_smp_ops *mp_ops;
 EXPORT_SYMBOL(mp_ops);
 
-void register_smp_ops(struct plat_smp_ops *ops)
+void register_smp_ops(const struct plat_smp_ops *ops)
 {
 	if (mp_ops)
 		printk(KERN_WARNING "Overriding previously set SMP ops\n");
-- 
2.7.4
