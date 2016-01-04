Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:24:48 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57786 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009727AbcADTYQKno27 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:16 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 406F1280520;
        Mon,  4 Jan 2016 20:23:45 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:45 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/8] MIPS: ralink: MT7688 pinmux fixes
Date:   Mon,  4 Jan 2016 20:23:56 +0100
Message-Id: <1451935441-40803-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
References: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50869
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

A few fixes to the pinmux data, 2 new muxes and a minor whitespace
cleanup.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |   80 ++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index dfb04fc..733768e 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -107,31 +107,31 @@ static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
 };
 
 static struct rt2880_pmx_func pwm1_grp_mt7628[] = {
-	FUNC("sdcx", 3, 19, 1),
+	FUNC("sdxc d6", 3, 19, 1),
 	FUNC("utif", 2, 19, 1),
 	FUNC("gpio", 1, 19, 1),
-	FUNC("pwm", 0, 19, 1),
+	FUNC("pwm1", 0, 19, 1),
 };
 
 static struct rt2880_pmx_func pwm0_grp_mt7628[] = {
-	FUNC("sdcx", 3, 18, 1),
+	FUNC("sdxc d7", 3, 18, 1),
 	FUNC("utif", 2, 18, 1),
 	FUNC("gpio", 1, 18, 1),
-	FUNC("pwm", 0, 18, 1),
+	FUNC("pwm0", 0, 18, 1),
 };
 
 static struct rt2880_pmx_func uart2_grp_mt7628[] = {
-	FUNC("sdcx", 3, 20, 2),
+	FUNC("sdxc d5 d4", 3, 20, 2),
 	FUNC("pwm", 2, 20, 2),
 	FUNC("gpio", 1, 20, 2),
-	FUNC("uart", 0, 20, 2),
+	FUNC("uart2", 0, 20, 2),
 };
 
 static struct rt2880_pmx_func uart1_grp_mt7628[] = {
-	FUNC("sdcx", 3, 45, 2),
+	FUNC("sw_r", 3, 45, 2),
 	FUNC("pwm", 2, 45, 2),
 	FUNC("gpio", 1, 45, 2),
-	FUNC("uart", 0, 45, 2),
+	FUNC("uart1", 0, 45, 2),
 };
 
 static struct rt2880_pmx_func i2c_grp_mt7628[] = {
@@ -143,21 +143,21 @@ static struct rt2880_pmx_func i2c_grp_mt7628[] = {
 
 static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 36, 1) };
 static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 37, 1) };
-static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 15, 38) };
+static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
 static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
 
 static struct rt2880_pmx_func sd_mode_grp_mt7628[] = {
 	FUNC("jtag", 3, 22, 8),
 	FUNC("utif", 2, 22, 8),
 	FUNC("gpio", 1, 22, 8),
-	FUNC("sdcx", 0, 22, 8),
+	FUNC("sdxc", 0, 22, 8),
 };
 
 static struct rt2880_pmx_func uart0_grp_mt7628[] = {
 	FUNC("-", 3, 12, 2),
 	FUNC("-", 2, 12, 2),
 	FUNC("gpio", 1, 12, 2),
-	FUNC("uart", 0, 12, 2),
+	FUNC("uart0", 0, 12, 2),
 };
 
 static struct rt2880_pmx_func i2s_grp_mt7628[] = {
@@ -171,7 +171,7 @@ static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
 	FUNC("-", 3, 6, 1),
 	FUNC("refclk", 2, 6, 1),
 	FUNC("gpio", 1, 6, 1),
-	FUNC("spi", 0, 6, 1),
+	FUNC("spi cs1", 0, 6, 1),
 };
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
@@ -188,28 +188,44 @@ static struct rt2880_pmx_func gpio_grp_mt7628[] = {
 	FUNC("gpio", 0, 11, 1),
 };
 
-#define MT7628_GPIO_MODE_MASK	0x3
-
-#define MT7628_GPIO_MODE_PWM1	30
-#define MT7628_GPIO_MODE_PWM0	28
-#define MT7628_GPIO_MODE_UART2	26
-#define MT7628_GPIO_MODE_UART1	24
-#define MT7628_GPIO_MODE_I2C	20
-#define MT7628_GPIO_MODE_REFCLK	18
-#define MT7628_GPIO_MODE_PERST	16
-#define MT7628_GPIO_MODE_WDT	14
-#define MT7628_GPIO_MODE_SPI	12
-#define MT7628_GPIO_MODE_SDMODE	10
-#define MT7628_GPIO_MODE_UART0	8
-#define MT7628_GPIO_MODE_I2S	6
-#define MT7628_GPIO_MODE_CS1	4
-#define MT7628_GPIO_MODE_SPIS	2
-#define MT7628_GPIO_MODE_GPIO	0
+static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
+	FUNC("rsvd", 3, 35, 1),
+	FUNC("rsvd", 2, 35, 1),
+	FUNC("gpio", 1, 35, 1),
+	FUNC("wled_kn", 0, 35, 1),
+};
+
+static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
+	FUNC("rsvd", 3, 35, 1),
+	FUNC("rsvd", 2, 35, 1),
+	FUNC("gpio", 1, 35, 1),
+	FUNC("wled_an", 0, 35, 1),
+};
+
+#define MT7628_GPIO_MODE_MASK		0x3
+
+#define MT7628_GPIO_MODE_WLED_KN	48
+#define MT7628_GPIO_MODE_WLED_AN	32
+#define MT7628_GPIO_MODE_PWM1		30
+#define MT7628_GPIO_MODE_PWM0		28
+#define MT7628_GPIO_MODE_UART2		26
+#define MT7628_GPIO_MODE_UART1		24
+#define MT7628_GPIO_MODE_I2C		20
+#define MT7628_GPIO_MODE_REFCLK		18
+#define MT7628_GPIO_MODE_PERST		16
+#define MT7628_GPIO_MODE_WDT		14
+#define MT7628_GPIO_MODE_SPI		12
+#define MT7628_GPIO_MODE_SDMODE		10
+#define MT7628_GPIO_MODE_UART0		8
+#define MT7628_GPIO_MODE_I2S		6
+#define MT7628_GPIO_MODE_CS1		4
+#define MT7628_GPIO_MODE_SPIS		2
+#define MT7628_GPIO_MODE_GPIO		0
 
 static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM1),
-	GRP_G("pmw1", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pmw0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM0),
 	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_UART2),
@@ -233,6 +249,10 @@ static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 				1, MT7628_GPIO_MODE_SPIS),
 	GRP_G("gpio", gpio_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_GPIO),
+	GRP_G("wled_an", wled_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_WLED_AN),
+	GRP_G("wled_kn", wled_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_WLED_KN),
 	{ 0 }
 };
 
-- 
1.7.10.4
