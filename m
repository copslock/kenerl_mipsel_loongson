Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2013 12:47:09 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35123 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867273Ab3K3LprKjZZc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Nov 2013 12:45:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1D90F2841AA;
        Sat, 30 Nov 2013 12:43:45 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id BD09D280732;
        Sat, 30 Nov 2013 12:43:43 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, linux-spi@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 4/5] MIPS: BCM63XX: add HSSPI platform device and register it
Date:   Sat, 30 Nov 2013 12:42:05 +0100
Message-Id: <1385811726-6746-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/Makefile                         |  4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |  3 ++
 arch/mips/bcm63xx/dev-hsspi.c                      | 47 ++++++++++++++++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h   |  8 ++++
 4 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-hsspi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index ac28073..9019f54 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,7 +1,7 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o nvram.o prom.o reset.o \
 		   setup.o timer.o dev-dsp.o dev-enet.o dev-flash.o \
-		   dev-pcmcia.o dev-rng.o dev-spi.o dev-uart.o dev-wdt.o \
-		   dev-usb-usbd.o
+		   dev-pcmcia.o dev-rng.o dev-spi.o dev-hsspi.o dev-uart.o \
+		   dev-wdt.o dev-usb-usbd.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 5b974eb..33727e7 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -23,6 +23,7 @@
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_flash.h>
+#include <bcm63xx_dev_hsspi.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_spi.h>
 #include <bcm63xx_dev_usb_usbd.h>
@@ -915,6 +916,8 @@ int __init board_register_devices(void)
 
 	bcm63xx_spi_register();
 
+	bcm63xx_hsspi_register();
+
 	bcm63xx_flash_register();
 
 	bcm63xx_led_data.num_leds = ARRAY_SIZE(board.leds);
diff --git a/arch/mips/bcm63xx/dev-hsspi.c b/arch/mips/bcm63xx/dev-hsspi.c
new file mode 100644
index 0000000..696abc4
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-hsspi.c
@@ -0,0 +1,47 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_hsspi.h>
+#include <bcm63xx_regs.h>
+
+static struct resource spi_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device bcm63xx_hsspi_device = {
+	.name		= "bcm63xx-hsspi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(spi_resources),
+	.resource	= spi_resources,
+};
+
+int __init bcm63xx_hsspi_register(void)
+{
+	if (!BCMCPU_IS_6328() && !BCMCPU_IS_6362())
+		return -ENODEV;
+
+	spi_resources[0].start = bcm63xx_regset_address(RSET_HSSPI);
+	spi_resources[0].end = spi_resources[0].start;
+	spi_resources[0].end += RSET_HSSPI_SIZE - 1;
+	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_HSSPI);
+
+	return platform_device_register(&bcm63xx_hsspi_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h
new file mode 100644
index 0000000..1b1acaf
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h
@@ -0,0 +1,8 @@
+#ifndef BCM63XX_DEV_HSSPI_H
+#define BCM63XX_DEV_HSSPI_H
+
+#include <linux/types.h>
+
+int bcm63xx_hsspi_register(void);
+
+#endif /* BCM63XX_DEV_HSSPI_H */
-- 
1.8.4.rc3
