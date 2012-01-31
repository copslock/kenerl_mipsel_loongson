Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:16:39 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59758 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904037Ab2AaOMs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:12:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 38297326BFA;
        Tue, 31 Jan 2012 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vgo0MeURhd-C; Tue, 31 Jan 2012 15:12:47 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D16BD35D006;
        Tue, 31 Jan 2012 15:12:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/5 v2] MIPS: BCM63XX: add RNG driver platform_device stub
Date:   Tue, 31 Jan 2012 15:12:24 +0100
Message-Id: <1328019145-5946-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019145-5946-1-git-send-email-florian@openwrt.org>
References: <1328019145-5946-1-git-send-email-florian@openwrt.org>
X-archive-position: 32361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- renamed TRNG -> RNG, trng -> rng
- fixed platform_device identifier since there is only one device

 arch/mips/bcm63xx/Makefile  |    4 ++--
 arch/mips/bcm63xx/dev-rng.c |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-rng.c

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 4049cd5..349b206 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-spi.o dev-uart.o \
-		   dev-wdt.o
+		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-rng.o dev-spi.o \
+		   dev-uart.o dev-wdt.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-rng.c b/arch/mips/bcm63xx/dev-rng.c
new file mode 100644
index 0000000..d277b4d
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-rng.c
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
+static struct resource rng_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device bcm63xx_rng_device = {
+	.name		= "bcm63xx-rng",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(rng_resources),
+	.resource	= rng_resources,
+};
+
+int __init bcm63xx_rng_register(void)
+{
+	if (!BCMCPU_IS_6368())
+		return -ENODEV;
+
+	rng_resources[0].start = bcm63xx_regset_address(RSET_RNG);
+	rng_resources[0].end = rng_resources[0].start;
+	rng_resources[0].end += RSET_RNG_SIZE - 1;
+
+	return platform_device_register(&bcm63xx_rng_device);
+}
+arch_initcall(bcm63xx_rng_register);
-- 
1.7.5.4
