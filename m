Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2012 23:31:14 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:60882 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903691Ab2EJVbF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 May 2012 23:31:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSaws-00011O-I3; Thu, 10 May 2012 16:30:58 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v2,5/5] MIPS: Add option to disable software I/O coherency.
Date:   Thu, 10 May 2012 16:30:46 -0500
Message-Id: <1336685446-25532-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Some MIPS controllers have hardware I/O coherency. This patch
detects those and turns off software coherency. A new kernel
command line option also allows the user to manually turn
software coherency on or off.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mach-generic/dma-coherence.h |    4 +-
 arch/mips/mm/c-r4k.c                               |   21 +---
 arch/mips/mm/dma-default.c                         |    8 +-
 arch/mips/mti-malta/malta-memory.c                 |    2 +-
 arch/mips/mti-malta/malta-setup.c                  |  102 ++++++++++++++++++++
 5 files changed, 117 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 9c95177..9f1cd31 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -63,7 +63,9 @@ static inline int plat_device_is_coherent(struct device *dev)
 	return 1;
 #endif
 #ifdef CONFIG_DMA_NONCOHERENT
-	return 0;
+	extern int coherentio;
+
+	return coherentio;
 #endif
 }
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c646a79..07ca54c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1389,26 +1389,13 @@ static void __cpuinit coherency_setup(void)
 	}
 }
 
-#if defined(CONFIG_DMA_NONCOHERENT)
-
-static int __cpuinitdata coherentio;
-
-static int __init setcoherentio(char *str)
-{
-	coherentio = 1;
-
-	return 1;
-}
-
-__setup("coherentio", setcoherentio);
-#endif
-
 void __cpuinit r4k_cache_init(void)
 {
 	extern void build_clear_page(void);
 	extern void build_copy_page(void);
 	extern char __weak except_vec2_generic;
 	extern char __weak except_vec2_sb1;
+	extern int coherentio;
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	switch (c->cputype) {
@@ -1479,8 +1466,10 @@ void __cpuinit r4k_cache_init(void)
 
 	build_clear_page();
 	build_copy_page();
-#if !defined(CONFIG_MIPS_CMP)
+
+	/* We want to run CMP kernels on core(s) with and without coherent caches */
+	/* Therefore can't use CONFIG_MIPS_CMP to decide to flush cache */
 	local_r4k___flush_cache_all(NULL);
-#endif
+
 	coherency_setup();
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 3fab204..058c2ca 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -100,6 +100,7 @@ EXPORT_SYMBOL(dma_alloc_noncoherent);
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t * dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
+	extern int hw_coherentio;
 	void *ret;
 
 	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
@@ -115,7 +116,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 
 		if (!plat_device_is_coherent(dev)) {
 			dma_cache_wback_inv((unsigned long) ret, size);
-			ret = UNCAC_ADDR(ret);
+			if (!hw_coherentio)
+				ret = UNCAC_ADDR(ret);
 		}
 	}
 
@@ -134,6 +136,7 @@ EXPORT_SYMBOL(dma_free_noncoherent);
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
+	extern int hw_coherentio;
 	unsigned long addr = (unsigned long) vaddr;
 	int order = get_order(size);
 
@@ -143,7 +146,8 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
 	if (!plat_device_is_coherent(dev))
-		addr = CAC_ADDR(addr);
+		if (!hw_coherentio)
+			addr = CAC_ADDR(addr);
 
 	free_pages(addr, get_order(size));
 }
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index a96d281..d57a233 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -158,7 +158,7 @@ void __init prom_meminit(void)
 		size = p->size;
 
 		add_memory_region(base, size, type);
-                p++;
+		p++;
 	}
 }
 
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index b45b343..4ca09bf 100644
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
@@ -105,6 +106,105 @@ static void __init fd_activate(void)
 }
 #endif
 
+int coherentio = -1;	/* no DMA cache coherency (may be set by user) */
+int hw_coherentio;	/* init to 0 => no HW DMA cache coherency (reflects real HW) */
+static int __init setcoherentio(char *str)
+{
+	if (coherentio < 0)
+		pr_info("Command line checking done before"
+				" plat_setup_iocoherency!!\n");
+	if (coherentio == 0)
+		pr_info("Command line enabling coherentio"
+				" (this will break...)!!\n");
+
+	coherentio = 1;
+	pr_info("Hardware DMA cache coherency (command line)\n");
+	return 1;
+}
+__setup("coherentio", setcoherentio);
+
+static int __init setnocoherentio(char *str)
+{
+	if (coherentio < 0)
+		pr_info("Command line checking done before"
+				" plat_setup_iocoherency!!\n");
+	if (coherentio == 1)
+		pr_info("Command line disabling coherentio\n");
+
+	coherentio = 0;
+	pr_info("Software DMA cache coherency (command line)\n");
+	return 1;
+}
+__setup("nocoherentio", setnocoherentio);
+
+static int __init
+plat_enable_iocoherency(void)
+{
+	int supported = 0;
+	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
+		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
+			pr_info("Enabled Bonito CPU coherency\n");
+			supported = 1;
+		}
+		if (strstr(prom_getcmdline(), "iobcuncached")) {
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
+			pr_crit("IOCU OPERATION DISABLED BY SWITCH"
+				" - DEFAULTING TO SW IO COHERENCY\n");
+			return 0;
+		}
+		supported = 1;
+	}
+	hw_coherentio = supported;
+	return supported;
+}
+
+static void __init
+plat_setup_iocoherency(void)
+{
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off
+	 */
+	if (plat_enable_iocoherency()) {
+		if (coherentio == 0)
+			pr_info("Hardware DMA cache coherency supported"
+					" but disabled from command line\n");
+		else {
+			coherentio = 1;
+			printk(KERN_INFO "Hardware DMA cache coherency\n");
+		}
+	} else {
+		if (coherentio == 1)
+			pr_info("Hardware DMA cache coherency not supported"
+				" but enabled from command line\n");
+		else {
+			coherentio = 0;
+			pr_info("Software DMA cache coherency\n");
+		}
+	}
+#else
+	if (!plat_enable_iocoherency())
+		panic("Hardware DMA cache coherency not supported");
+#endif
+}
+
 #ifdef CONFIG_BLK_DEV_IDE
 static void __init pci_clock_check(void)
 {
@@ -207,6 +307,8 @@ void __init plat_mem_setup(void)
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
 		bonito_quirks_setup();
 
+	plat_setup_iocoherency();
+
 #ifdef CONFIG_BLK_DEV_IDE
 	pci_clock_check();
 #endif
-- 
1.7.10
