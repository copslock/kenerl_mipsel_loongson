Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 20:02:51 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59807 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903742Ab1LITBy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 20:01:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 48D513616BD;
        Fri,  9 Dec 2011 20:01:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qgemnSX-G33b; Fri,  9 Dec 2011 20:01:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D03BD39884E;
        Fri,  9 Dec 2011 20:01:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Matt Mackall <mpm@selenic.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/5] MIPS: BCM63XX: add RNG driver platform_device stub
Date:   Fri,  9 Dec 2011 20:01:09 +0100
Message-Id: <1323457270-16330-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1323457270-16330-1-git-send-email-florian@openwrt.org>
References: <1323457270-16330-1-git-send-email-florian@openwrt.org>
X-archive-position: 32072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7987

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Makefile   |    3 ++-
 arch/mips/bcm63xx/dev-trng.c |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-trng.c

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 6dfdc69..95c45b5 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,5 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-uart.o dev-wdt.o
+		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-trng.o dev-uart.o \
+		   dev-wdt.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-trng.c b/arch/mips/bcm63xx/dev-trng.c
new file mode 100644
index 0000000..19ccfbf
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-trng.c
@@ -0,0 +1,40 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Florian Fainelli <florian@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+
+static struct resource trng_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device bcm63xx_trng_device = {
+	.name		= "bcm63xx-trng",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(trng_resources),
+	.resource	= trng_resources,
+};
+
+int __init bcm63xx_trng_register(void)
+{
+	if (!BCMCPU_IS_6368())
+		return -ENODEV;
+
+	trng_resources[0].start = bcm63xx_regset_address(RSET_TRNG);
+	trng_resources[0].end = trng_resources[0].start;
+	trng_resources[0].end += RSET_TRNG_SIZE - 1;
+
+	return platform_device_register(&bcm63xx_trng_device);
+}
+arch_initcall(bcm63xx_trng_register);
-- 
1.7.5.4
