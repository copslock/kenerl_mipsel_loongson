Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 13:53:32 +0100 (CET)
Received: from mail-ee0-f50.google.com ([74.125.83.50]:33948 "EHLO
        mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821116AbaABMx3dTJeH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 13:53:29 +0100
Received: by mail-ee0-f50.google.com with SMTP id c41so6173405eek.23
        for <multiple recipients>; Thu, 02 Jan 2014 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qI6R5usOXq/Vo36sCRI8pNgDvmtS129XFhYFHYQTxu4=;
        b=R5rf26+QuGcyk6VnWAiN8BEFoB87gZCmFLLmaGhJnxv2Fl0kLMZu21iXl2etcB7/qD
         bQVhMoWVubQSQ666X7HGrEFoXBGBUjDU4EuqqKFlQG0fBoNsVXdvjL1jGSi90Ub0cbT3
         TRCKe4937/GQD9++c6ifcw3REIPttQLe50PGlFB/qzwU4Y2OJ2qxEQg5u5vQ2drFFzFL
         6oKKdDKPvVDq0VD+dSAJ1uXVhHE3yb425jphGX0yInBhQcYsZBbgVT+NRxPWmK7W6g7i
         75X3dAp1S2BZsHA2kO3YiEL/scKCE6s4Rt7BfBrtEEEAztjd+SiADXLIpC+RxsIoUmcC
         mCmw==
X-Received: by 10.14.149.139 with SMTP id x11mr15219836eej.35.1388667202693;
        Thu, 02 Jan 2014 04:53:22 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id a51sm135826865eeh.8.2014.01.02.04.53.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2014 04:53:22 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Drop WGT634U hacks
Date:   Thu,  2 Jan 2014 13:53:15 +0100
Message-Id: <1388667195-19811-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38835
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

This old wgt634u.c was trying to implement a bit ugly support for
Netgear WGT634U. It provided info about LED, flash mapping & layout and
was trying to handle reset button.

This is not needed anymore as we have replacement for all this stuff.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/Makefile  |    1 -
 arch/mips/bcm47xx/wgt634u.c |  174 -------------------------------------------
 2 files changed, 175 deletions(-)
 delete mode 100644 arch/mips/bcm47xx/wgt634u.c

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 006a05e..4688b6a 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -5,4 +5,3 @@
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
 obj-y				+= board.o buttons.o leds.o
-obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
deleted file mode 100644
index c63a4c2..0000000
--- a/arch/mips/bcm47xx/wgt634u.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
- */
-
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/leds.h>
-#include <linux/mtd/physmap.h>
-#include <linux/ssb/ssb.h>
-#include <linux/ssb/ssb_embedded.h>
-#include <linux/interrupt.h>
-#include <linux/reboot.h>
-#include <linux/gpio.h>
-#include <asm/mach-bcm47xx/bcm47xx.h>
-
-/* GPIO definitions for the WGT634U */
-#define WGT634U_GPIO_LED	3
-#define WGT634U_GPIO_RESET	2
-#define WGT634U_GPIO_TP1	7
-#define WGT634U_GPIO_TP2	6
-#define WGT634U_GPIO_TP3	5
-#define WGT634U_GPIO_TP4	4
-#define WGT634U_GPIO_TP5	1
-
-static struct gpio_led wgt634u_leds[] = {
-	{
-		.name = "power",
-		.gpio = WGT634U_GPIO_LED,
-		.active_low = 1,
-		.default_trigger = "heartbeat",
-	},
-};
-
-static struct gpio_led_platform_data wgt634u_led_data = {
-	.num_leds =	ARRAY_SIZE(wgt634u_leds),
-	.leds =		wgt634u_leds,
-};
-
-static struct platform_device wgt634u_gpio_leds = {
-	.name =		"leds-gpio",
-	.id =		-1,
-	.dev = {
-		.platform_data = &wgt634u_led_data,
-	}
-};
-
-
-/* 8MiB flash. The struct mtd_partition matches original Netgear WGT634U
-   firmware. */
-static struct mtd_partition wgt634u_partitions[] = {
-	{
-		.name	    = "cfe",
-		.offset	    = 0,
-		.size	    = 0x60000,		/* 384k */
-		.mask_flags = MTD_WRITEABLE	/* force read-only */
-	},
-	{
-		.name	= "config",
-		.offset = 0x60000,
-		.size	= 0x20000		/* 128k */
-	},
-	{
-		.name	= "linux",
-		.offset = 0x80000,
-		.size	= 0x140000		/* 1280k */
-	},
-	{
-		.name	= "jffs",
-		.offset = 0x1c0000,
-		.size	= 0x620000		/* 6272k */
-	},
-	{
-		.name	= "nvram",
-		.offset = 0x7e0000,
-		.size	= 0x20000		/* 128k */
-	},
-};
-
-static struct physmap_flash_data wgt634u_flash_data = {
-	.parts	  = wgt634u_partitions,
-	.nr_parts = ARRAY_SIZE(wgt634u_partitions)
-};
-
-static struct resource wgt634u_flash_resource = {
-	.flags = IORESOURCE_MEM,
-};
-
-static struct platform_device wgt634u_flash = {
-	.name	       = "physmap-flash",
-	.id	       = 0,
-	.dev	       = { .platform_data = &wgt634u_flash_data, },
-	.resource      = &wgt634u_flash_resource,
-	.num_resources = 1,
-};
-
-/* Platform devices */
-static struct platform_device *wgt634u_devices[] __initdata = {
-	&wgt634u_flash,
-	&wgt634u_gpio_leds,
-};
-
-static irqreturn_t gpio_interrupt(int irq, void *ignored)
-{
-	int state;
-
-	/* Interrupts are shared, check if the current one is
-	   a GPIO interrupt. */
-	if (!ssb_chipco_irq_status(&bcm47xx_bus.ssb.chipco,
-				   SSB_CHIPCO_IRQ_GPIO))
-		return IRQ_NONE;
-
-	state = gpio_get_value(WGT634U_GPIO_RESET);
-
-	/* Interrupt are level triggered, revert the interrupt polarity
-	   to clear the interrupt. */
-	ssb_gpio_polarity(&bcm47xx_bus.ssb, 1 << WGT634U_GPIO_RESET,
-			  state ? 1 << WGT634U_GPIO_RESET : 0);
-
-	if (!state) {
-		printk(KERN_INFO "Reset button pressed");
-		ctrl_alt_del();
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int __init wgt634u_init(void)
-{
-	/* There is no easy way to detect that we are running on a WGT634U
-	 * machine. Use the MAC address as an heuristic. Netgear Inc. has
-	 * been allocated ranges 00:09:5b:xx:xx:xx and 00:0f:b5:xx:xx:xx.
-	 */
-	u8 *et0mac;
-
-	if (bcm47xx_bus_type != BCM47XX_BUS_TYPE_SSB)
-		return -ENODEV;
-
-	et0mac = bcm47xx_bus.ssb.sprom.et0mac;
-
-	if (et0mac[0] == 0x00 &&
-	    ((et0mac[1] == 0x09 && et0mac[2] == 0x5b) ||
-	     (et0mac[1] == 0x0f && et0mac[2] == 0xb5))) {
-		struct ssb_mipscore *mcore = &bcm47xx_bus.ssb.mipscore;
-
-		printk(KERN_INFO "WGT634U machine detected.\n");
-
-		if (!request_irq(gpio_to_irq(WGT634U_GPIO_RESET),
-				 gpio_interrupt, IRQF_SHARED,
-				 "WGT634U GPIO", &bcm47xx_bus.ssb.chipco)) {
-			gpio_direction_input(WGT634U_GPIO_RESET);
-			ssb_gpio_intmask(&bcm47xx_bus.ssb,
-					 1 << WGT634U_GPIO_RESET,
-					 1 << WGT634U_GPIO_RESET);
-			ssb_chipco_irq_mask(&bcm47xx_bus.ssb.chipco,
-					    SSB_CHIPCO_IRQ_GPIO,
-					    SSB_CHIPCO_IRQ_GPIO);
-		}
-
-		wgt634u_flash_data.width = mcore->pflash.buswidth;
-		wgt634u_flash_resource.start = mcore->pflash.window;
-		wgt634u_flash_resource.end = mcore->pflash.window
-					   + mcore->pflash.window_size
-					   - 1;
-		return platform_add_devices(wgt634u_devices,
-					    ARRAY_SIZE(wgt634u_devices));
-	} else
-		return -ENODEV;
-}
-
-module_init(wgt634u_init);
-- 
1.7.10.4
