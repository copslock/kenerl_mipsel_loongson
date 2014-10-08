Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:08:22 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53906
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010964AbaJIPIEad057 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:04 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 01/10] MIPS: ralink: add verbose pmu info
Date:   Thu,  9 Oct 2014 01:52:56 +0200
Message-Id: <1412812385-64820-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Print the PMU and LDO settings on boot.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index a3ad56c..5846817 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -20,6 +20,22 @@
 
 #include "common.h"
 
+/* analog */
+#define PMU0_CFG		0x88
+#define PMU_SW_SET		BIT(28)
+#define A_DCDC_EN		BIT(24)
+#define A_SSC_PERI		BIT(19)
+#define A_SSC_GEN		BIT(18)
+#define A_SSC_M			0x3
+#define A_SSC_S			16
+#define A_DLY_M			0x7
+#define A_DLY_S			8
+#define A_VTUNE_M		0xff
+
+/* digital */
+#define PMU1_CFG		0x8C
+#define DIG_SW_SEL		BIT(25)
+
 /* does the board have sdram or ddram */
 static int dram_type;
 
@@ -339,6 +355,8 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	u32 n1;
 	u32 rev;
 	u32 cfg0;
+	u32 pmu0;
+	u32 pmu1;
 
 	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
@@ -386,4 +404,12 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		BUG();
 	}
 	soc_info->mem_base = MT7620_DRAM_BASE;
+
+	pmu0 = __raw_readl(sysc + PMU0_CFG);
+	pmu1 = __raw_readl(sysc + PMU1_CFG);
+
+	pr_info("Analog PMU set to %s control\n",
+		(pmu0 & PMU_SW_SET) ? ("sw") : ("hw"));
+	pr_info("Digital PMU set to %s control\n",
+		(pmu1 & DIG_SW_SEL) ? ("sw") : ("hw"));
 }
-- 
1.7.10.4
