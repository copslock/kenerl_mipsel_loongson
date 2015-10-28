Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:39:55 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37622 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011826AbbJ1Wh531yFO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:57 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id F166F100029;
        Wed, 28 Oct 2015 23:37:56 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 07/15] MIPS: lantiq: add PMU bits for USB and SDIO devices
Date:   Wed, 28 Oct 2015 23:37:36 +0100
Message-Id: <1446071865-21936-8-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49749
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

This adds the PUM bits for USB and SDIO devices

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 01a4544..6942fef 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -87,11 +87,13 @@ static u32 pmu_clk_cr_b[] = {
 
 /* clock gates that we can en/disable */
 #define PMU_USB0_P	BIT(0)
+#define PMU_ASE_SDIO	BIT(2) /* ASE special */
 #define PMU_PCI		BIT(4)
 #define PMU_DMA		BIT(5)
 #define PMU_USB0	BIT(6)
 #define PMU_ASC0	BIT(7)
 #define PMU_EPHY	BIT(7)	/* ase */
+#define PMU_USIF	BIT(7) /* from vr9 until grx390 */
 #define PMU_SPI		BIT(8)
 #define PMU_DFE		BIT(9)
 #define PMU_EBU		BIT(10)
@@ -100,6 +102,7 @@ static u32 pmu_clk_cr_b[] = {
 #define PMU_AHBS	BIT(13) /* vr9 */
 #define PMU_FPI		BIT(14)
 #define PMU_AHBM	BIT(15)
+#define PMU_SDIO	BIT(16) /* danube, ar9, vr9 */
 #define PMU_ASC1	BIT(17)
 #define PMU_PPE_QSB	BIT(18)
 #define PMU_PPE_SLL01	BIT(19)
@@ -448,28 +451,47 @@ void __init ltq_soc_init(void)
 		else
 			clkdev_add_static(CLOCK_133M, CLOCK_133M,
 						CLOCK_133M, CLOCK_133M);
-		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY),
+		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
+		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
 		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
+		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_ASE_SDIO);
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
 				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
+		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0 | PMU_AHBM);
+		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
+		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1 | PMU_AHBM);
 		clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
 		clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
 		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
 		clkdev_add_pmu("1d900000.pcie", "pdi", 1, 1, PMU1_PCIE_PDI);
 		clkdev_add_pmu("1d900000.pcie", "ctl", 1, 1, PMU1_PCIE_CTL);
 		clkdev_add_pmu("1d900000.pcie", "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
+
+		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1e108000.eth", NULL, 1, 0,
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
 		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
+		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
+		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
+		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
+		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
+		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 	}
 }
-- 
2.6.1
