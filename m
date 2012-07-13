Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:28:40 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2344 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903727Ab2GMQYm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:42 +0200
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:14 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:23:49 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 99C529F9F5; Fri, 13
 Jul 2012 09:24:29 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:28 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 09/12] MIPS: Netlogic: Add support for built in DTB
Date:   Fri, 13 Jul 2012 21:53:22 +0530
Message-ID: <1342196605-4260-10-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94F84989490169-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Provide a config option to embed a device tree for XLP evaluation
boards. This DTB will be used if the firmware does not pass in a
device tree pointer.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/netlogic/Kconfig      |   15 +++++++++++++++
 arch/mips/netlogic/Makefile     |    1 +
 arch/mips/netlogic/dts/Makefile |    4 ++++
 arch/mips/netlogic/xlp/setup.c  |   12 +++++++++++-
 5 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/netlogic/dts/Makefile

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 61e1459..d80ed42 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -827,6 +827,7 @@ config NLM_XLP_BOARD
 	select ZONE_DMA if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
+	select USE_OF
 	help
 	  This board is based on Netlogic XLP Processor.
 	  Say Y here if you have a XLP based board.
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 75bec44..8059eb7 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -1,2 +1,17 @@
+if NLM_XLP_BOARD || NLM_XLR_BOARD
+
+if NLM_XLP_BOARD
+config DT_XLP_EVP
+	bool "Built-in device tree for XLP EVP/SVP boards"
+	default y
+	help
+	  Add an FDT blob for XLP EVP and SVP boards into the kernel.
+	  This DTB will be used if the firmware does not pass in a DTB
+          pointer to the kernel.  The corresponding DTS file is at
+          arch/mips/netlogic/dts/xlp_evp.dts
+endif
+
 config NLM_COMMON
 	bool
+
+endif
diff --git a/arch/mips/netlogic/Makefile b/arch/mips/netlogic/Makefile
index 36d169b..7602d13 100644
--- a/arch/mips/netlogic/Makefile
+++ b/arch/mips/netlogic/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_NLM_COMMON)	+=	common/
 obj-$(CONFIG_CPU_XLR)		+=	xlr/
 obj-$(CONFIG_CPU_XLP)		+=	xlp/
+obj-$(CONFIG_CPU_XLP)		+=	dts/
diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
new file mode 100644
index 0000000..67ae3fe
--- /dev/null
+++ b/arch/mips/netlogic/dts/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
+
+$(obj)/%.dtb: $(obj)/%.dts
+	$(call if_changed,dtc)
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 0d2d679..d899709 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -57,6 +57,7 @@ unsigned long nlm_common_ebase = 0x0;
 /* default to uniprocessor */
 uint32_t nlm_coremask = 1, nlm_cpumask  = 1;
 int  nlm_threads_per_core = 1;
+extern u32 __dtb_start[];
 
 static void nlm_linux_exit(void)
 {
@@ -97,9 +98,18 @@ void __init prom_init(void)
 {
 	void *fdtp;
 
-	fdtp = (void *)(long)fw_arg0;
 	xlp_mmu_init();
 	nlm_hal_init();
+
+	/*
+	 * If no FDT pointer is passed in, use the built-in FDT.
+	 * device_tree_init() does not handle CKSEG0 pointers in
+	 * 64-bit, so convert pointer.
+	 */
+	fdtp = (void *)(long)fw_arg0;
+	if (!fdtp)
+		fdtp = __dtb_start;
+	fdtp = phys_to_virt(__pa(fdtp));
 	early_init_devtree(fdtp);
 
 	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
-- 
1.7.9.5
