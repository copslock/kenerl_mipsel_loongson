Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 16:31:46 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50632 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20027111AbXKKQbg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2007 16:31:36 +0000
Received: from localhost (p5137-ipad310funabasi.chiba.ocn.ne.jp [123.217.207.137])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6E3919DB2; Mon, 12 Nov 2007 01:30:14 +0900 (JST)
Date:	Mon, 12 Nov 2007 01:32:20 +0900 (JST)
Message-Id: <20071112.013220.96686193.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, wim@iguana.be
Subject: [PATCH 2/2] TXx9 watchdog support for rbhma3100,rbhma4200,rbhma4500
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch adds support for txx9wdt driver to rbhma3100, rbhma4200 and
rbhma4500 platform.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is a patch against linux-queue tree in linux-mips.org

 arch/mips/configs/jmr3927_defconfig                |   15 +++++-
 arch/mips/configs/rbhma4200_defconfig              |   15 +++++-
 arch/mips/configs/rbhma4500_defconfig              |   15 +++++-
 arch/mips/jmr3927/rbhma3100/setup.c                |   55 ++++++++++++++++++++
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   55 ++++++++++++++++++++
 arch/mips/tx4938/toshiba_rbtx4938/setup.c          |   25 +++++++++
 include/asm-mips/tx4927/tx4927_pci.h               |    1 +
 7 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index eb96791..4ace378 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -464,7 +464,6 @@ CONFIG_SERIAL_TXX9_STDSERIAL=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
 # CONFIG_R3964 is not set
@@ -482,6 +481,20 @@ CONFIG_DEVPORT=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_TXX9_WDT=y
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
 
 #
 # Multifunction device drivers
diff --git a/arch/mips/configs/rbhma4200_defconfig b/arch/mips/configs/rbhma4200_defconfig
index 9383a59..a67c698 100644
--- a/arch/mips/configs/rbhma4200_defconfig
+++ b/arch/mips/configs/rbhma4200_defconfig
@@ -431,7 +431,6 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
 # CONFIG_R3964 is not set
@@ -449,6 +448,20 @@ CONFIG_DEVPORT=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_TXX9_WDT=m
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
 
 #
 # Multifunction device drivers
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index d1b56cc..ebc8ad4 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -450,7 +450,6 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
 # CONFIG_R3964 is not set
@@ -479,6 +478,20 @@ CONFIG_SPI_AT25=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_TXX9_WDT=m
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
 
 #
 # Multifunction device drivers
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 75cfe65..c886d80 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -35,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
 #endif
@@ -233,6 +234,8 @@ static void __init tx3927_setup(void)
 	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_BEOW;
 	/* Disable PCI snoop */
 	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_PSNP;
+	/* do reset on watchdog */
+	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
 
 #ifdef DO_WRITE_THROUGH
 	/* Enable PCI SNOOP - with write through only */
@@ -383,3 +386,55 @@ static int __init jmr3927_rtc_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 device_initcall(jmr3927_rtc_init);
+
+/* Watchdog support */
+
+static int __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("txx9wdt", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+
+static int __init jmr3927_wdt_init(void)
+{
+	return txx9_wdt_init(TX3927_TMR_REG(2));
+}
+device_initcall(jmr3927_wdt_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)JMR3927_IMCLK;
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index c29a528..e466e5e 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -50,6 +50,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <asm/bootinfo.h>
 #include <asm/io.h>
@@ -803,6 +804,8 @@ void __init plat_mem_setup(void)
 		}
 
 	/* CCFG */
+	/* do reset on watchdog */
+	tx4927_ccfgptr->ccfg |= TX4927_CCFG_WR;
 	/* enable Timeout BusError */
 	if (tx4927_ccfg_toeon)
 		tx4927_ccfgptr->ccfg |= TX4927_CCFG_TOE;
@@ -944,3 +947,55 @@ static int __init rbtx4927_ne_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 device_initcall(rbtx4927_ne_init);
+
+/* Watchdog support */
+
+static int __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("txx9wdt", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+
+static int __init rbtx4927_wdt_init(void)
+{
+	return txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
+}
+device_initcall(rbtx4927_wdt_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)50000000;
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index d13af99..47a9c17 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -724,6 +724,8 @@ void __init tx4938_board_setup(void)
 	/* CCFG */
 	/* clear WatchDogReset,BusErrorOnWrite flag (W1C) */
 	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WDRST | TX4938_CCFG_BEOW;
+	/* do reset on watchdog */
+	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WR;
 	/* clear PCIC1 reset */
 	if (tx4938_ccfgptr->clkctr & TX4938_CLKCTR_PCIC1RST)
 		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
@@ -1121,12 +1123,35 @@ static int __init rbtx4938_spi_init(void)
 }
 arch_initcall(rbtx4938_spi_init);
 
+/* Watchdog support */
+
+static int __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+		.parent	= &tx4938_reg_resource,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("txx9wdt", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+
+static int __init rbtx4938_wdt_init(void)
+{
+	return txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
+}
+device_initcall(rbtx4938_wdt_init);
+
 /* Minimum CLK support */
 
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	if (!strcmp(id, "spi-baseclk"))
 		return (struct clk *)(txx9_gbus_clock / 2 / 4);
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)(txx9_gbus_clock / 2);
 	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL(clk_get);
diff --git a/include/asm-mips/tx4927/tx4927_pci.h b/include/asm-mips/tx4927/tx4927_pci.h
index 3f1e470..0be77df 100644
--- a/include/asm-mips/tx4927/tx4927_pci.h
+++ b/include/asm-mips/tx4927/tx4927_pci.h
@@ -9,6 +9,7 @@
 #define __ASM_TX4927_TX4927_PCI_H
 
 #define TX4927_CCFG_TOE 0x00004000
+#define TX4927_CCFG_WR	0x00008000
 #define TX4927_CCFG_TINTDIS	0x01000000
 
 #define TX4927_PCIMEM      0x08000000
