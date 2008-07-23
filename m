Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:25:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:22250 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577896AbYGWPXh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:37 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5EA64A9F6; Thu, 24 Jul 2008 00:23:30 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 07/10] txx9: Cleanup watchdog
Date:	Thu, 24 Jul 2008 00:25:18 +0900
Message-Id: <1216826721-28259-7-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Unify registration of txx9wdt platform device.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |   12 ++++++++++++
 arch/mips/txx9/generic/setup_tx4927.c |    7 ++++++-
 arch/mips/txx9/generic/setup_tx4938.c |    7 ++++++-
 arch/mips/txx9/jmr3927/setup.c        |   20 +++-----------------
 arch/mips/txx9/rbtx4927/setup.c       |   21 +--------------------
 arch/mips/txx9/rbtx4938/setup.c       |   21 +--------------------
 include/asm-mips/txx9/generic.h       |    1 +
 include/asm-mips/txx9/tx4927.h        |    2 +-
 include/asm-mips/txx9/tx4938.h        |    2 +-
 9 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 82272e8..7b5705d 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
@@ -208,6 +209,17 @@ static void __noreturn txx9_machine_halt(void)
 	}
 }
 
+/* Watchdog support */
+void __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	platform_device_register_simple("txx9wdt", -1, &res, 1);
+}
+
 /* wrappers */
 void __init plat_mem_setup(void)
 {
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 89d6e28..b42c855 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -21,7 +21,7 @@
 #include <asm/txx9/generic.h>
 #include <asm/txx9/tx4927.h>
 
-void __init tx4927_wdr_init(void)
+static void __init tx4927_wdr_init(void)
 {
 	/* clear WatchDogReset (W1C) */
 	tx4927_ccfg_set(TX4927_CCFG_WDRST);
@@ -29,6 +29,11 @@ void __init tx4927_wdr_init(void)
 	tx4927_ccfg_set(TX4927_CCFG_WR);
 }
 
+void __init tx4927_wdt_init(void)
+{
+	txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
+}
+
 static struct resource tx4927_sdram_resource[4];
 
 void __init tx4927_setup(void)
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 317378d..b0a3dc8 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -21,7 +21,7 @@
 #include <asm/txx9/generic.h>
 #include <asm/txx9/tx4938.h>
 
-void __init tx4938_wdr_init(void)
+static void __init tx4938_wdr_init(void)
 {
 	/* clear WatchDogReset (W1C) */
 	tx4938_ccfg_set(TX4938_CCFG_WDRST);
@@ -29,6 +29,11 @@ void __init tx4938_wdr_init(void)
 	tx4938_ccfg_set(TX4938_CCFG_WR);
 }
 
+void __init tx4938_wdt_init(void)
+{
+	txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
+}
+
 static struct resource tx4938_sdram_resource[4];
 static struct resource tx4938_sram_resource;
 
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index fa0503e..ae34e9a 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -308,30 +308,16 @@ static int __init jmr3927_rtc_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 
-/* Watchdog support */
-
-static int __init txx9_wdt_init(unsigned long base)
-{
-	struct resource res = {
-		.start	= base,
-		.end	= base + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("txx9wdt", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-
-static int __init jmr3927_wdt_init(void)
+static void __init tx3927_wdt_init(void)
 {
-	return txx9_wdt_init(TX3927_TMR_REG(2));
+	txx9_wdt_init(TX3927_TMR_REG(2));
 }
 
 static void __init jmr3927_device_init(void)
 {
 	__swizzle_addr_b = jmr3927_swizzle_addr_b;
 	jmr3927_rtc_init();
-	jmr3927_wdt_init();
+	tx3927_wdt_init();
 }
 
 struct txx9_board_vec jmr3927_vec __initdata = {
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 54c33c3..f01af38 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -328,30 +328,11 @@ static int __init rbtx4927_ne_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 
-/* Watchdog support */
-
-static int __init txx9_wdt_init(unsigned long base)
-{
-	struct resource res = {
-		.start	= base,
-		.end	= base + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("txx9wdt", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-
-static int __init rbtx4927_wdt_init(void)
-{
-	return txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
-}
-
 static void __init rbtx4927_device_init(void)
 {
 	toshiba_rbtx4927_rtc_init();
 	rbtx4927_ne_init();
-	rbtx4927_wdt_init();
+	tx4927_wdt_init();
 }
 
 struct txx9_board_vec rbtx4927_vec __initdata = {
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index e1177b3..ff5fda2 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -352,30 +352,11 @@ static void __init rbtx4938_arch_init(void)
 	rbtx4938_spi_init();
 }
 
-/* Watchdog support */
-
-static int __init txx9_wdt_init(unsigned long base)
-{
-	struct resource res = {
-		.start	= base,
-		.end	= base + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("txx9wdt", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-
-static int __init rbtx4938_wdt_init(void)
-{
-	return txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
-}
-
 static void __init rbtx4938_device_init(void)
 {
 	rbtx4938_ethaddr_init();
 	rbtx4938_ne_init();
-	rbtx4938_wdt_init();
+	tx4938_wdt_init();
 }
 
 struct txx9_board_vec rbtx4938_vec __initdata = {
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index cbae37e..2b34d09 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -44,5 +44,6 @@ extern struct txx9_board_vec *txx9_board_vec;
 extern int (*txx9_irq_dispatch)(int pending);
 void prom_init_cmdline(void);
 char *prom_getcmdline(void);
+void txx9_wdt_init(unsigned long base);
 
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index 2c26fd1..3d9fd7d 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -243,7 +243,7 @@ static inline void tx4927_ccfg_change(__u64 change, __u64 new)
 }
 
 unsigned int tx4927_get_mem_size(void);
-void tx4927_wdr_init(void);
+void tx4927_wdt_init(void);
 void tx4927_setup(void);
 void tx4927_time_init(unsigned int tmrnr);
 void tx4927_setup_serial(void);
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 4fff1c9..d5d7cef 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -276,7 +276,7 @@ struct tx4938_ccfg_reg {
 #define TX4938_EBUSC_SIZE(ch)	TX4927_EBUSC_SIZE(ch)
 
 #define tx4938_get_mem_size() tx4927_get_mem_size()
-void tx4938_wdr_init(void);
+void tx4938_wdt_init(void);
 void tx4938_setup(void);
 void tx4938_time_init(unsigned int tmrnr);
 void tx4938_setup_serial(void);
-- 
1.5.5.5
