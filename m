Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:54:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:59070 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834862AbaDPMxza5O4i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:53:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7274430D917E6
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:53:45 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:53:48 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:53:47 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:53:47 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/39] MIPS: traps: Add CPU PM callback for trap configuration
Date:   Wed, 16 Apr 2014 13:52:53 +0100
Message-ID: <1397652810-4336-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39809
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

From: James Hogan <james.hogan@imgtec.com>

Implement a CPU power management callback for restoring trap related CPU
configuration after CPU power up from a low power state. The following
state is restored:

- Status register
- HWREna register
- Exception vector configuration registers
- Context/XContext register

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mmu_context.h | 10 ++--
 arch/mips/kernel/traps.c            | 93 ++++++++++++++++++++++++++++---------
 2 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index e277bba..ba323b7 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -30,12 +30,15 @@ do {									\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 } while (0)
 
+#define TLBMISS_HANDLER_RESTORE()					\
+	write_c0_xcontext((unsigned long) smp_processor_id() <<		\
+			  SMP_CPUID_REGSHIFT)
+
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
 		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
-		write_c0_xcontext((unsigned long) smp_processor_id() <<	\
-						SMP_CPUID_REGSHIFT);	\
+		TLBMISS_HANDLER_RESTORE();				\
 	} while (0)
 
 #else /* !CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
@@ -48,8 +51,7 @@ do {									\
 extern unsigned long pgd_current[];
 
 #define TLBMISS_HANDLER_SETUP()						\
-	write_c0_context((unsigned long) smp_processor_id() <<		\
-						SMP_CPUID_REGSHIFT);	\
+	TLBMISS_HANDLER_RESTORE();					\
 	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 074e857..9651f68 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -15,6 +15,7 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
+#include <linux/cpu_pm.h>
 #include <linux/kexec.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -1865,32 +1866,16 @@ static int __init ulri_disable(char *s)
 }
 __setup("noulri", ulri_disable);
 
-void per_cpu_trap_init(bool is_boot_cpu)
+/* configure STATUS register */
+static void configure_status(void)
 {
-	unsigned int cpu = smp_processor_id();
-	unsigned int status_set = ST0_CU0;
-	unsigned int hwrena = cpu_hwrena_impl_bits;
-#ifdef CONFIG_MIPS_MT_SMTC
-	int secondaryTC = 0;
-	int bootTC = (cpu == 0);
-
-	/*
-	 * Only do per_cpu_trap_init() for first TC of Each VPE.
-	 * Note that this hack assumes that the SMTC init code
-	 * assigns TCs consecutively and in ascending order.
-	 */
-
-	if (((read_c0_tcbind() & TCBIND_CURTC) != 0) &&
-	    ((read_c0_tcbind() & TCBIND_CURVPE) == cpu_data[cpu - 1].vpe_id))
-		secondaryTC = 1;
-#endif /* CONFIG_MIPS_MT_SMTC */
-
 	/*
 	 * Disable coprocessors and select 32-bit or 64-bit addressing
 	 * and the 16/32 or 32/32 FPR register model.  Reset the BEV
 	 * flag that some firmware may have left set and the TS bit (for
 	 * IP27).  Set XX for ISA IV code to work.
 	 */
+	unsigned int status_set = ST0_CU0;
 #ifdef CONFIG_64BIT
 	status_set |= ST0_FR|ST0_KX|ST0_SX|ST0_UX;
 #endif
@@ -1901,6 +1886,12 @@ void per_cpu_trap_init(bool is_boot_cpu)
 
 	change_c0_status(ST0_CU|ST0_MX|ST0_RE|ST0_FR|ST0_BEV|ST0_TS|ST0_KX|ST0_SX|ST0_UX,
 			 status_set);
+}
+
+/* configure HWRENA register */
+static void configure_hwrena(void)
+{
+	unsigned int hwrena = cpu_hwrena_impl_bits;
 
 	if (cpu_has_mips_r2)
 		hwrena |= 0x0000000f;
@@ -1910,11 +1901,10 @@ void per_cpu_trap_init(bool is_boot_cpu)
 
 	if (hwrena)
 		write_c0_hwrena(hwrena);
+}
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	if (!secondaryTC) {
-#endif /* CONFIG_MIPS_MT_SMTC */
-
+static void configure_exception_vector(void)
+{
 	if (cpu_has_veic || cpu_has_vint) {
 		unsigned long sr = set_c0_status(ST0_BEV);
 		write_c0_ebase(ebase);
@@ -1930,6 +1920,34 @@ void per_cpu_trap_init(bool is_boot_cpu)
 		} else
 			set_c0_cause(CAUSEF_IV);
 	}
+}
+
+void per_cpu_trap_init(bool is_boot_cpu)
+{
+	unsigned int cpu = smp_processor_id();
+#ifdef CONFIG_MIPS_MT_SMTC
+	int secondaryTC = 0;
+	int bootTC = (cpu == 0);
+
+	/*
+	 * Only do per_cpu_trap_init() for first TC of Each VPE.
+	 * Note that this hack assumes that the SMTC init code
+	 * assigns TCs consecutively and in ascending order.
+	 */
+
+	if (((read_c0_tcbind() & TCBIND_CURTC) != 0) &&
+	    ((read_c0_tcbind() & TCBIND_CURVPE) == cpu_data[cpu - 1].vpe_id))
+		secondaryTC = 1;
+#endif /* CONFIG_MIPS_MT_SMTC */
+
+	configure_status();
+	configure_hwrena();
+
+#ifdef CONFIG_MIPS_MT_SMTC
+	if (!secondaryTC) {
+#endif /* CONFIG_MIPS_MT_SMTC */
+
+	configure_exception_vector();
 
 	/*
 	 * Before R2 both interrupt numbers were fixed to 7, so on R2 only:
@@ -2185,3 +2203,32 @@ void __init trap_init(void)
 
 	cu2_notifier(default_cu2_call, 0x80000000);	/* Run last  */
 }
+
+static int trap_pm_notifier(struct notifier_block *self, unsigned long cmd,
+			    void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		configure_status();
+		configure_hwrena();
+		configure_exception_vector();
+
+		/* Restore register with CPU number for TLB handlers */
+		TLBMISS_HANDLER_RESTORE();
+
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block trap_pm_notifier_block = {
+	.notifier_call = trap_pm_notifier,
+};
+
+static int __init trap_pm_init(void)
+{
+	return cpu_pm_register_notifier(&trap_pm_notifier_block);
+}
+arch_initcall(trap_pm_init);
-- 
1.8.5.3
