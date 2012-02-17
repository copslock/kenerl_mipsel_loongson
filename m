Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:40:41 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36979 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903723Ab2BQKeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:34:07 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/3] MIPS: lantiq: add vr9 support
Date:   Fri, 17 Feb 2012 11:33:51 +0100
Message-Id: <1329474832-21095-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474832-21095-1-git-send-email-blogic@openwrt.org>
References: <1329474832-21095-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

VR9 is a VDSL SoC made by Lantiq. It is very similar to the AR9.
This patch adds the clkdev init code and SoC detection for the VR9.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    1 +
 arch/mips/lantiq/xway/prom.c                       |    5 +++++
 arch/mips/lantiq/xway/sysctrl.c                    |   10 ++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 6dfb65e..8e0fa6c 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -21,6 +21,7 @@
 #define SOC_ID_ARX188		0x16C
 #define SOC_ID_ARX168		0x16D
 #define SOC_ID_ARX182		0x16F
+#define SOC_ID_VRX288           0x1C0
 
 /* SoC Types */
 #define SOC_TYPE_DANUBE		0x01
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
index 0929acb..53b627c 100644
--- a/arch/mips/lantiq/xway/prom.c
+++ b/arch/mips/lantiq/xway/prom.c
@@ -60,6 +60,11 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 #endif
 		break;
 
+	case SOC_ID_VRX288:
+		i->name = SOC_VR9;
+		i->type = SOC_TYPE_VR9;
+		break;
+
 	default:
 		unreachable();
 		break;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 879c89a..18bff5a 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -152,6 +152,16 @@ void __init ltq_soc_init(void)
 		clkdev_add_static("io", CLOCK_133M);
 		clkdev_add_cgu("ephycgu", CGU_EPHY),
 		clkdev_add_pmu("fpi", "ephy", 0, PMU_EPHY);
+	} else if (ltq_is_vr9()) {
+		clkdev_add_static("cpu", ltq_vr9_cpu_hz());
+		clkdev_add_static("fpi", ltq_vr9_fpi_hz());
+		clkdev_add_static("io", ltq_vr9_io_region_clock());
+		clkdev_add_pmu("pcie-phy", NULL, 1, PMU1_PCIE_PHY);
+		clkdev_add_pmu("pcie-bus", NULL, 0, PMU_PCIE_CLK);
+		clkdev_add_pmu("pcie-msi", NULL, 1, PMU1_PCIE_MSI);
+		clkdev_add_pmu("pcie-pdi", NULL, 1, PMU1_PCIE_PDI);
+		clkdev_add_pmu("pcie-ctl", NULL, 1, PMU1_PCIE_CTL);
+		clkdev_add_pmu("ahb", NULL, 0, PMU_AHBM | PMU_AHBS);
 	} else {
 		clkdev_add_static("cpu", ltq_danube_cpu_hz());
 		clkdev_add_static("fpi", ltq_danube_fpi_hz());
-- 
1.7.7.1
