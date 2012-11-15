Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 00:40:36 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64445 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825937Ab2KOXkdSUEfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2012 00:40:33 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so1357238pad.36
        for <multiple recipients>; Thu, 15 Nov 2012 15:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AY0ZA4MLnmc0pvmg/I3m2ltLgJRLrzIQqsRvK/DxoI8=;
        b=WuIlRnxo1w9jFvRVkcSMzcXVCf66nXSUPOyBCOisfMa7mySDH7YI3hH1xldVYRBuPG
         vw6ln1ggRitJVOFa/U/V5bbHLzqY1+4jwCatQ+s0+FNmVuP60Tskn3iV1qqZrwj7Zl+I
         zm4LUcjQ9GLlLJzpxt6ZNNiMW9hldDycofvDToWqVx6Rn9/dpZRmh8BdRiXiavmVHwrq
         nWzKdeR6zHBUcHzdW5IWGKd6nhtITbt5CBS0D+/qonJURPp2hHtgvoXk5tUmDNKiziM3
         +4IqVYRbL1J+XELwlUcb2C6N7RLUdtjv+wvYEseIovYtgC2SDbZDcj9PDE1TyR2RDYdr
         Q4BA==
Received: by 10.68.115.75 with SMTP id jm11mr3670225pbb.28.1353022826179;
        Thu, 15 Nov 2012 15:40:26 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id x8sm10450563paw.16.2012.11.15.15.40.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 15:40:25 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id qAFNeICc010089;
        Thu, 15 Nov 2012 15:40:18 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id qAFNeHMg010088;
        Thu, 15 Nov 2012 15:40:17 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org
Subject: [RFC PATCH] MIPS/EDAC: Improve OCTEON EDAC support.
Date:   Thu, 15 Nov 2012 15:40:16 -0800
Message-Id: <1353022816-10055-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Some initialization errors are reported with the existing OCTEON EDAC
support patch.  Also some parts have more than one memory controller.

Fix the errors and add multiple controllers if present.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: linux-edac@vger.kernel.org
---

Ralf has the initial OCTEON EDAC patch queued for 3.8 (Reviewed-by:
Borislav Petkov <borislav.petkov@amd.com>).  We would like to add
these changes on top of that and have it meged via Ralf's
linux-mips.org tree.

Does this seem OK?


 arch/mips/cavium-octeon/setup.c |  30 +++++-
 arch/mips/mm/c-octeon.c         |  39 +++++--
 arch/mips/pci/pci-octeon.c      |   3 +-
 drivers/edac/octeon_edac-l2c.c  | 178 ++++++++++++++++++++++--------
 drivers/edac/octeon_edac-lmc.c  | 232 +++++++++++++++++++++++-----------------
 drivers/edac/octeon_edac-lmc.h  |  78 --------------
 drivers/edac/octeon_edac-pc.c   | 137 ++++++++++++------------
 drivers/edac/octeon_edac-pci.c  |  44 ++------
 8 files changed, 406 insertions(+), 335 deletions(-)
 delete mode 100644 drivers/edac/octeon_edac-lmc.h

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index f3a142a..796030b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1112,18 +1112,30 @@ void __init device_tree_init(void)
 	unflatten_device_tree();
 }
 
+static int __initdata disable_octeon_edac_p;
+
+static int __init disable_octeon_edac(char *str)
+{
+	disable_octeon_edac_p = 1;
+	return 0;
+}
+early_param("disable_octeon_edac", disable_octeon_edac);
+
 static char *edac_device_names[] = {
-	"co_l2c_edac",
-	"co_lmc_edac",
-	"co_pc_edac",
+	"octeon_l2c_edac",
+	"octeon_pc_edac",
 };
 
 static int __init edac_devinit(void)
 {
 	struct platform_device *dev;
 	int i, err = 0;
+	int num_lmc;
 	char *name;
 
+	if (disable_octeon_edac_p)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(edac_device_names); i++) {
 		name = edac_device_names[i];
 		dev = platform_device_register_simple(name, -1, NULL, 0);
@@ -1133,7 +1145,17 @@ static int __init edac_devinit(void)
 		}
 	}
 
+	num_lmc = OCTEON_IS_MODEL(OCTEON_CN68XX) ? 4 :
+		(OCTEON_IS_MODEL(OCTEON_CN56XX) ? 2 : 1);
+	for (i = 0; i < num_lmc; i++) {
+		dev = platform_device_register_simple("octeon_lmc_edac",
+						      i, NULL, 0);
+		if (IS_ERR(dev)) {
+			pr_err("Registation of octeon_lmc_edac %d failed!\n", i);
+			err = PTR_ERR(dev);
+		}
+	}
+
 	return err;
 }
-
 device_initcall(edac_devinit);
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 9f67553..6ec04da 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -286,10 +286,9 @@ void __cpuinit octeon_cache_init(void)
 	board_cache_error_setup = octeon_cache_error_setup;
 }
 
-/**
+/*
  * Handle a cache error exception
  */
-
 static RAW_NOTIFIER_HEAD(co_cache_error_chain);
 
 int register_co_cache_error_notifier(struct notifier_block *nb)
@@ -304,14 +303,39 @@ int unregister_co_cache_error_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_co_cache_error_notifier);
 
-static inline int co_cache_error_call_notifiers(unsigned long val)
+static void co_cache_error_call_notifiers(unsigned long val)
 {
-	return raw_notifier_call_chain(&co_cache_error_chain, val, NULL);
+	int rv = raw_notifier_call_chain(&co_cache_error_chain, val, NULL);
+	if ((rv & ~NOTIFY_STOP_MASK) != NOTIFY_OK) {
+		u64 dcache_err;
+		unsigned long coreid = cvmx_get_core_num();
+		u64 icache_err = read_octeon_c0_icacheerr();
+
+		if (val) {
+			dcache_err = cache_err_dcache[coreid];
+			cache_err_dcache[coreid] = 0;
+		} else {
+			dcache_err = read_octeon_c0_dcacheerr();
+		}
+
+		pr_err("Core%lu: Cache error exception:\n", coreid);
+		pr_err("cp0_errorepc == %lx\n", read_c0_errorepc());
+		if (icache_err & 1) {
+			pr_err("CacheErr (Icache) == %llx\n",
+			       (unsigned long long)icache_err);
+			write_octeon_c0_icacheerr(0);
+		}
+		if (dcache_err & 1) {
+			pr_err("CacheErr (Dcache) == %llx\n",
+			       (unsigned long long)dcache_err);
+		}
+	}
 }
 
-/**
+/*
  * Called when the the exception is recoverable
  */
+
 asmlinkage void cache_parity_error_octeon_recoverable(void)
 {
 	co_cache_error_call_notifiers(0);
@@ -319,11 +343,8 @@ asmlinkage void cache_parity_error_octeon_recoverable(void)
 
 /**
  * Called when the the exception is not recoverable
- *
- * The issue not that the cache error exception itself was non-recoverable
- * but that due to nesting of exception may have lost some state so can't
- * continue.
  */
+
 asmlinkage void cache_parity_error_octeon_non_recoverable(void)
 {
 	co_cache_error_call_notifiers(1);
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 8eb2ee3..5b5ed76 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -705,7 +705,8 @@ static int __init octeon_pci_setup(void)
 	 */
 	cvmx_write_csr(CVMX_NPI_PCI_INT_SUM2, -1);
 
-	if (IS_ERR(platform_device_register_simple("co_pci_edac", 0, NULL, 0)))
+	if (IS_ERR(platform_device_register_simple("octeon_pci_edac",
+						   -1, NULL, 0)))
 		pr_err("Registation of co_pci_edac failed!\n");
 
 	octeon_pci_dma_init();
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index 5f459aa..40fde6a 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -3,6 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Copyright (C) 2012 Cavium, Inc.
+ *
  * Copyright (C) 2009 Wind River Systems,
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
@@ -19,32 +21,124 @@
 
 #define EDAC_MOD_STR "octeon-l2c"
 
-static void co_l2c_poll(struct edac_device_ctl_info *l2c)
+static void octeon_l2c_poll_oct1(struct edac_device_ctl_info *l2c)
 {
-	union cvmx_l2t_err l2t_err;
+	union cvmx_l2t_err l2t_err, l2t_err_reset;
+	union cvmx_l2d_err l2d_err, l2d_err_reset;
 
+	l2t_err_reset.u64 = 0;
 	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
 	if (l2t_err.s.sec_err) {
 		edac_device_handle_ce(l2c, 0, 0,
-				      "Single bit error (corrected)");
-		l2t_err.s.sec_err = 1;		/* Reset */
-		cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
+				      "Tag Single bit error (corrected)");
+		l2t_err_reset.s.sec_err = 1;
 	}
 	if (l2t_err.s.ded_err) {
 		edac_device_handle_ue(l2c, 0, 0,
-				      "Double bit error (corrected)");
-		l2t_err.s.ded_err = 1;		/* Reset */
-		cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
+				      "Tag Double bit error (detected)");
+		l2t_err_reset.s.ded_err = 1;
+	}
+	if (l2t_err_reset.u64)
+		cvmx_write_csr(CVMX_L2T_ERR, l2t_err_reset.u64);
+
+	l2d_err_reset.u64 = 0;
+	l2d_err.u64 = cvmx_read_csr(CVMX_L2D_ERR);
+	if (l2d_err.s.sec_err) {
+		edac_device_handle_ce(l2c, 0, 1,
+				      "Data Single bit error (corrected)");
+		l2d_err_reset.s.sec_err = 1;
+	}
+	if (l2d_err.s.ded_err) {
+		edac_device_handle_ue(l2c, 0, 1,
+				      "Data Double bit error (detected)");
+		l2d_err_reset.s.ded_err = 1;
+	}
+	if (l2d_err_reset.u64)
+		cvmx_write_csr(CVMX_L2D_ERR, l2d_err_reset.u64);
+
+}
+
+static void _octeon_l2c_poll_oct2(struct edac_device_ctl_info *l2c, int tad)
+{
+	union cvmx_l2c_err_tdtx err_tdtx, err_tdtx_reset;
+	union cvmx_l2c_err_ttgx err_ttgx, err_ttgx_reset;
+	char buf1[64];
+	char buf2[80];
+
+	err_tdtx_reset.u64 = 0;
+	err_tdtx.u64 = cvmx_read_csr(CVMX_L2C_ERR_TDTX(tad));
+	if (err_tdtx.s.dbe || err_tdtx.s.sbe ||
+	    err_tdtx.s.vdbe || err_tdtx.s.vsbe)
+		snprintf(buf1, sizeof(buf1),
+			 "type:%d, syn:0x%x, way:%d",
+			 err_tdtx.s.type, err_tdtx.s.syn, err_tdtx.s.wayidx);
+
+	if (err_tdtx.s.dbe) {
+		snprintf(buf2, sizeof(buf2),
+			 "L2D Double bit error (detected):%s", buf1);
+		err_tdtx_reset.s.dbe = 1;
+		edac_device_handle_ue(l2c, tad, 1, buf2);
+	}
+	if (err_tdtx.s.sbe) {
+		snprintf(buf2, sizeof(buf2),
+			 "L2D Single bit error (corrected):%s", buf1);
+		err_tdtx_reset.s.sbe = 1;
+		edac_device_handle_ce(l2c, tad, 1, buf2);
+	}
+	if (err_tdtx.s.vdbe) {
+		snprintf(buf2, sizeof(buf2),
+			 "VBF Double bit error (detected):%s", buf1);
+		err_tdtx_reset.s.vdbe = 1;
+		edac_device_handle_ue(l2c, tad, 1, buf2);
+	}
+	if (err_tdtx.s.vsbe) {
+		snprintf(buf2, sizeof(buf2),
+			 "VBF Single bit error (corrected):%s", buf1);
+		err_tdtx_reset.s.vsbe = 1;
+		edac_device_handle_ce(l2c, tad, 1, buf2);
+	}
+	if (err_tdtx_reset.u64)
+		cvmx_write_csr(CVMX_L2C_ERR_TDTX(tad), err_tdtx_reset.u64);
+
+	err_ttgx_reset.u64 = 0;
+	err_ttgx.u64 = cvmx_read_csr(CVMX_L2C_ERR_TTGX(tad));
+
+	if (err_ttgx.s.dbe || err_ttgx.s.sbe)
+		snprintf(buf1, sizeof(buf1),
+			 "type:%d, syn:0x%x, way:%d",
+			 err_ttgx.s.type, err_ttgx.s.syn, err_ttgx.s.wayidx);
+
+	if (err_ttgx.s.dbe) {
+		snprintf(buf2, sizeof(buf2),
+			 "Tag Double bit error (detected):%s", buf1);
+		err_ttgx_reset.s.dbe = 1;
+		edac_device_handle_ue(l2c, tad, 0, buf2);
 	}
+	if (err_ttgx.s.sbe) {
+		snprintf(buf2, sizeof(buf2),
+			 "Tag Single bit error (corrected):%s", buf1);
+		err_ttgx_reset.s.sbe = 1;
+		edac_device_handle_ce(l2c, tad, 0, buf2);
+	}
+	if (err_ttgx_reset.u64)
+		cvmx_write_csr(CVMX_L2C_ERR_TTGX(tad), err_ttgx_reset.u64);
+}
+
+static void octeon_l2c_poll_oct2(struct edac_device_ctl_info *l2c)
+{
+	int i;
+	for (i = 0; i < l2c->nr_instances; i++)
+		_octeon_l2c_poll_oct2(l2c, i);
 }
 
-static int __devinit co_l2c_probe(struct platform_device *pdev)
+static int __devinit octeon_l2c_probe(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *l2c;
-	union cvmx_l2t_err l2t_err;
-	int res = 0;
 
-	l2c = edac_device_alloc_ctl_info(0, "l2c", 1, NULL, 0, 0,
+	int num_tads = OCTEON_IS_MODEL(OCTEON_CN68XX) ? 4 : 1;
+
+	/* 'Tags' are block 0, 'Data' is block 1*/
+	l2c = edac_device_alloc_ctl_info(0, "l2c", num_tads, "l2c", 2, 0,
 					 NULL, 0, edac_device_alloc_index());
 	if (!l2c)
 		return -ENOMEM;
@@ -55,29 +149,43 @@ static int __devinit co_l2c_probe(struct platform_device *pdev)
 
 	l2c->mod_name = "octeon-l2c";
 	l2c->ctl_name = "octeon_l2c_err";
-	l2c->edac_check = co_l2c_poll;
+
+
+	if (OCTEON_IS_MODEL(OCTEON_FAM_1_PLUS)) {
+		union cvmx_l2t_err l2t_err;
+		union cvmx_l2d_err l2d_err;
+
+		l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
+		l2t_err.s.sec_intena = 0;	/* We poll */
+		l2t_err.s.ded_intena = 0;
+		cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
+
+		l2d_err.u64 = cvmx_read_csr(CVMX_L2D_ERR);
+		l2d_err.s.sec_intena = 0;	/* We poll */
+		l2d_err.s.ded_intena = 0;
+		cvmx_write_csr(CVMX_L2T_ERR, l2d_err.u64);
+
+		l2c->edac_check = octeon_l2c_poll_oct1;
+	} else {
+		/* OCTEON II */
+		l2c->edac_check = octeon_l2c_poll_oct2;
+	}
 
 	if (edac_device_add_device(l2c) > 0) {
 		pr_err("%s: edac_device_add_device() failed\n", __func__);
 		goto err;
 	}
 
-	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
-	l2t_err.s.sec_intena = 0;	/* We poll */
-	l2t_err.s.ded_intena = 0;
-	l2t_err.s.sec_err = 1;		/* Clear, just in case */
-	l2t_err.s.ded_err = 1;
-	cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
 
 	return 0;
 
 err:
 	edac_device_free_ctl_info(l2c);
 
-	return res;
+	return -ENXIO;
 }
 
-static int co_l2c_remove(struct platform_device *pdev)
+static int octeon_l2c_remove(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *l2c = platform_get_drvdata(pdev);
 
@@ -87,32 +195,14 @@ static int co_l2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver co_l2c_driver = {
-	.probe = co_l2c_probe,
-	.remove = co_l2c_remove,
+static struct platform_driver octeon_l2c_driver = {
+	.probe = octeon_l2c_probe,
+	.remove = octeon_l2c_remove,
 	.driver = {
-		   .name = "co_l2c_edac",
+		   .name = "octeon_l2c_edac",
 	}
 };
-
-static int __init co_edac_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&co_l2c_driver);
-	if (ret)
-		pr_warning(EDAC_MOD_STR " EDAC failed to register\n");
-
-	return ret;
-}
-
-static void __exit co_edac_exit(void)
-{
-	platform_driver_unregister(&co_l2c_driver);
-}
-
-module_init(co_edac_init);
-module_exit(co_edac_exit);
+module_platform_driver(octeon_l2c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index e0c1e44..33bca76 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -12,139 +12,175 @@
 #include <linux/io.h>
 #include <linux/edac.h>
 
-#include <asm/octeon/cvmx.h>
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-lmcx-defs.h>
 
 #include "edac_core.h"
 #include "edac_module.h"
-#include "octeon_edac-lmc.h"
 
-#define EDAC_MOD_STR "octeon"
+#define OCTEON_MAX_MC 4
 
-static struct mem_ctl_info *mc_cavium;
-static void *lmc_base;
-
-static void co_lmc_poll(struct mem_ctl_info *mci)
+static void octeon_lmc_edac_poll(struct mem_ctl_info *mci)
 {
-	union lmc_mem_cfg0 cfg0;
-	union lmc_fadr fadr;
+	union cvmx_lmcx_mem_cfg0 cfg0;
+	bool do_clear = false;
 	char msg[64];
 
-	fadr.u64 = readq(lmc_base + LMC_FADR);
-	cfg0.u64 = readq(lmc_base + LMC_MEM_CFG0);
-	snprintf(msg, sizeof(msg), "DIMM %d rank %d bank %d row %d col %d",
-		fadr.fdimm, fadr.fbunk, fadr.fbank, fadr.frow, fadr.fcol);
-
-	if (cfg0.sec_err) {
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, 0, 0, 0, -1, -1, -1,
-				     msg, "");
-
-		cfg0.intr_sec_ena = -1;		/* Done, re-arm */
+	cfg0.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(mci->mc_idx));
+	if (cfg0.s.sec_err || cfg0.s.ded_err) {
+		union cvmx_lmcx_fadr fadr;
+		fadr.u64 = cvmx_read_csr(CVMX_LMCX_FADR(mci->mc_idx));
+		snprintf(msg, sizeof(msg),
+			 "DIMM %d rank %d bank %d row %d col %d",
+			 fadr.cn30xx.fdimm, fadr.cn30xx.fbunk,
+			 fadr.cn30xx.fbank, fadr.cn30xx.frow, fadr.cn30xx.fcol);
 	}
 
-	if (cfg0.ded_err) {
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, 0, 0, 0, -1, -1, -1,
-				     msg, "");
-		cfg0.intr_ded_ena = -1;		/* Done, re-arm */
+	if (cfg0.s.sec_err) {
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, 0, 0, 0,
+				     -1, -1, -1, msg, "");
+		cfg0.s.sec_err = -1;	/* Done, re-arm */
+		do_clear = true;
 	}
 
-	writeq(cfg0.u64, lmc_base + LMC_MEM_CFG0);
+	if (cfg0.s.ded_err) {
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, 0, 0, 0,
+				     -1, -1, -1, msg, "");
+		cfg0.s.ded_err = -1;	/* Done, re-arm */
+		do_clear = true;
+	}
+	if (do_clear)
+		cvmx_write_csr(CVMX_LMCX_MEM_CFG0(mci->mc_idx), cfg0.u64);
 }
 
-static int __devinit co_lmc_probe(struct platform_device *pdev)
+static void octeon_lmc_edac_poll_o2(struct mem_ctl_info *mci)
 {
-	struct mem_ctl_info *mci;
-	union lmc_mem_cfg0 cfg0;
-	int res = 0;
-
-	mci = edac_mc_alloc(0, 0, 0, 0);
-	if (!mci)
-		return -ENOMEM;
-
-	mci->pdev = &pdev->dev;
-	platform_set_drvdata(pdev, mci);
-	mci->dev_name = dev_name(&pdev->dev);
+	union cvmx_lmcx_int int_reg;
+	bool do_clear = false;
+	char msg[64];
 
-	mci->mod_name = "octeon-lmc";
-	mci->ctl_name = "co_lmc_err";
-	mci->edac_check = co_lmc_poll;
+	int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
+	if (int_reg.s.sec_err || int_reg.s.ded_err) {
+		union cvmx_lmcx_fadr fadr;
+		fadr.u64 = cvmx_read_csr(CVMX_LMCX_FADR(mci->mc_idx));
+		snprintf(msg, sizeof(msg),
+			 "DIMM %d rank %d bank %d row %d col %d",
+			 fadr.cn61xx.fdimm, fadr.cn61xx.fbunk,
+			 fadr.cn61xx.fbank, fadr.cn61xx.frow, fadr.cn61xx.fcol);
+	}
 
-	if (edac_mc_add_mc(mci) > 0) {
-		pr_err("%s: edac_mc_add_mc() failed\n", __func__);
-		goto err;
+	if (int_reg.s.sec_err) {
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, 0, 0, 0,
+				     -1, -1, -1, msg, "");
+		int_reg.s.sec_err = -1;	/* Done, re-arm */
+		do_clear = true;
 	}
 
-	cfg0.u64 = readq(lmc_base + LMC_MEM_CFG0);	/* We poll */
-	cfg0.intr_ded_ena = 0;
-	cfg0.intr_sec_ena = 0;
-	writeq(cfg0.u64, lmc_base + LMC_MEM_CFG0);
+	if (int_reg.s.ded_err) {
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, 0, 0, 0,
+				     -1, -1, -1, msg, "");
+		int_reg.s.ded_err = -1;	/* Done, re-arm */
+		do_clear = true;
+	}
+	if (do_clear)
+		cvmx_write_csr(CVMX_LMCX_INT(mci->mc_idx), int_reg.u64);
+}
 
-	mc_cavium = mci;
+static int __devinit octeon_lmc_edac_probe(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[1];
+	int mc = pdev->id;
+
+	layers[0].type = EDAC_MC_LAYER_CHANNEL;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = false;
+
+	if (OCTEON_IS_MODEL(OCTEON_FAM_1_PLUS)) {
+		union cvmx_lmcx_mem_cfg0 cfg0;
+
+		cfg0.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(0));
+		if (!cfg0.s.ecc_ena) {
+			dev_info(&pdev->dev, "Disabled (ECC not enabled)\n");
+			return 0;
+		}
+
+		mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, 0);
+		if (!mci)
+			return -ENXIO;
+
+		mci->pdev = &pdev->dev;
+		mci->dev_name = dev_name(&pdev->dev);
+
+		mci->mod_name = "octeon-lmc";
+		mci->ctl_name = "octeon-lmc-err";
+		mci->edac_check = octeon_lmc_edac_poll;
+
+		if (edac_mc_add_mc(mci)) {
+			dev_err(&pdev->dev, "edac_mc_add_mc() failed\n");
+			edac_mc_free(mci);
+			return -ENXIO;
+		}
+
+		cfg0.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(mc));
+		cfg0.s.intr_ded_ena = 0;	/* We poll */
+		cfg0.s.intr_sec_ena = 0;
+		cvmx_write_csr(CVMX_LMCX_MEM_CFG0(mc), cfg0.u64);
+	} else {
+		/* OCTEON II */
+		union cvmx_lmcx_int_en en;
+		union cvmx_lmcx_config config;
+
+		config.u64 = cvmx_read_csr(CVMX_LMCX_CONFIG(0));
+		if (!config.s.ecc_ena) {
+			dev_info(&pdev->dev, "Disabled (ECC not enabled)\n");
+			return 0;
+		}
+
+		mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, 0);
+		if (!mci)
+			return -ENXIO;
+
+		mci->pdev = &pdev->dev;
+		mci->dev_name = dev_name(&pdev->dev);
+
+		mci->mod_name = "octeon-lmc";
+		mci->ctl_name = "co_lmc_err";
+		mci->edac_check = octeon_lmc_edac_poll_o2;
+
+		if (edac_mc_add_mc(mci)) {
+			dev_err(&pdev->dev, "edac_mc_add_mc() failed\n");
+			edac_mc_free(mci);
+			return -ENXIO;
+		}
+
+		en.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(mc));
+		en.s.intr_ded_ena = 0;	/* We poll */
+		en.s.intr_sec_ena = 0;
+		cvmx_write_csr(CVMX_LMCX_MEM_CFG0(mc), en.u64);
+	}
+	platform_set_drvdata(pdev, mci);
 
 	return 0;
-
-err:
-	edac_mc_free(mci);
-
-	return res;
 }
 
-static int co_lmc_remove(struct platform_device *pdev)
+static int octeon_lmc_edac_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
-	mc_cavium = NULL;
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-
 	return 0;
 }
 
-static struct platform_driver co_lmc_driver = {
-	.probe = co_lmc_probe,
-	.remove = co_lmc_remove,
+static struct platform_driver octeon_lmc_edac_driver = {
+	.probe = octeon_lmc_edac_probe,
+	.remove = octeon_lmc_edac_remove,
 	.driver = {
-		   .name = "co_lmc_edac",
+		   .name = "octeon_lmc_edac",
 	}
 };
-
-static int __init co_edac_init(void)
-{
-	union lmc_mem_cfg0 cfg0;
-	int ret;
-
-	lmc_base = ioremap_nocache(LMC_BASE, LMC_SIZE);
-	if (!lmc_base)
-		return -ENOMEM;
-
-	cfg0.u64 = readq(lmc_base + LMC_MEM_CFG0);
-	if (!cfg0.ecc_ena) {
-		pr_info(EDAC_MOD_STR " LMC EDAC: ECC disabled, good bye\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	ret = platform_driver_register(&co_lmc_driver);
-	if (ret) {
-		pr_warning(EDAC_MOD_STR " LMC EDAC failed to register\n");
-		goto out;
-	}
-
-	return ret;
-
-out:
-	iounmap(lmc_base);
-
-	return ret;
-}
-
-static void __exit co_edac_exit(void)
-{
-	platform_driver_unregister(&co_lmc_driver);
-	iounmap(lmc_base);
-}
-
-module_init(co_edac_init);
-module_exit(co_edac_exit);
+module_platform_driver(octeon_lmc_edac_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
diff --git a/drivers/edac/octeon_edac-lmc.h b/drivers/edac/octeon_edac-lmc.h
deleted file mode 100644
index 246dc52..0000000
--- a/drivers/edac/octeon_edac-lmc.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * LMC Registers, see chapter 2.5
- *
- * These are RSL Type registers and are accessed indirectly across the
- * I/O bus, so accesses are slowish.  Not that it matters.  Any size load is
- * ok but stores must be 64-bit.
- */
-#define LMC_BASE		0x0001180088000000
-#define LMC_SIZE		0xb8
-
-#define LMC_MEM_CFG0		0x0000000000000000
-#define LMC_MEM_CFG1		0x0000000000000008
-#define LMC_CTL			0x0000000000000010
-#define LMC_DDR2_CTL		0x0000000000000018
-#define LMC_FADR		0x0000000000000020
-#define   LMC_FADR_FDIMM
-#define   LMC_FADR_FBUNK
-#define   LMC_FADR_FBANK
-#define   LMC_FADR_FROW
-#define   LMC_FADR_FCOL
-#define LMC_COMP_CTL		0x0000000000000028
-#define LMC_WODT_CTL		0x0000000000000030
-#define LMC_ECC_SYND		0x0000000000000038
-#define LMC_IFB_CNT_LO		0x0000000000000048
-#define LMC_IFB_CNT_HI		0x0000000000000050
-#define LMC_OPS_CNT_LO		0x0000000000000058
-#define LMC_OPS_CNT_HI		0x0000000000000060
-#define LMC_DCLK_CNT_LO		0x0000000000000068
-#define LMC_DCLK_CNT_HI		0x0000000000000070
-#define LMC_DELAY_CFG		0x0000000000000088
-#define LMC_CTL1		0x0000000000000090
-#define LMC_DUAL_MEM_CONFIG	0x0000000000000098
-#define LMC_RODT_COMP_CTL	0x00000000000000A0
-#define LMC_PLL_CTL		0x00000000000000A8
-#define LMC_PLL_STATUS		0x00000000000000B0
-
-union lmc_mem_cfg0 {
-	uint64_t u64;
-	struct {
-		uint64_t reserved_32_63:32;
-		uint64_t reset:1;
-		uint64_t silo_qc:1;
-		uint64_t bunk_ena:1;
-		uint64_t ded_err:4;
-		uint64_t sec_err:4;
-		uint64_t intr_ded_ena:1;
-		uint64_t intr_sec_ena:1;
-		uint64_t reserved_15_18:4;
-		uint64_t ref_int:5;
-		uint64_t pbank_lsb:4;
-		uint64_t row_lsb:3;
-		uint64_t ecc_ena:1;
-		uint64_t init_start:1;
-	};
-};
-
-union lmc_fadr {
-	uint64_t u64;
-	struct {
-		uint64_t reserved_32_63:32;
-		uint64_t fdimm:2;
-		uint64_t fbunk:1;
-		uint64_t fbank:3;
-		uint64_t frow:14;
-		uint64_t fcol:12;
-	};
-};
-
-union lmc_ecc_synd {
-	uint64_t u64;
-	struct {
-		uint64_t reserved_32_63:32;
-		uint64_t mrdsyn3:8;
-		uint64_t mrdsyn2:8;
-		uint64_t mrdsyn1:8;
-		uint64_t mrdsyn0:8;
-	};
-};
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index 9d13061..14a5e57 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -3,6 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Copyright (C) 2012 Cavium, Inc.
+ *
  * Copyright (C) 2009 Wind River Systems,
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
@@ -19,93 +21,112 @@
 #include <asm/octeon/cvmx.h>
 #include <asm/mipsregs.h>
 
-#define EDAC_MOD_STR "octeon"
-
 extern int register_co_cache_error_notifier(struct notifier_block *nb);
 extern int unregister_co_cache_error_notifier(struct notifier_block *nb);
 
 extern unsigned long long cache_err_dcache[NR_CPUS];
 
-static struct edac_device_ctl_info *ed_cavium;
+struct co_cache_error {
+	struct notifier_block notifier;
+	struct edac_device_ctl_info *ed;
+};
 
-/*
+/**
  * EDAC CPU cache error callback
  *
+ * @event: non-zero if unrecoverable.
  */
-
 static int  co_cache_error_event(struct notifier_block *this,
 	unsigned long event, void *ptr)
 {
+	struct co_cache_error *p = container_of(this, struct co_cache_error,
+						notifier);
+
 	unsigned int core = cvmx_get_core_num();
 	unsigned int cpu = smp_processor_id();
-	uint64_t icache_err = read_octeon_c0_icacheerr();
-	struct edac_device_ctl_info *ed = ed_cavium;
-
-	edac_device_printk(ed, KERN_ERR,
-			   "Cache error exception on core %d / processor %d:\n",
-			   core, cpu);
-	edac_device_printk(ed, KERN_ERR,
-			   "cp0_errorepc == %lx\n", read_c0_errorepc());
+	u64 icache_err = read_octeon_c0_icacheerr();
+	u64 dcache_err;
+
+	if (event) {
+		dcache_err = cache_err_dcache[core];
+		cache_err_dcache[core] = 0;
+	} else {
+		dcache_err = read_octeon_c0_dcacheerr();
+	}
+
 	if (icache_err & 1) {
-		edac_device_printk(ed, KERN_ERR, "CacheErr (Icache) == %llx\n",
-				   (unsigned long long)icache_err);
+		edac_device_printk(p->ed, KERN_ERR,
+				   "CacheErr (Icache):%llx, core %d/cpu %d, cp0_errorepc == %lx\n",
+				   (unsigned long long)icache_err, core, cpu,
+				   read_c0_errorepc());
 		write_octeon_c0_icacheerr(0);
-		edac_device_handle_ce(ed, 0, 0, ed->ctl_name);
+		edac_device_handle_ce(p->ed, cpu, 1, "icache");
 	}
-	if (cache_err_dcache[core] & 1) {
-		edac_device_printk(ed, KERN_ERR, "CacheErr (Dcache) == %llx\n",
-				   (unsigned long long)cache_err_dcache[core]);
-		cache_err_dcache[core] = 0;
-		edac_device_handle_ue(ed, 0, 0, ed->ctl_name);
+	if (dcache_err & 1) {
+		edac_device_printk(p->ed, KERN_ERR,
+				   "CacheErr (Dcache):%llx, core %d/cpu %d, cp0_errorepc == %lx\n",
+				   (unsigned long long)dcache_err, core, cpu,
+				   read_c0_errorepc());
+		if (event)
+			edac_device_handle_ue(p->ed, cpu, 0, "dcache");
+		else
+			edac_device_handle_ce(p->ed, cpu, 0, "dcache");
+
+		/* Clear the error indication */
+		if (OCTEON_IS_MODEL(OCTEON_FAM_2))
+			write_octeon_c0_dcacheerr(1);
+		else
+			write_octeon_c0_dcacheerr(0);
 	}
 
-	return NOTIFY_DONE;
+	return NOTIFY_STOP;
 }
 
-static struct notifier_block co_cache_error_notifier = {
-	.notifier_call = co_cache_error_event,
-};
-
 static int __devinit co_cache_error_probe(struct platform_device *pdev)
 {
-	struct edac_device_ctl_info *ed;
-	int res = 0;
+	struct co_cache_error *p = devm_kzalloc(&pdev->dev, sizeof(*p),
+						GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->notifier.notifier_call = co_cache_error_event;
+	platform_set_drvdata(pdev, p);
+
+	p->ed = edac_device_alloc_ctl_info(0, "cpu", num_possible_cpus(),
+					   "cache", 2, 0, NULL, 0,
+					   edac_device_alloc_index());
+	if (!p->ed)
+		goto err;
 
-	ed = edac_device_alloc_ctl_info(0, "cpu", 1, NULL, 0, 0, NULL, 0,
-					edac_device_alloc_index());
+	p->ed->dev = &pdev->dev;
 
-	ed->dev = &pdev->dev;
-	platform_set_drvdata(pdev, ed);
-	ed->dev_name = dev_name(&pdev->dev);
+	p->ed->dev_name = dev_name(&pdev->dev);
 
-	ed->mod_name = "octeon-cpu";
-	ed->ctl_name = "co_cpu_err";
+	p->ed->mod_name = "octeon-cpu";
+	p->ed->ctl_name = "cache";
 
-	if (edac_device_add_device(ed) > 0) {
+	if (edac_device_add_device(p->ed)) {
 		pr_err("%s: edac_device_add_device() failed\n", __func__);
-		goto err;
+		goto err1;
 	}
 
-	register_co_cache_error_notifier(&co_cache_error_notifier);
-	ed_cavium = ed;
+	register_co_cache_error_notifier(&p->notifier);
 
 	return 0;
 
+err1:
+	edac_device_free_ctl_info(p->ed);
 err:
-	edac_device_free_ctl_info(ed);
-
-	return res;
+	return -ENXIO;
 }
 
 static int co_cache_error_remove(struct platform_device *pdev)
 {
-	struct edac_device_ctl_info *ed = platform_get_drvdata(pdev);
+	struct co_cache_error *p = platform_get_drvdata(pdev);
 
-	unregister_co_cache_error_notifier(&co_cache_error_notifier);
-	ed_cavium = NULL;
+	unregister_co_cache_error_notifier(&p->notifier);
 	edac_device_del_device(&pdev->dev);
-	edac_device_free_ctl_info(ed);
-
+	edac_device_free_ctl_info(p->ed);
 	return 0;
 }
 
@@ -113,28 +134,10 @@ static struct platform_driver co_cache_error_driver = {
 	.probe = co_cache_error_probe,
 	.remove = co_cache_error_remove,
 	.driver = {
-		   .name = "co_pc_edac",
+		   .name = "octeon_pc_edac",
 	}
 };
-
-static int __init co_edac_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&co_cache_error_driver);
-	if (ret)
-		pr_warning(EDAC_MOD_STR "CPU err failed to register\n");
-
-	return ret;
-}
-
-static void __exit co_edac_exit(void)
-{
-	platform_driver_unregister(&co_cache_error_driver);
-}
-
-module_init(co_edac_init);
-module_exit(co_edac_exit);
+module_platform_driver(co_cache_error_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
diff --git a/drivers/edac/octeon_edac-pci.c b/drivers/edac/octeon_edac-pci.c
index e72b96e..758c1ef 100644
--- a/drivers/edac/octeon_edac-pci.c
+++ b/drivers/edac/octeon_edac-pci.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Copyright (C) 2012 Cavium, Inc.
  * Copyright (C) 2009 Wind River Systems,
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
@@ -20,9 +21,7 @@
 #include "edac_core.h"
 #include "edac_module.h"
 
-#define EDAC_MOD_STR "octeon"
-
-static void co_pci_poll(struct edac_pci_ctl_info *pci)
+static void octeon_pci_poll(struct edac_pci_ctl_info *pci)
 {
 	union cvmx_pci_cfg01 cfg01;
 
@@ -57,14 +56,9 @@ static void co_pci_poll(struct edac_pci_ctl_info *pci)
 		cfg01.s.mdpe = 1;		/* Reset */
 		octeon_npi_write32(CVMX_NPI_PCI_CFG01, cfg01.u32);
 	}
-	if (cfg01.s.mdpe) {
-		edac_pci_handle_npe(pci, "Master Data Parity Error");
-		cfg01.s.mdpe = 1;		/* Reset */
-		octeon_npi_write32(CVMX_NPI_PCI_CFG01, cfg01.u32);
-	}
 }
 
-static int __devinit co_pci_probe(struct platform_device *pdev)
+static int __devinit octeon_pci_probe(struct platform_device *pdev)
 {
 	struct edac_pci_ctl_info *pci;
 	int res = 0;
@@ -79,7 +73,7 @@ static int __devinit co_pci_probe(struct platform_device *pdev)
 
 	pci->mod_name = "octeon-pci";
 	pci->ctl_name = "octeon_pci_err";
-	pci->edac_check = co_pci_poll;
+	pci->edac_check = octeon_pci_poll;
 
 	if (edac_pci_add_device(pci, 0) > 0) {
 		pr_err("%s: edac_pci_add_device() failed\n", __func__);
@@ -94,7 +88,7 @@ err:
 	return res;
 }
 
-static int co_pci_remove(struct platform_device *pdev)
+static int octeon_pci_remove(struct platform_device *pdev)
 {
 	struct edac_pci_ctl_info *pci = platform_get_drvdata(pdev);
 
@@ -104,32 +98,14 @@ static int co_pci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver co_pci_driver = {
-	.probe = co_pci_probe,
-	.remove = co_pci_remove,
+static struct platform_driver octeon_pci_driver = {
+	.probe = octeon_pci_probe,
+	.remove = octeon_pci_remove,
 	.driver = {
-		   .name = "co_pci_edac",
+		   .name = "octeon_pci_edac",
 	}
 };
-
-static int __init co_edac_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&co_pci_driver);
-	if (ret)
-		pr_warning(EDAC_MOD_STR " PCI EDAC failed to register\n");
-
-	return ret;
-}
-
-static void __exit co_edac_exit(void)
-{
-	platform_driver_unregister(&co_pci_driver);
-}
-
-module_init(co_edac_init);
-module_exit(co_edac_exit);
+module_platform_driver(octeon_pci_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
-- 
1.7.11.7
