Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Mar 2013 15:56:15 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33600 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823031Ab3C0O4J1WQvA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Mar 2013 15:56:09 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UKrlg-0006xu-JS; Wed, 27 Mar 2013 09:56:00 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org,
        mcdonald.shane@gmail.com
Subject: [PATCH v6] MIPS: Add option to disable software I/O coherency.
Date:   Wed, 27 Mar 2013 09:55:54 -0500
Message-Id: <1364396154-2661-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Some MIPS controllers have hardware I/O coherency. This patch
detects those and turns off software coherency. A new kernel
command line option also allows the user to manually turn
software coherency on or off.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/dma-mapping.h                |    3 +
 arch/mips/include/asm/mach-generic/dma-coherence.h |    5 +-
 arch/mips/mm/c-r4k.c                               |   26 +++++---
 arch/mips/mm/dma-default.c                         |    5 +-
 arch/mips/mti-malta/malta-setup.c                  |   63 ++++++++++++++++++++
 arch/mips/mti-sead3/sead3-setup.c                  |    3 -
 6 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index f8fc74b..c8872ef 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -5,6 +5,9 @@
 #include <asm/cache.h>
 #include <asm-generic/dma-coherent.h>
 
+extern int coherentio;
+extern int hw_coherentio;
+
 #ifndef CONFIG_SGI_IP27 /* Kludge to fix 2.6.39 build for IP27 */
 #include <dma-coherence.h>
 #endif
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 9c95177..fe23034 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -61,9 +61,8 @@ static inline int plat_device_is_coherent(struct device *dev)
 {
 #ifdef CONFIG_DMA_COHERENT
 	return 1;
-#endif
-#ifdef CONFIG_DMA_NONCOHERENT
-	return 0;
+#else
+	return coherentio;
 #endif
 }
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b5aedb2..a4ec0e3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1381,19 +1381,24 @@ static void __cpuinit coherency_setup(void)
 	}
 }
 
-#if defined(CONFIG_DMA_NONCOHERENT)
-
-static int __cpuinitdata coherentio;
+int coherentio = 0;	/* User defined DMA coherency from command line. */
+int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
 
 static int __init setcoherentio(char *str)
 {
 	coherentio = 1;
-
+	pr_info("Hardware DMA cache coherency (command line)\n");
 	return 0;
 }
-
 early_param("coherentio", setcoherentio);
-#endif
+
+static int __init setnocoherentio(char *str)
+{
+	coherentio = 0;
+	pr_info("Software DMA cache coherency (command line)\n");
+	return 0;
+}
+early_param("nocoherentio", setnocoherentio);
 
 static void __cpuinit r4k_cache_error_setup(void)
 {
@@ -1476,9 +1481,14 @@ void __cpuinit r4k_cache_init(void)
 
 	build_clear_page();
 	build_copy_page();
-#if !defined(CONFIG_MIPS_CMP)
+
+	/*
+	 * We want to run CMP kernels on core with and without coherent
+	 * caches. Therefore, do not use CONFIG_MIPS_CMP to decide whether
+	 * or not to flush caches.
+	 */
 	local_r4k___flush_cache_all(NULL);
-#endif
+
 	coherency_setup();
 	board_cache_error_setup = r4k_cache_error_setup;
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index f9ef838..72ee4fe 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -115,7 +115,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 
 		if (!plat_device_is_coherent(dev)) {
 			dma_cache_wback_inv((unsigned long) ret, size);
-			ret = UNCAC_ADDR(ret);
+			if (!hw_coherentio)
+				ret = UNCAC_ADDR(ret);
 		}
 	}
 
@@ -142,7 +143,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
-	if (!plat_device_is_coherent(dev))
+	if (!plat_device_is_coherent(dev) && !hw_coherentio)
 		addr = CAC_ADDR(addr);
 
 	free_pages(addr, get_order(size));
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 200f64d..a855571 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -32,6 +32,7 @@
 #include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
 #include <asm/traps.h>
+#include <asm/gcmpregs.h>
 #ifdef CONFIG_VT
 #include <linux/console.h>
 #endif
@@ -105,6 +106,66 @@ static void __init fd_activate(void)
 }
 #endif
 
+static int __init plat_enable_iocoherency(void)
+{
+	int supported = 0;
+	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
+		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
+			pr_info("Enabled Bonito CPU coherency\n");
+			supported = 1;
+		}
+		if (strstr(fw_getcmdline(), "iobcuncached")) {
+			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
+				~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+				  BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			pr_info("Disabled Bonito IOBC coherency\n");
+		} else {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG |=
+				(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+				 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			pr_info("Enabled Bonito IOBC coherency\n");
+		}
+	} else if (gcmp_niocu() != 0) {
+		/* Nothing special needs to be done to enable coherency */
+		pr_info("CMP IOCU detected\n");
+		if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
+			pr_crit("IOCU OPERATION DISABLED BY SWITCH - DEFAULTING TO SW IO COHERENCY\n");
+			return 0;
+		}
+		supported = 1;
+	}
+	hw_coherentio = supported;
+	return supported;
+}
+
+static void __init plat_setup_iocoherency(void)
+{
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off and use hardware
+	 * coherency instead.
+	 */
+	if (plat_enable_iocoherency()) {
+		if (coherentio == 0)
+			pr_info("Hardware DMA cache coherency disabled\n");
+		else
+			pr_info("Hardware DMA cache coherency enabled\n");
+	} else {
+		if (coherentio == 1)
+			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
+		else
+			pr_info("Software DMA cache coherency enabled\n");
+	}
+#else
+	if (!plat_enable_iocoherency())
+		panic("Hardware DMA cache coherency not supported!");
+#endif
+}
+
 #ifdef CONFIG_BLK_DEV_IDE
 static void __init pci_clock_check(void)
 {
@@ -207,6 +268,8 @@ void __init plat_mem_setup(void)
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
 		bonito_quirks_setup();
 
+	plat_setup_iocoherency();
+
 #ifdef CONFIG_BLK_DEV_IDE
 	pci_clock_check();
 #endif
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index f012fd1..14633bc 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -13,9 +13,6 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/prom.h>
 
-int coherentio;		/* 0 => no DMA cache coherency (may be set by user) */
-int hw_coherentio;	/* 0 => no HW DMA cache coherency (reflects real HW) */
-
 const char *get_system_type(void)
 {
 	return "MIPS SEAD3";
-- 
1.7.9.5
