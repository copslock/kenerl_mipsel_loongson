Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:49:39 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34886 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492978AbZHGVrs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:47:48 +0200
Received: by ewy12 with SMTP id 12so2283012ewy.0
        for <multiple recipients>; Fri, 07 Aug 2009 14:47:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VajaOkDHtOJvKAIfCmp2L8FrWEEtaj1xHR/ddvvJFK4=;
        b=RA7IUuzms/sQGBtQeDCxDt91oZAU5pbVEqQ+Hv4onW0Vs5erV5zzWIbygdYXPVkeH6
         I7rjwEEyJ8VGP290hf4SyCsIRwWV5VqnTZtfT1o2/jgaEjkxRknOhScoSIZM5MHIhb6R
         zvqcHidmY0JWiUTg86VPq2Oe/Q2U8l0MHi+IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=fEcmusTQUzdwJil7Iss6baZKw+IyTPA3cnC7lHNN6FSUS4eT12UP1bZ4SMHYj+4D+m
         tp9pwU1AwwTpRjtCgECtnYGvuiIeGANu0hrSO7CaYmnPxbBdxMFQNLjSdfcBZ5OZ3gAi
         G66/7xtZPkq4swPnjaAQaOTqjMWPcCXgF0F40=
Received: by 10.210.62.3 with SMTP id k3mr1989281eba.36.1249681662952;
        Fri, 07 Aug 2009 14:47:42 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm4262227eyg.52.2009.08.07.14.47.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:47:42 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:47:15 +0200
Subject: [PATCH 8/8] bcm63xx: prepare for on-board watchdog support
MIME-Version: 1.0
X-UID:	1185
X-Length: 3927
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072347.16203.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch registers the watchdog platform_device that
we are going to use in the watchdog platform_driver in
a subsequent patch.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 70ba038..a4abc11 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -5,6 +5,7 @@ obj-y		+= dev-usb-ohci.o
 obj-y		+= dev-usb-ehci.o
 obj-y		+= dev-enet.o
 obj-y		+= dev-dsp.o
+obj-y		+= dev-wdt.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 17a8636..e6a7b4f 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -28,6 +28,7 @@
 #include <bcm63xx_dev_usb_ohci.h>
 #include <bcm63xx_dev_usb_ehci.h>
 #include <bcm63xx_dev_dsp.h>
+#include <bcm63xx_dev_wdt.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -798,6 +799,7 @@ int __init board_register_devices(void)
 	u32 val;
 
 	bcm63xx_uart_register();
+	bcm63xx_wdt_register();
 
 	if (board.has_pccard)
 		bcm63xx_pcmcia_register();
diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
new file mode 100644
index 0000000..6e18489
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-wdt.c
@@ -0,0 +1,36 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org> 
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+
+static struct resource wdt_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device bcm63xx_wdt_device = {
+	.name		= "bcm63xx-wdt",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
+	.resource	= wdt_resources,
+};
+
+int __init bcm63xx_wdt_register(void)
+{
+	wdt_resources[0].start = bcm63xx_regset_address(RSET_WDT);
+	wdt_resources[0].end = wdt_resources[0].start;
+	wdt_resources[0].end += RSET_WDT_SIZE - 1;
+
+	return platform_device_register(&bcm63xx_wdt_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h
new file mode 100644
index 0000000..4aae2c7
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h
@@ -0,0 +1,6 @@
+#ifndef BCM63XX_DEV_WDT_H_
+#define BCM63XX_DEV_WDT_H_
+
+int bcm63xx_wdt_register(void);
+
+#endif /* BCM63XX_DEV_WDT_H_ */
