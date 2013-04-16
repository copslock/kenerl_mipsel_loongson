Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:54:04 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41059 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835155Ab3DPIxYrdn1I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:53:24 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 3/7] MIPS: ralink: add memory definition for RT305x
Date:   Tue, 16 Apr 2013 10:49:12 +0200
Message-Id: <1366102156-21281-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
References: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36224
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

As memory detection fails on RT5350 we read the amount of available memory
from the system controller.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/rt305x.h |    6 ++++
 arch/mips/ralink/rt305x.c                  |   45 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index 80cda8a..069bf37 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -157,4 +157,10 @@ static inline int soc_is_rt5350(void)
 #define RT3352_RSTCTRL_UDEV		BIT(25)
 #define RT3352_SYSCFG1_USB0_HOST_MODE	BIT(10)
 
+#define RT305X_SDRAM_BASE		0x00000000
+#define RT305X_MEM_SIZE_MIN		2
+#define RT305X_MEM_SIZE_MAX		64
+#define RT3352_MEM_SIZE_MIN		2
+#define RT3352_MEM_SIZE_MAX		256
+
 #endif
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index e9dbf8c..9f2c8a4 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -122,6 +122,40 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.wdt_reset = rt305x_wdt_reset,
 };
 
+static unsigned long rt5350_get_mem_size(void)
+{
+	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
+	unsigned long ret;
+	u32 t;
+
+	t = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG);
+	t = (t >> RT5350_SYSCFG0_DRAM_SIZE_SHIFT) &
+		RT5350_SYSCFG0_DRAM_SIZE_MASK;
+
+	switch (t) {
+	case RT5350_SYSCFG0_DRAM_SIZE_2M:
+		ret = 2;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_8M:
+		ret = 8;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_16M:
+		ret = 16;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_32M:
+		ret = 32;
+		break;
+	case RT5350_SYSCFG0_DRAM_SIZE_64M:
+		ret = 64;
+		break;
+	default:
+		panic("rt5350: invalid DRAM size: %u", t);
+		break;
+	}
+
+	return ret;
+}
+
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, sys_rate, wdt_rate, uart_rate;
@@ -252,4 +286,15 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		name,
 		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
 		(id & CHIP_ID_REV_MASK));
+
+	soc_info->mem_base = RT305X_SDRAM_BASE;
+	if (soc_is_rt5350()) {
+		soc_info->mem_size = rt5350_get_mem_size();
+	} else if (soc_is_rt305x() || soc_is_rt3350()) {
+		soc_info->mem_size_min = RT305X_MEM_SIZE_MIN;
+		soc_info->mem_size_max = RT305X_MEM_SIZE_MAX;
+	} else if (soc_is_rt3352()) {
+		soc_info->mem_size_min = RT3352_MEM_SIZE_MIN;
+		soc_info->mem_size_max = RT3352_MEM_SIZE_MAX;
+	}
 }
-- 
1.7.10.4
