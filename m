Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 16:53:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62089 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993907AbdIAOxQYI1aD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 16:53:16 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DB8997FBBFA00;
        Fri,  1 Sep 2017 15:53:05 +0100 (IST)
Received: from LDT-H-Hunt.le.imgtec.org (192.168.154.107) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 1 Sep 2017 15:53:08 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <harvey.hunt@imgtec.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <ralf@linux-mips.org>, <john@phrozen.org>
CC:     <matt.redfearn@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: mt7620: Rename uartlite to serial
Date:   Fri, 1 Sep 2017 15:53:04 +0100
Message-ID: <1504277584-37794-1-git-send-email-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Previously, mt7620.c defined the clocks for uarts with the names
uartlite, uart1 and uart2. Rename them to serial{0,1,2} and update
the devicetree node names.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/boot/dts/ralink/mt7620a.dtsi |  2 +-
 arch/mips/boot/dts/ralink/mt7628a.dtsi |  6 +++---
 arch/mips/ralink/mt7620.c              | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
index 793c0c7..58bd002 100644
--- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
@@ -45,7 +45,7 @@
 			reg = <0x300 0x100>;
 		};
 
-		uartlite@c00 {
+		serial0@c00 {
 			compatible = "ralink,mt7620a-uart", "ralink,rt2880-uart", "ns16550a";
 			reg = <0xc00 0x100>;
 
diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
index 9ff7e8f..fe3fe9a 100644
--- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
@@ -62,7 +62,7 @@
 			reg = <0x300 0x100>;
 		};
 
-		uart0: uartlite@c00 {
+		uart0: serial0@c00 {
 			compatible = "ns16550a";
 			reg = <0xc00 0x100>;
 
@@ -75,7 +75,7 @@
 			reg-shift = <2>;
 		};
 
-		uart1: uart1@d00 {
+		uart1: serial1@d00 {
 			compatible = "ns16550a";
 			reg = <0xd00 0x100>;
 
@@ -88,7 +88,7 @@
 			reg-shift = <2>;
 		};
 
-		uart2: uart2@e00 {
+		uart2: serial2@e00 {
 			compatible = "ns16550a";
 			reg = <0xe00 0x100>;
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 9be8b08..f623ceb 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -54,7 +54,7 @@ static int dram_type;
 
 static struct rt2880_pmx_func i2c_grp[] =  { FUNC("i2c", 0, 1, 2) };
 static struct rt2880_pmx_func spi_grp[] = { FUNC("spi", 0, 3, 4) };
-static struct rt2880_pmx_func uartlite_grp[] = { FUNC("uartlite", 0, 15, 2) };
+static struct rt2880_pmx_func serial_grp[] = { FUNC("serial", 0, 15, 2) };
 static struct rt2880_pmx_func mdio_grp[] = {
 	FUNC("mdio", MT7620_GPIO_MODE_MDIO, 22, 2),
 	FUNC("refclk", MT7620_GPIO_MODE_MDIO_REFCLK, 22, 2),
@@ -92,7 +92,7 @@ static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
 	GRP("uartf", uartf_grp, MT7620_GPIO_MODE_UART0_MASK,
 		MT7620_GPIO_MODE_UART0_SHIFT),
 	GRP("spi", spi_grp, 1, MT7620_GPIO_MODE_SPI),
-	GRP("uartlite", uartlite_grp, 1, MT7620_GPIO_MODE_UART1),
+	GRP("serial", serial_grp, 1, MT7620_GPIO_MODE_UART1),
 	GRP_G("wdt", wdt_grp, MT7620_GPIO_MODE_WDT_MASK,
 		MT7620_GPIO_MODE_WDT_GPIO, MT7620_GPIO_MODE_WDT_SHIFT),
 	GRP_G("mdio", mdio_grp, MT7620_GPIO_MODE_MDIO_MASK,
@@ -530,8 +530,8 @@ void __init ralink_clk_init(void)
 		periph_rate = MHZ(40);
 		pcmi2s_rate = MHZ(480);
 
-		ralink_clk_add("10000d00.uartlite", periph_rate);
-		ralink_clk_add("10000e00.uartlite", periph_rate);
+		ralink_clk_add("10000d00.serial0", periph_rate);
+		ralink_clk_add("10000e00.serial0", periph_rate);
 	} else {
 		cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
 		pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
@@ -566,9 +566,9 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000a00.i2s", pcmi2s_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000c00.uartlite", periph_rate);
-	ralink_clk_add("10000d00.uart1", periph_rate);
-	ralink_clk_add("10000e00.uart2", periph_rate);
+	ralink_clk_add("10000c00.serial0", periph_rate);
+	ralink_clk_add("10000d00.serial1", periph_rate);
+	ralink_clk_add("10000e00.serial2", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
 
 	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
-- 
2.7.4
