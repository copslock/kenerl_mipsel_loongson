Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:54:58 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41067 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835156Ab3DPIxZtX9kL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:53:25 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 6/7] MIPS: ralink: add memory definition for MT7620
Date:   Tue, 16 Apr 2013 10:49:15 +0200
Message-Id: <1366102156-21281-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
References: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36227
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

Populate struct soc_info with the data that describes our RAM window.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |    8 ++++++++
 arch/mips/ralink/mt7620.c                  |   20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index b272649..9809972 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -50,6 +50,14 @@
 #define SYSCFG0_DRAM_TYPE_DDR1		1
 #define SYSCFG0_DRAM_TYPE_DDR2		2
 
+#define MT7620_DRAM_BASE		0x0
+#define MT7620_SDRAM_SIZE_MIN		2
+#define MT7620_SDRAM_SIZE_MAX		64
+#define MT7620_DDR1_SIZE_MIN		32
+#define MT7620_DDR1_SIZE_MAX		128
+#define MT7620_DDR2_SIZE_MIN		32
+#define MT7620_DDR2_SIZE_MAX		256
+
 #define MT7620_GPIO_MODE_I2C		BIT(0)
 #define MT7620_GPIO_MODE_UART0_SHIFT	2
 #define MT7620_GPIO_MODE_UART0_MASK	0x7
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index eb00ab8..98ddb93 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -211,4 +211,24 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 	cfg0 = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG0);
 	dram_type = (cfg0 >> SYSCFG0_DRAM_TYPE_SHIFT) & SYSCFG0_DRAM_TYPE_MASK;
+
+	switch (dram_type) {
+	case SYSCFG0_DRAM_TYPE_SDRAM:
+		soc_info->mem_size_min = MT7620_SDRAM_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_SDRAM_SIZE_MAX;
+		break;
+
+	case SYSCFG0_DRAM_TYPE_DDR1:
+		soc_info->mem_size_min = MT7620_DDR1_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_DDR1_SIZE_MAX;
+		break;
+
+	case SYSCFG0_DRAM_TYPE_DDR2:
+		soc_info->mem_size_min = MT7620_DDR2_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_DDR2_SIZE_MAX;
+		break;
+	default:
+		BUG();
+	}
+	soc_info->mem_base = MT7620_DRAM_BASE;
 }
-- 
1.7.10.4
