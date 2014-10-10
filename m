Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 09:50:48 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:46029
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011048AbaJJHtzrTjBU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 09:49:55 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/4] MIPS: ralink: add support for MT7620n
Date:   Fri, 10 Oct 2014 09:49:47 +0200
Message-Id: <1412927388-60721-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
References: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43194
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

This is the small version of MT7620a.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |    7 ++-----
 arch/mips/ralink/mt7620.c                  |   20 +++++++++++++-------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index a05c14c2..863aea5 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -25,11 +25,8 @@
 #define SYSC_REG_CPLL_CONFIG0		0x54
 #define SYSC_REG_CPLL_CONFIG1		0x58
 
-#define MT7620N_CHIP_NAME0		0x33365452
-#define MT7620N_CHIP_NAME1		0x20203235
-
-#define MT7620A_CHIP_NAME0		0x3637544d
-#define MT7620A_CHIP_NAME1		0x20203032
+#define MT7620_CHIP_NAME0		0x3637544d
+#define MT7620_CHIP_NAME1		0x20203032
 
 #define SYSCFG0_XTAL_FREQ_SEL		BIT(6)
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 24fb40a..e4b1f82 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -277,6 +277,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000500.uart", periph_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
+	ralink_clk_add("10180000.wmac", xtal_rate);
 }
 
 void __init ralink_of_remap(void)
@@ -298,22 +299,27 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	u32 cfg0;
 	u32 pmu0;
 	u32 pmu1;
+	u32 bga;
 
 	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
+	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
+	bga = (rev >> CHIP_REV_PKG_SHIFT) & CHIP_REV_PKG_MASK;
 
-	if (n0 == MT7620N_CHIP_NAME0 && n1 == MT7620N_CHIP_NAME1) {
-		name = "MT7620N";
-		soc_info->compatible = "ralink,mt7620n-soc";
-	} else if (n0 == MT7620A_CHIP_NAME0 && n1 == MT7620A_CHIP_NAME1) {
+	if (n0 != MT7620_CHIP_NAME0 || n1 != MT7620_CHIP_NAME1)
+		panic("mt7620: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
+
+	if (bga) {
 		name = "MT7620A";
 		soc_info->compatible = "ralink,mt7620a-soc";
 	} else {
-		panic("mt7620: unknown SoC, n0:%08x n1:%08x", n0, n1);
+		name = "MT7620N";
+		soc_info->compatible = "ralink,mt7620n-soc";
+#ifdef CONFIG_PCI
+		panic("mt7620n is only supported for non pci kernels");
+#endif
 	}
 
-	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
-
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"Ralink %s ver:%u eco:%u",
 		name,
-- 
1.7.10.4
