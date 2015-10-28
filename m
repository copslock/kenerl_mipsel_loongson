Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:39:39 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37620 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011822AbbJ1Wh5D00CO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:57 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 853BD100031;
        Wed, 28 Oct 2015 23:37:56 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 06/15] MIPS: lantiq: deactivate most of the devices by default
Date:   Wed, 28 Oct 2015 23:37:35 +0100
Message-Id: <1446071865-21936-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

When the SoC starts up most of the devices should be deactivated by the
PMU, they should be activated when they get used by their drivers. Some
devices should not get deactivate at startup like the serial, register
them in a special way.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 46 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 71b6c1e..01a4544 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -285,8 +285,8 @@ static int clkout_enable(struct clk *clk)
 }
 
 /* manage the clock gates via PMU */
-static void clkdev_add_pmu(const char *dev, const char *con,
-					unsigned int module, unsigned int bits)
+static void clkdev_add_pmu(const char *dev, const char *con, bool deactivate,
+			   unsigned int module, unsigned int bits)
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
@@ -297,6 +297,10 @@ static void clkdev_add_pmu(const char *dev, const char *con,
 	clk->disable = pmu_disable;
 	clk->module = module;
 	clk->bits = bits;
+	if (deactivate) {
+		/* Disable it during the initialitin. Module should enable when used */
+		pmu_disable(clk);
+	}
 	clkdev_add(&clk->cl);
 }
 
@@ -415,13 +419,13 @@ void __init ltq_soc_init(void)
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
 
 	/* add our generic xway clocks */
-	clkdev_add_pmu("10000000.fpi", NULL, 0, PMU_FPI);
-	clkdev_add_pmu("1e100400.serial", NULL, 0, PMU_ASC0);
-	clkdev_add_pmu("1e100a00.gptu", NULL, 0, PMU_GPT);
-	clkdev_add_pmu("1e100bb0.stp", NULL, 0, PMU_STP);
-	clkdev_add_pmu("1e104100.dma", NULL, 0, PMU_DMA);
-	clkdev_add_pmu("1e100800.spi", NULL, 0, PMU_SPI);
-	clkdev_add_pmu("1e105300.ebu", NULL, 0, PMU_EBU);
+	clkdev_add_pmu("10000000.fpi", NULL, 0, 0, PMU_FPI);
+	clkdev_add_pmu("1e100400.serial", NULL, 0, 0, PMU_ASC0);
+	clkdev_add_pmu("1e100a00.gptu", NULL, 1, 0, PMU_GPT);
+	clkdev_add_pmu("1e100bb0.stp", NULL, 1, 0, PMU_STP);
+	clkdev_add_pmu("1e104100.dma", NULL, 1, 0, PMU_DMA);
+	clkdev_add_pmu("1e100800.spi", NULL, 1, 0, PMU_SPI);
+	clkdev_add_pmu("1e105300.ebu", NULL, 0, 0, PMU_EBU);
 	clkdev_add_clkout();
 
 	/* add the soc dependent clocks */
@@ -429,11 +433,11 @@ void __init ltq_soc_init(void)
 		ifccr = CGU_IFCCR_VR9;
 		pcicr = CGU_PCICR_VR9;
 	} else {
-		clkdev_add_pmu("1e180000.etop", NULL, 0, PMU_PPE);
+		clkdev_add_pmu("1e180000.etop", NULL, 1, 0, PMU_PPE);
 	}
 
 	if (!of_machine_is_compatible("lantiq,ase")) {
-		clkdev_add_pmu("1e100c00.serial", NULL, 0, PMU_ASC1);
+		clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
 		clkdev_add_pci();
 	}
 
@@ -445,25 +449,25 @@ void __init ltq_soc_init(void)
 			clkdev_add_static(CLOCK_133M, CLOCK_133M,
 						CLOCK_133M, CLOCK_133M);
 		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY),
-		clkdev_add_pmu("1e180000.etop", "ephy", 0, PMU_EPHY);
+		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
 				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
-		clkdev_add_pmu("1d900000.pcie", "phy", 1, PMU1_PCIE_PHY);
-		clkdev_add_pmu("1d900000.pcie", "bus", 0, PMU_PCIE_CLK);
-		clkdev_add_pmu("1d900000.pcie", "msi", 1, PMU1_PCIE_MSI);
-		clkdev_add_pmu("1d900000.pcie", "pdi", 1, PMU1_PCIE_PDI);
-		clkdev_add_pmu("1d900000.pcie", "ctl", 1, PMU1_PCIE_CTL);
-		clkdev_add_pmu("1d900000.pcie", "ahb", 0, PMU_AHBM | PMU_AHBS);
-		clkdev_add_pmu("1e108000.eth", NULL, 0,
+		clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
+		clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
+		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
+		clkdev_add_pmu("1d900000.pcie", "pdi", 1, 1, PMU1_PCIE_PDI);
+		clkdev_add_pmu("1d900000.pcie", "ctl", 1, 1, PMU1_PCIE_CTL);
+		clkdev_add_pmu("1d900000.pcie", "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
+		clkdev_add_pmu("1e108000.eth", NULL, 1, 0,
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
-		clkdev_add_pmu("1f203000.rcu", "gphy", 0, PMU_GPHY);
+		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
-		clkdev_add_pmu("1e180000.etop", "switch", 0, PMU_SWITCH);
+		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-- 
2.6.1
