Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:43:29 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4694 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823058Ab3FJHkIFkAEG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:08 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:36:16 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:55 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:55 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 75253F2D72; Mon, 10
 Jun 2013 00:39:54 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 05/11] MIPS: Netlogic: move cpu_ready array to boot area
Date:   Mon, 10 Jun 2013 13:11:04 +0530
Message-ID: <1370850070-5127-6-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E7A31W33902855-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Move the nlm_cpu_ready[] array used by the cpu wakeup code to the
boot area, along with rest of the boot parameter code.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h |    6 ++++++
 arch/mips/netlogic/common/reset.S       |    6 ++++--
 arch/mips/netlogic/common/smp.c         |    6 +++---
 arch/mips/netlogic/common/smpboot.S     |    5 +++--
 arch/mips/netlogic/xlp/setup.c          |    1 +
 arch/mips/netlogic/xlp/wakeup.c         |    3 ++-
 arch/mips/netlogic/xlr/setup.c          |    1 +
 arch/mips/netlogic/xlr/wakeup.c         |    3 ++-
 8 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index 1b54adb..bb68c33 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -39,11 +39,17 @@
  * Common SMP definitions
  */
 #define RESET_VEC_PHYS		0x1fc00000
+#define RESET_VEC_SIZE		8192		/* 8KB reset code and data */
 #define RESET_DATA_PHYS		(RESET_VEC_PHYS + (1<<10))
+
+/* Offsets of parameters in the RESET_DATA_PHYS area */
 #define BOOT_THREAD_MODE	0
 #define BOOT_NMI_LOCK		4
 #define BOOT_NMI_HANDLER	8
 
+/* CPU ready flags for each CPU */
+#define BOOT_CPU_READY		2048
+
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
 #include <linux/spinlock.h>
diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 8fa25c2..a339126 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -216,8 +216,10 @@ EXPORT(nlm_boot_siblings)
 	ori	t1, ST0_KX
 #endif
 	mtc0	t1, CP0_STATUS
-	/* mark CPU ready */
-	PTR_LA	t1, nlm_cpu_ready
+
+	/* mark CPU ready, careful here, previous mtcr trashed registers */
+	li	t3, CKSEG1ADDR(RESET_DATA_PHYS)
+	ADDIU	t1, t3, BOOT_CPU_READY
 	sll	v1, v0, 2
 	PTR_ADDU t1, v1
 	li	t2, 1
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 1f66eef..885d293 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -145,7 +145,6 @@ void nlm_cpus_done(void)
  * Boot all other cpus in the system, initialize them, and bring them into
  * the boot function
  */
-int nlm_cpu_ready[NR_CPUS];
 unsigned long nlm_next_gp;
 unsigned long nlm_next_sp;
 static cpumask_t phys_cpu_present_mask;
@@ -168,6 +167,7 @@ void __init nlm_smp_setup(void)
 {
 	unsigned int boot_cpu;
 	int num_cpus, i, ncore;
+	volatile u32 *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
 	char buf[64];
 
 	boot_cpu = hard_smp_processor_id();
@@ -181,10 +181,10 @@ void __init nlm_smp_setup(void)
 	num_cpus = 1;
 	for (i = 0; i < NR_CPUS; i++) {
 		/*
-		 * nlm_cpu_ready array is not set for the boot_cpu,
+		 * cpu_ready array is not set for the boot_cpu,
 		 * it is only set for ASPs (see smpboot.S)
 		 */
-		if (nlm_cpu_ready[i]) {
+		if (cpu_ready[i]) {
 			cpumask_set_cpu(i, &phys_cpu_present_mask);
 			__cpu_number_map[i] = num_cpus;
 			__cpu_logical_map[num_cpus] = i;
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index 7c7e884..6029d1b 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -109,8 +109,9 @@ NESTED(nlm_rmiboot_preboot, 16, sp)
 	andi	t2, t0, 0x3	/* thread num */
 	sll	t0, 2		/* offset in cpu array */
 
-	PTR_LA	t1, nlm_cpu_ready /* mark CPU ready */
-	PTR_ADDU t1, t0
+	li	t3, CKSEG1ADDR(RESET_DATA_PHYS)
+	ADDIU	t1, t3, BOOT_CPU_READY
+	ADDU	t1, t0
 	li	t3, 1
 	sw	t3, 0(t1)
 
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 5bdd354..8f69924 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -108,6 +108,7 @@ void __init prom_init(void)
 
 	/* Update reset entry point with CPU init code */
 	reset_vec = (void *)CKSEG1ADDR(RESET_VEC_PHYS);
+	memset(reset_vec, 0, RESET_VEC_SIZE);
 	memcpy(reset_vec, (void *)nlm_reset_entry,
 			(nlm_reset_entry_end - nlm_reset_entry));
 
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index abb3e08..feb5736 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -82,6 +82,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 	struct nlm_soc_info *nodep;
 	uint64_t syspcibase;
 	uint32_t syscoremask;
+	volatile uint32_t *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
 	int core, n, cpu, count, val;
 
 	for (n = 0; n < NLM_NR_NODES; n++) {
@@ -125,7 +126,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 			/* spin until the first hw thread sets its ready */
 			count = 0x20000000;
 			do {
-				val = *(volatile int *)&nlm_cpu_ready[cpu];
+				val = cpu_ready[cpu];
 			} while (val == 0 && --count > 0);
 		}
 	}
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 7e27f85..214d123 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -211,6 +211,7 @@ void __init prom_init(void)
 
 	/* Update reset entry point with CPU init code */
 	reset_vec = (void *)CKSEG1ADDR(RESET_VEC_PHYS);
+	memset(reset_vec, 0, RESET_VEC_SIZE);
 	memcpy(reset_vec, (void *)nlm_reset_entry,
 			(nlm_reset_entry_end - nlm_reset_entry));
 
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
index 3ebf741..c06e4c9 100644
--- a/arch/mips/netlogic/xlr/wakeup.c
+++ b/arch/mips/netlogic/xlr/wakeup.c
@@ -53,6 +53,7 @@ int __cpuinit xlr_wakeup_secondary_cpus(void)
 {
 	struct nlm_soc_info *nodep;
 	unsigned int i, j, boot_cpu;
+	volatile u32 *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
 
 	/*
 	 *  In case of RMI boot, hit with NMI to get the cores
@@ -71,7 +72,7 @@ int __cpuinit xlr_wakeup_secondary_cpus(void)
 	nodep->coremask = 1;
 	for (i = 1; i < NLM_CORES_PER_NODE; i++) {
 		for (j = 1000000; j > 0; j--) {
-			if (nlm_cpu_ready[i * NLM_THREADS_PER_CORE])
+			if (cpu_ready[i * NLM_THREADS_PER_CORE])
 				break;
 			udelay(10);
 		}
-- 
1.7.9.5
