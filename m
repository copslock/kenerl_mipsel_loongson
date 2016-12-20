Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2016 19:13:50 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44289 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993313AbcLTSMiBY8v2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Dec 2016 19:12:38 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 3/7] arch: mips: ralink: add missing pinmux
Date:   Tue, 20 Dec 2016 19:12:42 +0100
Message-Id: <1482257566-61035-4-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1482257566-61035-1-git-send-email-john@phrozen.org>
References: <1482257566-61035-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

The mt7620 has a pin that can be used to generate an external reference
clock. The pinmux setup was missing the definition of said pin. This patch
adds it.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |    7 ++++++-
 arch/mips/ralink/mt7620.c                  |    8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index a73350b..66af4cc 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -115,9 +115,14 @@
 #define MT7620_GPIO_MODE_WDT_MASK	0x3
 #define MT7620_GPIO_MODE_WDT_SHIFT	21
 
+#define MT7620_GPIO_MODE_MDIO		0
+#define MT7620_GPIO_MODE_MDIO_REFCLK	1
+#define MT7620_GPIO_MODE_MDIO_GPIO	2
+#define MT7620_GPIO_MODE_MDIO_MASK	0x3
+#define MT7620_GPIO_MODE_MDIO_SHIFT	7
+
 #define MT7620_GPIO_MODE_I2C		0
 #define MT7620_GPIO_MODE_UART1		5
-#define MT7620_GPIO_MODE_MDIO		8
 #define MT7620_GPIO_MODE_RGMII1		9
 #define MT7620_GPIO_MODE_RGMII2		10
 #define MT7620_GPIO_MODE_SPI		11
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 6f0fdfd..2503878 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -55,7 +55,10 @@
 static struct rt2880_pmx_func i2c_grp[] =  { FUNC("i2c", 0, 1, 2) };
 static struct rt2880_pmx_func spi_grp[] = { FUNC("spi", 0, 3, 4) };
 static struct rt2880_pmx_func uartlite_grp[] = { FUNC("uartlite", 0, 15, 2) };
-static struct rt2880_pmx_func mdio_grp[] = { FUNC("mdio", 0, 22, 2) };
+static struct rt2880_pmx_func mdio_grp[] = {
+	FUNC("mdio", MT7620_GPIO_MODE_MDIO, 22, 2),
+	FUNC("refclk", MT7620_GPIO_MODE_MDIO_REFCLK, 22, 2),
+};
 static struct rt2880_pmx_func rgmii1_grp[] = { FUNC("rgmii1", 0, 24, 12) };
 static struct rt2880_pmx_func refclk_grp[] = { FUNC("spi refclk", 0, 37, 3) };
 static struct rt2880_pmx_func ephy_grp[] = { FUNC("ephy", 0, 40, 5) };
@@ -92,7 +95,8 @@
 	GRP("uartlite", uartlite_grp, 1, MT7620_GPIO_MODE_UART1),
 	GRP_G("wdt", wdt_grp, MT7620_GPIO_MODE_WDT_MASK,
 		MT7620_GPIO_MODE_WDT_GPIO, MT7620_GPIO_MODE_WDT_SHIFT),
-	GRP("mdio", mdio_grp, 1, MT7620_GPIO_MODE_MDIO),
+	GRP_G("mdio", mdio_grp, MT7620_GPIO_MODE_MDIO_MASK,
+		MT7620_GPIO_MODE_MDIO_GPIO, MT7620_GPIO_MODE_MDIO_SHIFT),
 	GRP("rgmii1", rgmii1_grp, 1, MT7620_GPIO_MODE_RGMII1),
 	GRP("spi refclk", refclk_grp, 1, MT7620_GPIO_MODE_SPI_REF_CLK),
 	GRP_G("pcie", pcie_rst_grp, MT7620_GPIO_MODE_PCIE_MASK,
-- 
1.7.10.4
