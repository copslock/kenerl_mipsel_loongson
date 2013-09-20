Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Sep 2013 00:47:22 +0200 (CEST)
Received: from fifo99.com ([67.223.236.141]:36674 "EHLO fifo99.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823124Ab3ITWrOq4gIy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Sep 2013 00:47:14 +0200
Received: from zorba.lan (adsl-99-25-115-217.dsl.pltn13.sbcglobal.net [99.25.115.217])
        (Authenticated sender: dwalker)
        by fifo99.com (Postfix) with ESMTPSA id DA948327D3B0;
        Fri, 20 Sep 2013 15:46:46 -0700 (PDT)
From:   Daniel Walker <dwalker@fifo99.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Doug Thompson <dougthompson@xmission.com>
Cc:     linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: edac: octeon: add error injection support
Date:   Fri, 20 Sep 2013 15:46:41 -0700
Message-Id: <1379717202-26990-2-git-send-email-dwalker@fifo99.com>
X-Mailer: git-send-email 1.8.1.2
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@fifo99.com
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

This adds an ad-hoc error injection method. Octeon II doesn't have
hardware support for injection, so this simulates it.

Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 drivers/edac/octeon_edac-lmc.c | 177 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index 4881ad0..4bd10f9 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -5,12 +5,16 @@
  *
  * Copyright (C) 2009 Wind River Systems,
  *   written by Ralf Baechle <ralf@linux-mips.org>
+ *
+ * Copyright (c) 2013 by Cisco Systems, Inc.
+ * All rights reserved.
  */
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/edac.h>
+#include <linux/ctype.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-lmcx-defs.h>
@@ -20,6 +24,18 @@
 
 #define OCTEON_MAX_MC 4
 
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+struct octeon_lmc_pvt {
+	unsigned long inject;
+	unsigned long error_type;
+	unsigned long dimm;
+	unsigned long rank;
+	unsigned long bank;
+	unsigned long row;
+	unsigned long col;
+};
+
 static void octeon_lmc_edac_poll(struct mem_ctl_info *mci)
 {
 	union cvmx_lmcx_mem_cfg0 cfg0;
@@ -55,14 +71,31 @@ static void octeon_lmc_edac_poll(struct mem_ctl_info *mci)
 
 static void octeon_lmc_edac_poll_o2(struct mem_ctl_info *mci)
 {
+	struct octeon_lmc_pvt *pvt = mci->pvt_info;
 	union cvmx_lmcx_int int_reg;
 	bool do_clear = false;
 	char msg[64];
 
-	int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
+	if (!pvt->inject)
+		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
+	else {
+		if (pvt->error_type == 1)
+			int_reg.s.sec_err = 1;
+		if (pvt->error_type == 2)
+			int_reg.s.ded_err = 1;
+	}
+
 	if (int_reg.s.sec_err || int_reg.s.ded_err) {
 		union cvmx_lmcx_fadr fadr;
-		fadr.u64 = cvmx_read_csr(CVMX_LMCX_FADR(mci->mc_idx));
+		if (likely(!pvt->inject))
+			fadr.u64 = cvmx_read_csr(CVMX_LMCX_FADR(mci->mc_idx));
+		else {
+			fadr.cn61xx.fdimm = pvt->dimm;
+			fadr.cn61xx.fbunk = pvt->rank;
+			fadr.cn61xx.fbank = pvt->bank;
+			fadr.cn61xx.frow = pvt->row;
+			fadr.cn61xx.fcol = pvt->col;
+		}
 		snprintf(msg, sizeof(msg),
 			 "DIMM %d rank %d bank %d row %d col %d",
 			 fadr.cn61xx.fdimm, fadr.cn61xx.fbunk,
@@ -82,8 +115,128 @@ static void octeon_lmc_edac_poll_o2(struct mem_ctl_info *mci)
 		int_reg.s.ded_err = -1;	/* Done, re-arm */
 		do_clear = true;
 	}
-	if (do_clear)
-		cvmx_write_csr(CVMX_LMCX_INT(mci->mc_idx), int_reg.u64);
+
+	if (do_clear) {
+		if (likely(!pvt->inject))
+			cvmx_write_csr(CVMX_LMCX_INT(mci->mc_idx), int_reg.u64);
+		else
+			pvt->inject = 0;
+	}
+}
+
+/************************ MC SYSFS parts ***********************************/
+
+/* Only a couple naming differences per template, so very similar */
+#define TEMPLATE_SHOW(reg)						\
+static ssize_t octeon_mc_inject_##reg##_show(struct device *dev,	\
+			       struct device_attribute *attr,		\
+			       char *data)				\
+{									\
+	struct mem_ctl_info *mci = to_mci(dev);				\
+	struct octeon_lmc_pvt *pvt = mci->pvt_info;			\
+	return sprintf(data, "%016llu\n", (u64)pvt->reg);		\
+}
+
+#define TEMPLATE_STORE(reg)						\
+static ssize_t octeon_mc_inject_##reg##_store(struct device *dev,	\
+			       struct device_attribute *attr,		\
+			       const char *data, size_t count)		\
+{									\
+	struct mem_ctl_info *mci = to_mci(dev);				\
+	struct octeon_lmc_pvt *pvt = mci->pvt_info;			\
+	if (isdigit(*data)) {						\
+		if (!kstrtoul(data, 0, &pvt->reg))			\
+			return count;					\
+	}								\
+	return 0;							\
+}
+
+TEMPLATE_SHOW(inject);
+TEMPLATE_STORE(inject);
+TEMPLATE_SHOW(dimm);
+TEMPLATE_STORE(dimm);
+TEMPLATE_SHOW(bank);
+TEMPLATE_STORE(bank);
+TEMPLATE_SHOW(rank);
+TEMPLATE_STORE(rank);
+TEMPLATE_SHOW(row);
+TEMPLATE_STORE(row);
+TEMPLATE_SHOW(col);
+TEMPLATE_STORE(col);
+
+static ssize_t octeon_mc_inject_error_type_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *data,
+					  size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct octeon_lmc_pvt *pvt = mci->pvt_info;
+
+	if (!strncmp(data, "single", 6))
+		pvt->error_type = 1;
+	else if (!strncmp(data, "double", 6))
+		pvt->error_type = 2;
+
+	return count;
+}
+
+static ssize_t octeon_mc_inject_error_type_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct octeon_lmc_pvt *pvt = mci->pvt_info;
+	if (pvt->error_type == 1)
+		return sprintf(data, "single");
+	else if (pvt->error_type == 2)
+		return sprintf(data, "double");
+
+	return 0;
+}
+
+static DEVICE_ATTR(inject, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_inject_show, octeon_mc_inject_inject_store);
+static DEVICE_ATTR(error_type, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_error_type_show, octeon_mc_inject_error_type_store);
+static DEVICE_ATTR(dimm, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_dimm_show, octeon_mc_inject_dimm_store);
+static DEVICE_ATTR(rank, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_rank_show, octeon_mc_inject_rank_store);
+static DEVICE_ATTR(bank, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_bank_show, octeon_mc_inject_bank_store);
+static DEVICE_ATTR(row, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_row_show, octeon_mc_inject_row_store);
+static DEVICE_ATTR(col, S_IRUGO | S_IWUSR,
+		   octeon_mc_inject_col_show, octeon_mc_inject_col_store);
+
+
+static int octeon_set_mc_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_error_type);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_dimm);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_rank);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_bank);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_row);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_col);
+	if (rc < 0)
+		return rc;
+
+	return 0;
 }
 
 static int octeon_lmc_edac_probe(struct platform_device *pdev)
@@ -107,7 +260,7 @@ static int octeon_lmc_edac_probe(struct platform_device *pdev)
 			return 0;
 		}
 
-		mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, 0);
+		mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, sizeof(struct octeon_lmc_pvt));
 		if (!mci)
 			return -ENXIO;
 
@@ -124,6 +277,12 @@ static int octeon_lmc_edac_probe(struct platform_device *pdev)
 			return -ENXIO;
 		}
 
+		if (octeon_set_mc_sysfs_attributes(mci)) {
+			dev_err(&pdev->dev, "octeon_set_mc_sysfs_attributes() failed\n");
+			return -ENXIO;
+		}
+
+
 		cfg0.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(mc));
 		cfg0.s.intr_ded_ena = 0;	/* We poll */
 		cfg0.s.intr_sec_ena = 0;
@@ -139,7 +298,7 @@ static int octeon_lmc_edac_probe(struct platform_device *pdev)
 			return 0;
 		}
 
-		mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, 0);
+		mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, sizeof(struct octeon_lmc_pvt));
 		if (!mci)
 			return -ENXIO;
 
@@ -156,6 +315,12 @@ static int octeon_lmc_edac_probe(struct platform_device *pdev)
 			return -ENXIO;
 		}
 
+		if (octeon_set_mc_sysfs_attributes(mci)) {
+			dev_err(&pdev->dev, "octeon_set_mc_sysfs_attributes() failed\n");
+			return -ENXIO;
+		}
+
+
 		en.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(mc));
 		en.s.intr_ded_ena = 0;	/* We poll */
 		en.s.intr_sec_ena = 0;
-- 
1.8.1.2
