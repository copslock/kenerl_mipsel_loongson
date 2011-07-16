Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2011 18:59:49 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:50909 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491202Ab1GPQ4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jul 2011 18:56:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B61DA8C73;
        Sat, 16 Jul 2011 18:56:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c0wfq2vtZJdr; Sat, 16 Jul 2011 18:56:17 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-051.ewe-ip-backbone.de [91.97.255.51])
        by hauke-m.de (Postfix) with ESMTPSA id 5D0418C62;
        Sat, 16 Jul 2011 18:56:06 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 07/11] bcma: get CPU clock
Date:   Sat, 16 Jul 2011 18:55:38 +0200
Message-Id: <1310835342-18877-8-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11710

Add method to return the clock of the CPU. This is needed by the arch
code to calculate the mips_hpt_frequency.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/bcma_private.h                 |    3 +
 drivers/bcma/driver_chipcommon_pmu.c        |  107 +++++++++++++++++++++++++++
 drivers/bcma/driver_mips.c                  |   12 +++
 include/linux/bcma/bcma_driver_chipcommon.h |   39 ++++++++++
 include/linux/bcma/bcma_driver_mips.h       |    2 +
 5 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/drivers/bcma/bcma_private.h b/drivers/bcma/bcma_private.h
index b9b4587..8b6f046 100644
--- a/drivers/bcma/bcma_private.h
+++ b/drivers/bcma/bcma_private.h
@@ -26,6 +26,9 @@ int __init bcma_bus_scan_early(struct bcma_bus *bus,
 			       struct bcma_device *core);
 void bcma_init_bus(struct bcma_bus *bus);
 
+/* driver_chipcommon_pmu.c */
+extern u32 bcma_pmu_get_clockcpu(struct bcma_drv_cc *cc);
+
 /* driver_chipcommon.c */
 #ifdef CONFIG_BCMA_DRIVER_MIPS
 void bcma_chipco_serial_init(struct bcma_drv_cc *cc);
diff --git a/drivers/bcma/driver_chipcommon_pmu.c b/drivers/bcma/driver_chipcommon_pmu.c
index 532757c..250e0c2 100644
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
@@ -158,3 +165,103 @@ u32 bcma_pmu_alp_clock(struct bcma_drv_cc *cc)
 	}
 	return BCMA_CC_PMU_ALP_CLOCK;
 }
+
+/* Find the output of the "m" pll divider given pll controls that start with
+ * pllreg "pll0" i.e. 12 for main 6 for phy, 0 for misc.
+ */
+static u32 bcma_pmu_clock(struct bcma_drv_cc *cc, u32 pll0, u32 m)
+{
+	u32 tmp, div, ndiv, p1, p2, fc;
+	struct bcma_bus *bus = cc->core->bus;
+
+	BUG_ON((pll0 & 3) || (pll0 > BCMA_CC_PMU4716_MAINPLL_PLL0));
+
+	BUG_ON(!m || m > 4);
+
+	if (bus->chipinfo.id == 0x5357 || bus->chipinfo.id == 0x4749) {
+		/* Detect failure in clock setting */
+		tmp = bcma_cc_read32(cc, BCMA_CC_CHIPSTAT);
+		if (tmp & 0x40000)
+			return 133 * 1000000;
+	}
+
+	tmp = bcma_chipco_pll_read(cc, pll0 + BCMA_CC_PPL_P1P2_OFF);
+	p1 = (tmp & BCMA_CC_PPL_P1_MASK) >> BCMA_CC_PPL_P1_SHIFT;
+	p2 = (tmp & BCMA_CC_PPL_P2_MASK) >> BCMA_CC_PPL_P2_SHIFT;
+
+	tmp = bcma_chipco_pll_read(cc, pll0 + BCMA_CC_PPL_M14_OFF);
+	div = (tmp >> ((m - 1) * BCMA_CC_PPL_MDIV_WIDTH)) &
+		BCMA_CC_PPL_MDIV_MASK;
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
+	case 0x5356:
+		return bcma_pmu_clock(cc, BCMA_CC_PMU5356_MAINPLL_PLL0,
+				      BCMA_CC_PMU5_MAINPLL_SSB);
+	case 0x5357:
+	case 0x4749:
+		return bcma_pmu_clock(cc, BCMA_CC_PMU5357_MAINPLL_PLL0,
+				      BCMA_CC_PMU5_MAINPLL_SSB);
+	case 0x5300:
+		return bcma_pmu_clock(cc, BCMA_CC_PMU4706_MAINPLL_PLL0,
+				      BCMA_CC_PMU5_MAINPLL_SSB);
+	case 53572:
+		return 75000000;
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
+	if (bus->chipinfo.id == 53572)
+		return 300000000;
+
+	if (cc->pmu.rev >= 5) {
+		u32 pll;
+		switch (bus->chipinfo.id) {
+		case 0x5356:
+			pll = BCMA_CC_PMU5356_MAINPLL_PLL0;
+			break;
+		case 0x5357:
+		case 0x4749:
+			pll = BCMA_CC_PMU5357_MAINPLL_PLL0;
+			break;
+		default:
+			pll = BCMA_CC_PMU4716_MAINPLL_PLL0;
+			break;
+		}
+
+		/* TODO: if (bus->chipinfo.id == 0x5300)
+		  return si_4706_pmu_clock(sih, osh, cc, PMU4706_MAINPLL_PLL0, PMU5_MAINPLL_CPU); */
+		return bcma_pmu_clock(cc, pll, BCMA_CC_PMU5_MAINPLL_CPU);
+	}
+
+	return bcma_pmu_get_clockcontrol(cc);
+}
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index b17233c..c3e9dff 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -166,6 +166,18 @@ static void bcma_core_mips_dump_irq(struct bcma_bus *bus)
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
 static void bcma_core_mips_flash_detect(struct bcma_drv_mips *mcore)
 {
 	struct bcma_bus *bus = mcore->core->bus;
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index ad7b0bc..099c478 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -247,8 +247,47 @@
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
+/* PLL usage in 5356/5357 */
+#define BCMA_CC_PMU5356_MAINPLL_PLL0	0
+#define BCMA_CC_PMU5357_MAINPLL_PLL0	0
+
+/* 4706 PMU */
+#define BCMA_CC_PMU4706_MAINPLL_PLL0	0
+
 /* ALP clock on pre-PMU chips */
 #define BCMA_CC_PMU_ALP_CLOCK		20000000
+/* HT clock for systems with PMU-enabled chipcommon */
+#define BCMA_CC_PMU_HT_CLOCK		80000000
+
+/* PMU rev 5 (& 6) */
+#define BCMA_CC_PPL_P1P2_OFF		0
+#define BCMA_CC_PPL_P1_MASK		0x0f000000
+#define BCMA_CC_PPL_P1_SHIFT		24
+#define BCMA_CC_PPL_P2_MASK		0x00f00000
+#define BCMA_CC_PPL_P2_SHIFT		20
+#define BCMA_CC_PPL_M14_OFF		1
+#define BCMA_CC_PPL_MDIV_MASK		0x000000ff
+#define BCMA_CC_PPL_MDIV_WIDTH		8
+#define BCMA_CC_PPL_NM5_OFF		2
+#define BCMA_CC_PPL_NDIV_MASK		0xfff00000
+#define BCMA_CC_PPL_NDIV_SHIFT		20
+#define BCMA_CC_PPL_FMAB_OFF		3
+#define BCMA_CC_PPL_MRAT_MASK		0xf0000000
+#define BCMA_CC_PPL_MRAT_SHIFT		28
+#define BCMA_CC_PPL_ABRAT_MASK		0x08000000
+#define BCMA_CC_PPL_ABRAT_SHIFT		27
+#define BCMA_CC_PPL_FDIV_MASK		0x07ffffff
+#define BCMA_CC_PPL_PLLCTL_OFF		4
+#define BCMA_CC_PPL_PCHI_OFF		5
+#define BCMA_CC_PPL_PCHI_MASK		0x0000003f
 
 /* Data for the PMU, if available.
  * Check availability with ((struct bcma_chipcommon)->capabilities & BCMA_CC_CAP_PMU)
diff --git a/include/linux/bcma/bcma_driver_mips.h b/include/linux/bcma/bcma_driver_mips.h
index 82b3bfd..c004364 100644
--- a/include/linux/bcma/bcma_driver_mips.h
+++ b/include/linux/bcma/bcma_driver_mips.h
@@ -44,6 +44,8 @@ extern void bcma_core_mips_init(struct bcma_drv_mips *mcore);
 static inline void bcma_core_mips_init(struct bcma_drv_mips *mcore) { }
 #endif
 
+extern u32 bcma_cpu_clock(struct bcma_drv_mips *mcore);
+
 extern unsigned int bcma_core_mips_irq(struct bcma_device *dev);
 
 #endif /* LINUX_BCMA_DRIVER_MIPS_H_ */
-- 
1.7.4.1
