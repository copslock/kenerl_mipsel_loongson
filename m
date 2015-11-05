Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 14:35:59 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34906 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009483AbbKENf526Lz- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Nov 2015 14:35:57 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0FCFA2803EE;
        Thu,  5 Nov 2015 14:34:07 +0100 (CET)
Received: from localhost.localdomain (p548C9511.dip0.t-ipconnect.de [84.140.149.17])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu,  5 Nov 2015 14:34:07 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 4/4] arch: mips: lantiq: disable xbar fpi burst mode
Date:   Thu,  5 Nov 2015 03:56:23 +0100
Message-Id: <1446692183-43330-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49850
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V2:
* fix some whitespace/indentation breakage.

 arch/mips/lantiq/xway/sysctrl.c |   41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 2b15491..5c66d7b 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -78,7 +78,15 @@
 #define pmu_w32(x, y)	ltq_w32((x), pmu_membase + (y))
 #define pmu_r32(x)	ltq_r32(pmu_membase + (x))
 
+#define XBAR_ALWAYS_LAST	0x430
+#define XBAR_FPI_BURST_EN	BIT(1)
+#define XBAR_AHB_BURST_EN	BIT(2)
+
+#define xbar_w32(x, y)	ltq_w32((x), ltq_xbar_membase + (y))
+#define xbar_r32(x)	ltq_r32(ltq_xbar_membase + (x))
+
 static void __iomem *pmu_membase;
+static void __iomem *ltq_xbar_membase;
 void __iomem *ltq_cgu_membase;
 void __iomem *ltq_ebu_membase;
 
@@ -179,6 +187,16 @@ static void pci_ext_disable(struct clk *clk)
 	ltq_cgu_w32((1 << 31) | (1 << 30), pcicr);
 }
 
+static void xbar_fpi_burst_disable(void)
+{
+	u32 reg;
+
+	/* bit 1 as 1 --burst; bit 1 as 0 -- single */
+	reg = xbar_r32(XBAR_ALWAYS_LAST);
+	reg &= ~XBAR_FPI_BURST_EN;
+	xbar_w32(reg, XBAR_ALWAYS_LAST);
+}
+
 /* enable a clockout source */
 static int clkout_enable(struct clk *clk)
 {
@@ -328,6 +346,26 @@ void __init ltq_soc_init(void)
 	if (!pmu_membase || !ltq_cgu_membase || !ltq_ebu_membase)
 		panic("Failed to remap core resources");
 
+	if (of_machine_is_compatible("lantiq,vr9")) {
+		struct resource res_xbar;
+		struct device_node *np_xbar =
+				of_find_compatible_node(NULL, NULL,
+							"lantiq,xbar-xway");
+
+		if (!np_xbar)
+			panic("Failed to load xbar nodes from devicetree");
+		if (of_address_to_resource(np_pmu, 0, &res_xbar))
+			panic("Failed to get xbar resources");
+		if (request_mem_region(res_xbar.start, resource_size(&res_xbar),
+			res_xbar.name) < 0)
+			panic("Failed to get xbar resources");
+
+		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
+						   resource_size(&res_xbar));
+		if (!ltq_xbar_membase)
+			panic("Failed to remap xbar resources");
+	}
+
 	/* make sure to unprotect the memory region where flash is located */
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
 
@@ -385,4 +423,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
 	}
+
+	if (of_machine_is_compatible("lantiq,vr9"))
+		xbar_fpi_burst_disable();
 }
-- 
1.7.10.4
