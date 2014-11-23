Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2014 10:51:06 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:60814 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006659AbaKWJvE68moq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Nov 2014 10:51:04 +0100
Received: by mail-lb0-f176.google.com with SMTP id p9so5142269lbv.35
        for <multiple recipients>; Sun, 23 Nov 2014 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=M96b5cvQY3TRxaYvXoQ3x5eKfIQ7WPu7G2L5RYmMArA=;
        b=efmkgpINDYC7FlbzNeoJ44/HBIycxhp5b6UG6JMW3a9Y56ncSgRrAGXpcGz5zA84Sq
         jpQ6ke8DY87i///kvpxNuSTXELBtQA1TTfgxCUPwaLnn5/IS2DPFLpyFV1PUHkXzlhDq
         55jBBpLZQ5HrR0tjV1N0V5lkHBB0vEPVRWAByQciA4ObeecUntsj+1KiN+zf2SZ5gjH2
         /Ha+to+camWTfTj2qvkAyWudmGnf2wD3EJCmhiYnZr0ZKMz5NdvS0T3FUMB1qQxsG0xQ
         +8VA+3iTrvFs+H9Zs4X4KSIPQkCiJ1GH8Rg2GjaTitAbwuEQpA9utbjlbzyU5KR2rJbC
         JTtQ==
X-Received: by 10.112.184.70 with SMTP id es6mr14472377lbc.85.1416736259467;
        Sun, 23 Nov 2014 01:50:59 -0800 (PST)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id n7sm2594339lae.11.2014.11.23.01.50.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Nov 2014 01:50:58 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47XX: Move NVRAM driver to the drivers/soc/
Date:   Sun, 23 Nov 2014 10:50:41 +0100
Message-Id: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

After Broadcom switched from MIPS to ARM for their home routers we need
to have NVRAM driver in some common place (not arch/mips/).
We were thinking about putting it in bus directory, however there are
two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
won't fit there neither.
This is why I would like to move this driver to the drivers/soc/

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: Use drivers/soc/broadcom/ (instead of misc) and use -M for patch

I wasn't sure who to to/cc sending this patch. There isn't entry for
drivers/soc/ in MAINTAINERS. I picked e-mails from the commit
3a6e08218f36baa9c49282ad2fe0dfbf001d8f23
soc: Introduce drivers/soc place-holder for SOC specific drivers
---
 arch/mips/Kconfig                                            |  1 +
 arch/mips/bcm47xx/Makefile                                   |  2 +-
 arch/mips/bcm47xx/board.c                                    |  2 +-
 arch/mips/bcm47xx/setup.c                                    |  1 -
 arch/mips/bcm47xx/sprom.c                                    |  1 -
 arch/mips/bcm47xx/time.c                                     |  1 -
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h                 |  1 +
 drivers/bcma/driver_mips.c                                   |  2 +-
 drivers/net/ethernet/broadcom/b44.c                          |  2 +-
 drivers/net/ethernet/broadcom/bgmac.c                        |  2 +-
 drivers/soc/Kconfig                                          |  1 +
 drivers/soc/Makefile                                         |  1 +
 drivers/soc/broadcom/Kconfig                                 | 12 ++++++++++++
 drivers/soc/broadcom/Makefile                                |  1 +
 .../bcm47xx/nvram.c => drivers/soc/broadcom/bcm47xx_nvram.c  |  4 +++-
 drivers/ssb/driver_chipcommon_pmu.c                          |  2 +-
 drivers/ssb/driver_mipscore.c                                |  2 +-
 .../asm/mach-bcm47xx => include/linux}/bcm47xx_nvram.h       |  3 ---
 18 files changed, 27 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soc/broadcom/Kconfig
 create mode 100644 drivers/soc/broadcom/Makefile
 rename arch/mips/bcm47xx/nvram.c => drivers/soc/broadcom/bcm47xx_nvram.c (98%)
 rename {arch/mips/include/asm/mach-bcm47xx => include/linux}/bcm47xx_nvram.h (84%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a7e0c1..3d647e3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -134,6 +134,7 @@ config BCM47XX
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select GPIOLIB
 	select LEDS_GPIO_REGISTER
+	select BCM47XX_NVRAM
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index d58c51b..66bea4e 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,5 +3,5 @@
 # under Linux.
 #
 
-obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
+obj-y				+= irq.o prom.o serial.o setup.o time.o sprom.o
 obj-y				+= board.o buttons.o leds.o workarounds.o
diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index b3ae068..6e85130 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -1,8 +1,8 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/string.h>
+#include <bcm47xx.h>
 #include <bcm47xx_board.h>
-#include <bcm47xx_nvram.h>
 
 struct bcm47xx_board_type {
 	const enum bcm47xx_board board;
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index e43b504..b26c9c2 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -42,7 +42,6 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <bcm47xx_board.h>
 
 union bcm47xx_bus bcm47xx_bus;
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 2eff7fe..a077ed2 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -27,7 +27,6 @@
  */
 
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 2c85d92..5b46510 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -27,7 +27,6 @@
 #include <linux/ssb/ssb.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <bcm47xx_board.h>
 
 void __init plat_time_init(void)
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 7527c1d..8ed77f6 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -22,6 +22,7 @@
 #include <linux/ssb/ssb.h>
 #include <linux/bcma/bcma.h>
 #include <linux/bcma/bcma_soc.h>
+#include <linux/bcm47xx_nvram.h>
 
 enum bcm47xx_bus_type {
 #ifdef CONFIG_BCM47XX_SSB
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 8a653dc..15e278f 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -21,7 +21,7 @@
 #include <linux/serial_reg.h>
 #include <linux/time.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 enum bcma_boot_dev {
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 416620f..2095062 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -400,7 +400,7 @@ static void b44_set_flow_ctrl(struct b44 *bp, u32 local, u32 remote)
 }
 
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 static void b44_wap54g10_workaround(struct b44 *bp)
 {
 	char buf[20];
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 05c6af6..bdda57b 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -16,7 +16,7 @@
 #include <linux/phy.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 
 static const struct bcma_device_id bgmac_bcma_tbl[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_4706_MAC_GBIT, BCMA_ANY_REV, BCMA_ANY_CLASS),
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 76d6bd4..6eee174 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/broadcom/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 063113d..c57e8f9 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-y				+= broadcom/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
diff --git a/drivers/soc/broadcom/Kconfig b/drivers/soc/broadcom/Kconfig
new file mode 100644
index 0000000..4f1d498
--- /dev/null
+++ b/drivers/soc/broadcom/Kconfig
@@ -0,0 +1,12 @@
+#
+# Broadcom SoC drivers
+#
+
+config BCM47XX_NVRAM
+	bool "Broadcom NVRAM driver"
+	depends on BCM47XX || ARCH_BCM_5301X
+	help
+	  Broadcom home routers contain flash partition called "nvram" with all
+	  important hardware configuration as well as some minor user setup.
+	  It contains a text-like data representing name=value pairs.
+	  This driver provides an easy way to get value of requested parameter.
diff --git a/drivers/soc/broadcom/Makefile b/drivers/soc/broadcom/Makefile
new file mode 100644
index 0000000..f6816af
--- /dev/null
+++ b/drivers/soc/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BCM47XX_NVRAM)	+= bcm47xx_nvram.o
diff --git a/arch/mips/bcm47xx/nvram.c b/drivers/soc/broadcom/bcm47xx_nvram.c
similarity index 98%
rename from arch/mips/bcm47xx/nvram.c
rename to drivers/soc/broadcom/bcm47xx_nvram.c
index c5c381c..a4083d7 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/drivers/soc/broadcom/bcm47xx_nvram.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/mtd/mtd.h>
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 
 #define NVRAM_MAGIC		0x48534C46	/* 'FLSH' */
 #define NVRAM_SPACE		0x8000
@@ -226,3 +226,5 @@ int bcm47xx_nvram_gpio_pin(const char *name)
 	return -ENOENT;
 }
 EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
+
+MODULE_LICENSE("GPLv2");
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index 1173a09..0942841 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 7b986f9..f87efef 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -16,7 +16,7 @@
 #include <linux/serial_reg.h>
 #include <linux/time.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
similarity index 84%
rename from arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
rename to include/linux/bcm47xx_nvram.h
index ee59ffe..5ed6917 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -1,7 +1,4 @@
 /*
- *  Copyright (C) 2005, Broadcom Corporation
- *  Copyright (C) 2006, Felix Fietkau <nbd@openwrt.org>
- *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
-- 
1.8.4.5
