Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:44:38 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1225 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835031Ab3FJHkKrOrPj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:10 +0200
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:34:11 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:52 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:52 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id F1A61F2D72; Mon, 10
 Jun 2013 00:39:50 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 03/11] MIPS: Netlogic: Initialization when !CONFIG_SMP
Date:   Mon, 10 Jun 2013 13:11:02 +0530
Message-ID: <1370850070-5127-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5EF91R029041197-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36788
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

The core initialization and reset vector setup needs to be done
even when booting uniprocessor. Move this code from smp.c to setup.c

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/Makefile |    3 ++-
 arch/mips/netlogic/common/smp.c    |    6 ------
 arch/mips/netlogic/xlp/setup.c     |    8 ++++++++
 arch/mips/netlogic/xlp/wakeup.c    |    1 -
 arch/mips/netlogic/xlr/setup.c     |    6 ++++++
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index a396a39..362739d 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,4 +1,5 @@
 obj-y				+= irq.o time.o
 obj-y				+= nlm-dma.o
-obj-$(CONFIG_SMP)		+= smp.o smpboot.o reset.o
+obj-y				+= reset.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index ffba524..da3d3bc 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -254,15 +254,9 @@ unsupp:
 
 int __cpuinit nlm_wakeup_secondary_cpus(void)
 {
-	unsigned long reset_vec;
 	char *reset_data;
 	int threadmode;
 
-	/* Update reset entry point with CPU init code */
-	reset_vec = CKSEG1ADDR(RESET_VEC_PHYS);
-	memcpy((void *)reset_vec, (void *)nlm_reset_entry,
-			(nlm_reset_entry_end - nlm_reset_entry));
-
 	/* verify the mask and setup core config variables */
 	threadmode = nlm_parse_cpumask(&nlm_cpumask);
 
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 7b66949..5bdd354 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -98,11 +98,19 @@ void nlm_percpu_init(int hwcpuid)
 
 void __init prom_init(void)
 {
+	void *reset_vec;
+
 	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
+	nlm_init_boot_cpu();
 	xlp_mmu_init();
 	nlm_node_init(0);
 	xlp_dt_init((void *)(long)fw_arg0);
 
+	/* Update reset entry point with CPU init code */
+	reset_vec = (void *)CKSEG1ADDR(RESET_VEC_PHYS);
+	memcpy(reset_vec, (void *)nlm_reset_entry,
+			(nlm_reset_entry_end - nlm_reset_entry));
+
 #ifdef CONFIG_SMP
 	cpumask_setall(&nlm_cpumask);
 	nlm_wakeup_secondary_cpus();
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 1a7d529..abb3e08 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -137,7 +137,6 @@ void xlp_wakeup_secondary_cpus()
 	 * In case of u-boot, the secondaries are in reset
 	 * first wakeup core 0 threads
 	 */
-	nlm_init_boot_cpu();
 	xlp_boot_core0_siblings();
 
 	/* now get other cores out of reset */
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 89c8c10..7e27f85 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -196,6 +196,7 @@ void __init prom_init(void)
 {
 	int *argv, *envp;		/* passed as 32 bit ptrs */
 	struct psb_info *prom_infop;
+	void *reset_vec;
 #ifdef CONFIG_SMP
 	int i;
 #endif
@@ -208,6 +209,11 @@ void __init prom_init(void)
 	nlm_prom_info = *prom_infop;
 	nlm_init_node();
 
+	/* Update reset entry point with CPU init code */
+	reset_vec = (void *)CKSEG1ADDR(RESET_VEC_PHYS);
+	memcpy(reset_vec, (void *)nlm_reset_entry,
+			(nlm_reset_entry_end - nlm_reset_entry));
+
 	nlm_early_serial_setup();
 	build_arcs_cmdline(argv);
 	prom_add_memory();
-- 
1.7.9.5
