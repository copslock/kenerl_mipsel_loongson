Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:26:05 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55319 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865313Ab3HHLY7vFVBB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:24:59 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/5] MIPS: ralink: mt7620: fix usb issue during frequency scaling
Date:   Thu,  8 Aug 2013 13:17:51 +0200
Message-Id: <1375960672-32619-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
References: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37466
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

If the USB HCD is running and the cpu is scaled too low, then the USB stops
working. Increase the idle speed of the core to fix this if the kernel is
built with USB support.

The values are taken from the Ralink SDK Kernel.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |    1 +
 arch/mips/ralink/mt7620.c                  |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 9809972..d469c69 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -20,6 +20,7 @@
 #define SYSC_REG_CHIP_REV		0x0c
 #define SYSC_REG_SYSTEM_CONFIG0		0x10
 #define SYSC_REG_SYSTEM_CONFIG1		0x14
+#define SYSC_REG_CPU_SYS_CLKCFG		0x3c
 #define SYSC_REG_CPLL_CONFIG0		0x54
 #define SYSC_REG_CPLL_CONFIG1		0x58
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 7b360a8..23bb691 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -20,6 +20,12 @@
 
 #include "common.h"
 
+/* clock scaling */
+#define CLKCFG_FDIV_MASK	0x1f00
+#define CLKCFG_FDIV_USB_VAL	0x0300
+#define CLKCFG_FFRAC_MASK	0x001f
+#define CLKCFG_FFRAC_USB_VAL	0x0003
+
 /* does the board have sdram or ddram */
 static int dram_type;
 
@@ -170,6 +176,19 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000500.uart", 40000000);
 	ralink_clk_add("10000b00.spi", 40000000);
 	ralink_clk_add("10000c00.uartlite", 40000000);
+
+	if (IS_ENABLED(CONFIG_USB)) {
+		/*
+		 * When the CPU goes into sleep mode, the BUS clock will be too low for
+		 * USB to function properly
+		 */
+		u32 val = rt_sysc_r32(SYSC_REG_CPU_SYS_CLKCFG);
+
+		val &= ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
+		val |= CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
+
+		rt_sysc_w32(val, SYSC_REG_CPU_SYS_CLKCFG);
+	}
 }
 
 void __init ralink_of_remap(void)
-- 
1.7.10.4
