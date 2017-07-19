Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 10:21:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1682 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990845AbdGSIVQWq6-B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 10:21:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 580E9CCD54CB2;
        Wed, 19 Jul 2017 09:21:06 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 19 Jul 2017 09:21:09 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Joe Perches <joe@perches.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH v2] MIPS: SMP: Constify smp ops
Date:   Wed, 19 Jul 2017 09:21:03 +0100
Message-ID: <1500452463-5609-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59142
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

smp_ops providers do not modify their ops structures, so they should be
made const for robustness. Since currently the MIPS kernel is not mapped
with memory protection, this does not in itself provide any security
benefit, but it still makes sense to make this change.

There are also slight code size efficincies from the structure being
made read-only, saving 128 bytes of kernel text on a
pistachio_defconfig.
Before:
   text	   data	    bss	    dec	    hex	filename
7187239	1772752	 470224	9430215	 8fe4c7	vmlinux
After:
   text	   data	    bss	    dec	    hex	filename
7187111	1772752	 470224	9430087	 8fe447	vmlinux

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v2:
Constify plat_smp_ops structs in providers missed by v1. All upstream
defconfigs now build.

 arch/mips/cavium-octeon/smp.c                    |  6 +++---
 arch/mips/fw/arc/init.c                          |  2 +-
 arch/mips/include/asm/bmips.h                    |  4 ++--
 arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
 arch/mips/include/asm/netlogic/common.h          |  2 +-
 arch/mips/include/asm/smp-ops.h                  | 12 ++++++------
 arch/mips/include/asm/smp.h                      | 10 +++++-----
 arch/mips/kernel/smp-bmips.c                     |  4 ++--
 arch/mips/kernel/smp-cmp.c                       |  2 +-
 arch/mips/kernel/smp-cps.c                       |  4 ++--
 arch/mips/kernel/smp-mt.c                        |  2 +-
 arch/mips/kernel/smp-up.c                        |  2 +-
 arch/mips/kernel/smp.c                           |  4 ++--
 arch/mips/loongson64/loongson-3/smp.c            |  2 +-
 arch/mips/netlogic/common/smp.c                  |  2 +-
 arch/mips/paravirt/paravirt-smp.c                |  2 +-
 arch/mips/paravirt/setup.c                       |  2 +-
 arch/mips/sgi-ip27/ip27-smp.c                    |  2 +-
 arch/mips/sibyte/bcm1480/smp.c                   |  2 +-
 arch/mips/sibyte/common/cfe.c                    |  4 ++--
 arch/mips/sibyte/sb1250/smp.c                    |  2 +-
 21 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 3de786545ded..163663a5363d 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -408,7 +408,7 @@ late_initcall(register_cavium_notifier);
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
-struct plat_smp_ops octeon_smp_ops = {
+const struct plat_smp_ops octeon_smp_ops = {
 	.send_ipi_single	= octeon_send_ipi_single,
 	.send_ipi_mask		= octeon_send_ipi_mask,
 	.init_secondary		= octeon_init_secondary,
@@ -485,7 +485,7 @@ static void octeon_78xx_send_ipi_mask(const struct cpumask *mask,
 		octeon_78xx_send_ipi_single(cpu, action);
 }
 
-static struct plat_smp_ops octeon_78xx_smp_ops = {
+static const struct plat_smp_ops octeon_78xx_smp_ops = {
 	.send_ipi_single	= octeon_78xx_send_ipi_single,
 	.send_ipi_mask		= octeon_78xx_send_ipi_mask,
 	.init_secondary		= octeon_init_secondary,
@@ -501,7 +501,7 @@ static struct plat_smp_ops octeon_78xx_smp_ops = {
 
 void __init octeon_setup_smp(void)
 {
-	struct plat_smp_ops *ops;
+	const struct plat_smp_ops *ops;
 
 	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
 		ops = &octeon_78xx_smp_ops;
diff --git a/arch/mips/fw/arc/init.c b/arch/mips/fw/arc/init.c
index 629b24db0d3a..008555969534 100644
--- a/arch/mips/fw/arc/init.c
+++ b/arch/mips/fw/arc/init.c
@@ -51,7 +51,7 @@ void __init prom_init(void)
 #endif
 #ifdef CONFIG_SGI_IP27
 	{
-		extern struct plat_smp_ops ip27_smp_ops;
+		extern const struct plat_smp_ops ip27_smp_ops;
 
 		register_smp_ops(&ip27_smp_ops);
 	}
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index a92aee7b977a..b3e2975f83d3 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -48,8 +48,8 @@
 #include <asm/r4kcache.h>
 #include <asm/smp-ops.h>
 
-extern struct plat_smp_ops bmips43xx_smp_ops;
-extern struct plat_smp_ops bmips5000_smp_ops;
+extern const struct plat_smp_ops bmips43xx_smp_ops;
+extern const struct plat_smp_ops bmips5000_smp_ops;
 
 static inline int register_bmips_smp_ops(void)
 {
diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index c68c0cc879c6..d0ae5d55413b 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -26,7 +26,7 @@ extern void mach_prepare_shutdown(void);
 /* environment arguments from bootloader */
 extern u32 cpu_clock_freq;
 extern u32 memsize, highmemsize;
-extern struct plat_smp_ops loongson3_smp_ops;
+extern const struct plat_smp_ops loongson3_smp_ops;
 
 /* loongson-specific command line, env and memory initialization */
 extern void __init prom_init_memory(void);
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index e0717d10e650..a6e6cbebe046 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -84,7 +84,7 @@ nlm_set_nmi_handler(void *handler)
  */
 void nlm_init_boot_cpu(void);
 unsigned int nlm_get_cpu_frequency(void);
-extern struct plat_smp_ops nlm_smp_ops;
+extern const struct plat_smp_ops nlm_smp_ops;
 extern char nlm_reset_entry[], nlm_reset_entry_end[];
 
 /* SWIOTLB */
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index db7c322f057f..38859e7b1f1f 100644
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
@@ -57,7 +57,7 @@ static inline void plat_smp_setup(void)
 	/* UP, nothing to do ...  */
 }
 
-static inline void register_smp_ops(struct plat_smp_ops *ops)
+static inline void register_smp_ops(const struct plat_smp_ops *ops)
 {
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
index bab3d41e5987..9e494f8d9c03 100644
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
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 1b070a76fcdd..f86d755e3d75 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -409,7 +409,7 @@ void __ref play_dead(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-struct plat_smp_ops bmips43xx_smp_ops = {
+const struct plat_smp_ops bmips43xx_smp_ops = {
 	.smp_setup		= bmips_smp_setup,
 	.prepare_cpus		= bmips_prepare_cpus,
 	.boot_secondary		= bmips_boot_secondary,
@@ -423,7 +423,7 @@ struct plat_smp_ops bmips43xx_smp_ops = {
 #endif
 };
 
-struct plat_smp_ops bmips5000_smp_ops = {
+const struct plat_smp_ops bmips5000_smp_ops = {
 	.smp_setup		= bmips_smp_setup,
 	.prepare_cpus		= bmips_prepare_cpus,
 	.boot_secondary		= bmips_boot_secondary,
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 76923349b4fe..1acffdee88f4 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -148,7 +148,7 @@ void __init cmp_prepare_cpus(unsigned int max_cpus)
 
 }
 
-struct plat_smp_ops cmp_smp_ops = {
+const struct plat_smp_ops cmp_smp_ops = {
 	.send_ipi_single	= mips_smp_send_ipi_single,
 	.send_ipi_mask		= mips_smp_send_ipi_mask,
 	.init_secondary		= cmp_init_secondary,
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index f832e99ad4c3..a6b8700563c7 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -571,7 +571,7 @@ static void cps_cpu_die(unsigned int cpu)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static struct plat_smp_ops cps_smp_ops = {
+static const struct plat_smp_ops cps_smp_ops = {
 	.smp_setup		= cps_smp_setup,
 	.prepare_cpus		= cps_prepare_cpus,
 	.boot_secondary		= cps_boot_secondary,
@@ -587,7 +587,7 @@ static struct plat_smp_ops cps_smp_ops = {
 
 bool mips_cps_smp_in_use(void)
 {
-	extern struct plat_smp_ops *mp_ops;
+	extern const struct plat_smp_ops *mp_ops;
 	return mp_ops == &cps_smp_ops;
 }
 
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index ed6b4df583ea..004ff5e8a820 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -239,7 +239,7 @@ static void __init vsmp_prepare_cpus(unsigned int max_cpus)
 	mips_mt_set_cpuoptions();
 }
 
-struct plat_smp_ops vsmp_smp_ops = {
+const struct plat_smp_ops vsmp_smp_ops = {
 	.send_ipi_single	= mips_smp_send_ipi_single,
 	.send_ipi_mask		= mips_smp_send_ipi_mask,
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
index 770d4d1516cb..4652a07ecb9c 100644
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
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index b7a355c3c408..5b5a44f50b0b 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -734,7 +734,7 @@ early_initcall(register_loongson3_notifier);
 
 #endif
 
-struct plat_smp_ops loongson3_smp_ops = {
+const struct plat_smp_ops loongson3_smp_ops = {
 	.send_ipi_single = loongson3_send_ipi_single,
 	.send_ipi_mask = loongson3_send_ipi_mask,
 	.init_secondary = loongson3_init_secondary,
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index bddf1ef553a4..eac3f2950b14 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -272,7 +272,7 @@ int nlm_wakeup_secondary_cpus(void)
 	return 0;
 }
 
-struct plat_smp_ops nlm_smp_ops = {
+const struct plat_smp_ops nlm_smp_ops = {
 	.send_ipi_single	= nlm_send_ipi_single,
 	.send_ipi_mask		= nlm_send_ipi_mask,
 	.init_secondary		= nlm_init_secondary,
diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
index 72eb1a56c645..b61b26ccf601 100644
--- a/arch/mips/paravirt/paravirt-smp.c
+++ b/arch/mips/paravirt/paravirt-smp.c
@@ -133,7 +133,7 @@ static void paravirt_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-struct plat_smp_ops paravirt_smp_ops = {
+const struct plat_smp_ops paravirt_smp_ops = {
 	.send_ipi_single	= paravirt_send_ipi_single,
 	.send_ipi_mask		= paravirt_send_ipi_mask,
 	.init_secondary		= paravirt_init_secondary,
diff --git a/arch/mips/paravirt/setup.c b/arch/mips/paravirt/setup.c
index cb8448b373a7..d2ffec1409a7 100644
--- a/arch/mips/paravirt/setup.c
+++ b/arch/mips/paravirt/setup.c
@@ -14,7 +14,7 @@
 #include <asm/smp-ops.h>
 #include <asm/time.h>
 
-extern struct plat_smp_ops paravirt_smp_ops;
+extern const struct plat_smp_ops paravirt_smp_ops;
 
 const char *get_system_type(void)
 {
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 4cd47d23d81a..85ee974a1582 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -231,7 +231,7 @@ static void __init ip27_prepare_cpus(unsigned int max_cpus)
 	/* We already did everything necessary earlier */
 }
 
-struct plat_smp_ops ip27_smp_ops = {
+const struct plat_smp_ops ip27_smp_ops = {
 	.send_ipi_single	= ip27_send_ipi_single,
 	.send_ipi_mask		= ip27_send_ipi_mask,
 	.init_secondary		= ip27_init_secondary,
diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.c
index d0e94ffcc1b8..20091d5fe5a1 100644
--- a/arch/mips/sibyte/bcm1480/smp.c
+++ b/arch/mips/sibyte/bcm1480/smp.c
@@ -157,7 +157,7 @@ static void __init bcm1480_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-struct plat_smp_ops bcm1480_smp_ops = {
+const struct plat_smp_ops bcm1480_smp_ops = {
 	.send_ipi_single	= bcm1480_send_ipi_single,
 	.send_ipi_mask		= bcm1480_send_ipi_mask,
 	.init_secondary		= bcm1480_init_secondary,
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index c1a11a11db7f..115399202eab 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -229,8 +229,8 @@ static int __init initrd_setup(char *str)
 
 #endif
 
-extern struct plat_smp_ops sb_smp_ops;
-extern struct plat_smp_ops bcm1480_smp_ops;
+extern const struct plat_smp_ops sb_smp_ops;
+extern const struct plat_smp_ops bcm1480_smp_ops;
 
 /*
  * prom_init is called just after the cpu type is determined, from setup_arch()
diff --git a/arch/mips/sibyte/sb1250/smp.c b/arch/mips/sibyte/sb1250/smp.c
index 0a4a2c3982d8..46ce1298c27d 100644
--- a/arch/mips/sibyte/sb1250/smp.c
+++ b/arch/mips/sibyte/sb1250/smp.c
@@ -146,7 +146,7 @@ static void __init sb1250_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-struct plat_smp_ops sb_smp_ops = {
+const struct plat_smp_ops sb_smp_ops = {
 	.send_ipi_single	= sb1250_send_ipi_single,
 	.send_ipi_mask		= sb1250_send_ipi_mask,
 	.init_secondary		= sb1250_init_secondary,
-- 
2.7.4
