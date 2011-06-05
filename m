Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 00:11:39 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60361 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491817Ab1FEWIh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 00:08:37 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B47EC8B0D;
        Mon,  6 Jun 2011 00:08:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5IcnT5bL7c4s; Mon,  6 Jun 2011 00:08:20 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-251-075.ewe-ip-backbone.de [91.97.251.75])
        by hauke-m.de (Postfix) with ESMTPSA id EA2058B12;
        Mon,  6 Jun 2011 00:08:11 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org
Cc:     zajec5@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC][PATCH 06/10] bcma: get CPU clock
Date:   Mon,  6 Jun 2011 00:07:34 +0200
Message-Id: <1307311658-15853-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3691

Add method to return the clock of the CPU. This is needed by the arch 
code to calculate the mips_hpt_frequency.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/bcma_private.h                 |    3 +
 drivers/bcma/driver_chipcommon_pmu.c        |   86 +++++++++++++++++++++++++++
 drivers/bcma/driver_mips.c                  |   12 ++++
 include/linux/bcma/bcma_driver_chipcommon.h |   35 +++++++++++
 include/linux/bcma/bcma_driver_mips.h       |    1 +
 5 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/drivers/bcma/bcma_private.h b/drivers/bcma/bcma_private.h
index c65a6e2..fbabe19 100644
--- a/drivers/bcma/bcma_private.h
+++ b/drivers/bcma/bcma_private.h
@@ -22,6 +22,9 @@ int bcma_bus_scan(struct bcma_bus *bus);
 /* driver_mips.c */
 extern unsigned int bcma_core_mips_irq(struct bcma_device *dev);
 
+/* driver_chipcommon_pmu.c */
+extern u32 bcma_pmu_get_clockcpu(struct bcma_drv_cc *cc);
+
 /* driver_chipcommon.c */
 extern int bcma_chipco_serial_init(struct bcma_drv_cc *cc,
 				   struct bcma_drv_mips_serial_port *ports);
diff --git a/drivers/bcma/driver_chipcommon_pmu.c b/drivers/bcma/driver_chipcommon_pmu.c
index f44177a..4a700f8 100644
--- a/drivers/bcma/driver_chipcommon_pmu.c
+++ b/drivers/bcma/driver_chipcommon_pmu.c
@@ -11,6 +11,13 @@
 #include "bcma_private.h"
 #include <linux/bcma/bcma.h>
 
+static u32 bcma_chipco_pll_read(struct bcma_drv_cc *cc, u32 offset)
+{
+	bcma_cc_write32(cc, BCMA_CC_PLLCTL_ADDR, offset);
+	bcma_cc_read32(cc, BCMA_CC_PLLCTL_ADDR);
+	return bcma_cc_read32(cc, BCMA_CC_PLLCTL_DATA);
+}
+
 static void bcma_chipco_chipctl_maskset(struct bcma_drv_cc *cc,
 					u32 offset, u32 mask, u32 set)
 {
@@ -132,3 +139,82 @@ void bcma_pmu_init(struct bcma_drv_cc *cc)
 	bcma_pmu_swreg_init(cc);
 	bcma_pmu_workarounds(cc);
 }
+
+static u32 bcma_pmu_alp_clock(struct bcma_drv_cc *cc)
+{
+	struct bcma_bus *bus = cc->core->bus;
+
+	switch (bus->chipinfo.id) {
+	case 0x4716:
+	case 0x4748:
+	case 47162:
+		/* always 20Mhz */
+		return 20000 * 1000;
+	default:
+		pr_warn("No ALP clock specified for %04X device, "
+			"pmu rev. %d, using default %d Hz\n",
+			bus->chipinfo.id, cc->pmu.rev, BCMA_CC_PMU_ALP_CLOCK);
+	}
+	return BCMA_CC_PMU_ALP_CLOCK;
+}
+
+/* Find the output of the "m" pll divider given pll controls that start with
+ * pllreg "pll0" i.e. 12 for main 6 for phy, 0 for misc.
+ */
+static u32 bcma_pmu_clock(struct bcma_drv_cc *cc, u32 pll0, u32 m)
+{
+	u32 tmp, div, ndiv, p1, p2, fc;
+
+	BUG_ON(!m || m > 4);
+
+	BUG_ON((pll0 & 3) || (pll0 > BCMA_CC_PMU4716_MAINPLL_PLL0));
+
+	tmp = bcma_chipco_pll_read(cc, pll0 + BCMA_CC_PPL_P1P2_OFF);
+	p1 = (tmp & BCMA_CC_PPL_P1_MASK) >> BCMA_CC_PPL_P1_SHIFT;
+	p2 = (tmp & BCMA_CC_PPL_P2_MASK) >> BCMA_CC_PPL_P2_SHIFT;
+
+	tmp = bcma_chipco_pll_read(cc, pll0 + BCMA_CC_PPL_M14_OFF);
+	div = (tmp >> ((m - 1) * BCMA_CC_PPL_MDIV_WIDTH)) & BCMA_CC_PPL_MDIV_MASK;
+
+	tmp = bcma_chipco_pll_read(cc, pll0 + BCMA_CC_PPL_NM5_OFF);
+	ndiv = (tmp & BCMA_CC_PPL_NDIV_MASK) >> BCMA_CC_PPL_NDIV_SHIFT;
+
+	/* Do calculation in Mhz */
+	fc = bcma_pmu_alp_clock(cc) / 1000000;
+	fc = (p1 * ndiv * fc) / p2;
+
+	/* Return clock in Hertz */
+	return (fc / div) * 1000000;
+}
+
+/* query bus clock frequency for PMU-enabled chipcommon */
+u32 bcma_pmu_get_clockcontrol(struct bcma_drv_cc *cc)
+{
+	struct bcma_bus *bus = cc->core->bus;
+
+	switch (bus->chipinfo.id) {
+	case 0x4716:
+	case 0x4748:
+	case 47162:
+		return bcma_pmu_clock(cc, BCMA_CC_PMU4716_MAINPLL_PLL0,
+				      BCMA_CC_PMU5_MAINPLL_SSB);
+	default:
+		pr_warn("No backplane clock specified for %04X device, "
+			"pmu rev. %d, using default %d Hz\n",
+			bus->chipinfo.id, cc->pmu.rev, BCMA_CC_PMU_HT_CLOCK);
+	}
+	return BCMA_CC_PMU_HT_CLOCK;
+}
+
+/* query cpu clock frequency for PMU-enabled chipcommon */
+u32 bcma_pmu_get_clockcpu(struct bcma_drv_cc *cc)
+{
+	struct bcma_bus *bus = cc->core->bus;
+
+	if ((cc->pmu.rev == 5 || cc->pmu.rev == 6 || cc->pmu.rev == 7) &&
+	    (bus->chipinfo.id != 0x4319))
+		return bcma_pmu_clock(cc, BCMA_CC_PMU4716_MAINPLL_PLL0,
+				      BCMA_CC_PMU5_MAINPLL_CPU);
+
+	return bcma_pmu_get_clockcontrol(cc);
+}
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 40e4a6d..faaa232 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -155,6 +155,18 @@ static void bcma_core_mips_dump_irq(struct bcma_bus *bus)
 	}
 }
 
+u32 bcma_cpu_clock(struct bcma_drv_mips *mcore)
+{
+	struct bcma_bus *bus = mcore->core->bus;
+
+	if (bus->drv_cc.capabilities & BCMA_CC_CAP_PMU)
+		return bcma_pmu_get_clockcpu(&bus->drv_cc);
+
+	pr_err("No PMU available, need this to get the cpu clock\n");
+	return 0;
+}
+EXPORT_SYMBOL(bcma_cpu_clock);
+
 static void bcma_core_mips_serial_init(struct bcma_drv_mips *mcore)
 {
 	struct bcma_bus *bus = mcore->core->bus;
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index 083c3b6..77dc08c 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -245,6 +245,41 @@
 #define BCMA_CC_PLLCTL_ADDR		0x0660
 #define BCMA_CC_PLLCTL_DATA		0x0664
 
+/* Divider allocation in 4716/47162/5356 */
+#define BCMA_CC_PMU5_MAINPLL_CPU	1
+#define BCMA_CC_PMU5_MAINPLL_MEM	2
+#define BCMA_CC_PMU5_MAINPLL_SSB	3
+
+/* PLL usage in 4716/47162 */
+#define BCMA_CC_PMU4716_MAINPLL_PLL0	12
+
+/* ALP clock on pre-PMU chips */
+#define BCMA_CC_PMU_ALP_CLOCK		20000000
+/* HT clock for systems with PMU-enabled chipcommon */
+#define BCMA_CC_PMU_HT_CLOCK		80000000
+
+/* PMU rev 5 (& 6) */
+#define	BCMA_CC_PPL_P1P2_OFF		0
+#define	BCMA_CC_PPL_P1_MASK		0x0f000000
+#define	BCMA_CC_PPL_P1_SHIFT		24
+#define	BCMA_CC_PPL_P2_MASK		0x00f00000
+#define	BCMA_CC_PPL_P2_SHIFT		20
+#define	BCMA_CC_PPL_M14_OFF		1
+#define	BCMA_CC_PPL_MDIV_MASK		0x000000ff
+#define	BCMA_CC_PPL_MDIV_WIDTH		8
+#define	BCMA_CC_PPL_NM5_OFF		2
+#define	BCMA_CC_PPL_NDIV_MASK		0xfff00000
+#define	BCMA_CC_PPL_NDIV_SHIFT		20
+#define	BCMA_CC_PPL_FMAB_OFF		3
+#define	BCMA_CC_PPL_MRAT_MASK		0xf0000000
+#define	BCMA_CC_PPL_MRAT_SHIFT		28
+#define	BCMA_CC_PPL_ABRAT_MASK		0x08000000
+#define	BCMA_CC_PPL_ABRAT_SHIFT		27
+#define	BCMA_CC_PPL_FDIV_MASK		0x07ffffff
+#define	BCMA_CC_PPL_PLLCTL_OFF		4
+#define	BCMA_CC_PPL_PCHI_OFF		5
+#define	BCMA_CC_PPL_PCHI_MASK		0x0000003f
+
 /* Data for the PMU, if available.
  * Check availability with ((struct bcma_chipcommon)->capabilities & BCMA_CC_CAP_PMU)
  */
diff --git a/include/linux/bcma/bcma_driver_mips.h b/include/linux/bcma/bcma_driver_mips.h
index 6584e7d..8346fde 100644
--- a/include/linux/bcma/bcma_driver_mips.h
+++ b/include/linux/bcma/bcma_driver_mips.h
@@ -47,5 +47,6 @@ struct bcma_drv_mips {
 };
 
 extern void bcma_core_mips_init(struct bcma_drv_mips *mcore);
+extern u32 bcma_cpu_clock(struct bcma_drv_mips *mcore);
 
 #endif /* LINUX_BCMA_DRIVER_MIPS_H_ */
-- 
1.7.4.1
