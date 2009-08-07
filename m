Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:47:12 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:56610 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492938AbZHGVq3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:46:29 +0200
Received: by ewy12 with SMTP id 12so2282347ewy.0
        for <multiple recipients>; Fri, 07 Aug 2009 14:46:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wHwO6TZ8bVbgzZ5wNbI5QITQlzI+F/Wkwf4dNi++5NQ=;
        b=Brg/UeysHnuUh131W29y9ffMLv3S2c3FoOuhc+1chS17rxcSLPyXHE4q23XEA3pK2h
         JMqz/baV8sx0T4E2HQP+KsFkfAV0qz7DbgnU6RNJc9+DY6iDcOjuP/93sZje5XMeUuzx
         RKl9MZm0HsW3ZArvb063Az96VYuKvS94LmVMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=ufIL0OeBq9dIkOtMA9zSy8+zZFIDvCI8umyN+EFfFpCnJTHTihiYS7F+zumyVFXCxe
         ZtqPWzZ/F/9aQtOuZFEs6/6ezffgPYIdAfZf5+BtPP6kjgPp9mtdKnKl1QfsfwZl06ee
         E1J23TZgMi/oz5fHNQGtbPvKJ74GyGu2bpvJI=
Received: by 10.210.143.17 with SMTP id q17mr1938999ebd.97.1249681584244;
        Fri, 07 Aug 2009 14:46:24 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm2082843eye.14.2009.08.07.14.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:46:23 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:46:21 +0200
Subject: [PATCH 1/8] bcm63xx: add infrastructure for MPI-connected VoIP DSP
MIME-Version: 1.0
X-UID:	1178
X-Length: 4833
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.21785.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds the required infrastructure to register
a MPI and GPIO connected VoIP DSP. We will register
devices in a subsequent patch.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 92d07f0..70ba038 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -4,6 +4,7 @@ obj-y		+= dev-pcmcia.o
 obj-y		+= dev-usb-ohci.o
 obj-y		+= dev-usb-ehci.o
 obj-y		+= dev-enet.o
+obj-y		+= dev-dsp.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-dsp.c b/arch/mips/bcm63xx/dev-dsp.c
new file mode 100644
index 0000000..08a2f75
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-dsp.c
@@ -0,0 +1,56 @@
+/*
+ * Broadcom BCM63xx VoIP DSP registration
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Florian Fainelli <florian@openwrt.org> 
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_dsp.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+
+static struct resource voip_dsp_resources[] = {
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
+static struct platform_device bcm63xx_voip_dsp_device = {
+	.name		= "bcm63xx-voip-dsp",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(voip_dsp_resources),
+	.resource	= voip_dsp_resources,
+};
+
+int __init bcm63xx_dsp_register(const struct bcm63xx_dsp_platform_data *pd)
+{
+	struct bcm63xx_dsp_platform_data *dpd;
+	u32 val;
+
+	/* Get the memory window */
+	val = bcm_mpi_readl(MPI_CSBASE_REG(pd->cs - 1));
+	val &= MPI_CSBASE_BASE_MASK;
+	voip_dsp_resources[0].start = val;
+	voip_dsp_resources[0].end = val + 0xFFFFFFF;
+	voip_dsp_resources[1].start = pd->ext_irq;
+
+	/* copy given platform data */
+	dpd = bcm63xx_voip_dsp_device.dev.platform_data;
+	memcpy(dpd, pd, sizeof (*pd));
+
+	return platform_device_register(&bcm63xx_voip_dsp_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_dsp.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_dsp.h
new file mode 100644
index 0000000..b587d45
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_dsp.h
@@ -0,0 +1,13 @@
+#ifndef __BCM63XX_DSP_H
+#define __BCM63XX_DSP_H
+
+struct bcm63xx_dsp_platform_data {
+	unsigned gpio_rst;
+	unsigned gpio_int;
+	unsigned cs;
+	unsigned ext_irq;
+};
+
+int __init bcm63xx_dsp_register(const struct bcm63xx_dsp_platform_data *pd);
+
+#endif /* __BCM63XX_DSP_H */
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 17e4e7e..9fde025 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <bcm63xx_dev_enet.h>
+#include <bcm63xx_dev_dsp.h>
 
 /*
  * flash mapping
@@ -41,10 +42,14 @@ struct board_info {
 	unsigned int	has_pccard:1;
 	unsigned int	has_ohci0:1;
 	unsigned int	has_ehci0:1;
+	unsigned int	has_dsp:1;
 
 	/* ethernet config */
 	struct bcm63xx_enet_platform_data enet0;
 	struct bcm63xx_enet_platform_data enet1;
+
+	/* DSP config */
+	struct bcm63xx_dsp_platform_data dsp;
 };
 
 #endif /* ! BOARD_BCM963XX_H_ */
