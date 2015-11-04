Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:50:57 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37380 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011149AbbKDKu1VnWsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:27 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 890AB280351;
        Wed,  4 Nov 2015 11:48:36 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:36 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/9] arch: mips: ralink: fix usb issue during frequency scaling
Date:   Wed,  4 Nov 2015 11:50:08 +0100
Message-Id: <1446634214-11564-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49829
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

If the USB HCD is running and the cpu is scaled too low, then the USB
stops working. Increase the idle speed of the core to fix this if the
kernel is built with USB support.

The "magic" values are taken from the Ralink SDK Kernel.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index f3a4a08..55ddf09 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -37,6 +37,12 @@
 #define PMU1_CFG		0x8C
 #define DIG_SW_SEL		BIT(25)
 
+/* clock scaling */
+#define CLKCFG_FDIV_MASK	0x1f00
+#define CLKCFG_FDIV_USB_VAL	0x0300
+#define CLKCFG_FFRAC_MASK	0x001f
+#define CLKCFG_FFRAC_USB_VAL	0x0003
+
 /* EFUSE bits */
 #define EFUSE_MT7688		0x100000
 
@@ -432,6 +438,20 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
+
+	if (IS_ENABLED(CONFIG_USB) && is_mt76x8()) {
+		/*
+		 * When the CPU goes into sleep mode, the BUS clock will be
+		 * too low for USB to function properly. Adjust the busses
+		 * fractional divider to fix this
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
