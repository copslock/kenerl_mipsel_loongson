Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2012 14:19:18 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:62922 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823128Ab2J1NSYYiohL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2012 14:18:24 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1441551bkw.36
        for <multiple recipients>; Sun, 28 Oct 2012 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nbwK5RTdDcTS9aPuY/ZAB23QmP9YZtecYPK9UxyNYek=;
        b=wzkG7Mb2VsIb48dh9N7R1IVK+NeHUMyAuc1K5kXGQJ2LfVCm+6aLqbLsrbW0NpB9lu
         cyFIb+OS2bjc9SWI9zLMKB0o0BQ6MJ1K9qdwO7R5mTrshtT0Uh5MiOYVvCKiauEy2aKf
         xH+eV2nqs0quZiJfCYY6gUg/DWWyFLRJqoaeWw1k3/dqpomxYuNftK45hGiTl8mxhS0A
         gpv8UeAJdC7l5TZ3o/FjWfytLy6FG4c/wOviGG0tWovws5HbMTBNWykZpMtnDvsHBpTs
         RQ5fQivuj/ZdzDMQMvRed4G2BQkjw355gnf30OIZXHFJ2onmpOGm7azdpl6W+ltQWHP+
         FHbQ==
Received: by 10.204.146.13 with SMTP id f13mr8437155bkv.29.1351430299030;
        Sun, 28 Oct 2012 06:18:19 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id j24sm2575695bkv.0.2012.10.28.06.18.17
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 06:18:18 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] MIPS: BCM63XX: add core reset helper
Date:   Sun, 28 Oct 2012 14:17:54 +0100
Message-Id: <1351430275-14509-3-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
References: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add a reset helper for resetting the different cores.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/Makefile                         |    6 +-
 arch/mips/bcm63xx/reset.c                          |  223 ++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h |   21 ++
 3 files changed, 247 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/bcm63xx/reset.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 9bbb30a..bfc9b84 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,6 @@
-obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-flash.o dev-pcmcia.o dev-rng.o \
-		   dev-spi.o dev-uart.o dev-wdt.o dev-usb-usbd.o
+obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o reset.o setup.o \
+		   timer.o dev-dsp.o dev-enet.o dev-flash.o dev-pcmcia.o \
+		   dev-rng.o dev-spi.o dev-uart.o dev-wdt.o dev-usb-usbd.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
new file mode 100644
index 0000000..68a31bb
--- /dev/null
+++ b/arch/mips/bcm63xx/reset.c
@@ -0,0 +1,223 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_reset.h>
+
+#define __GEN_RESET_BITS_TABLE(__cpu)					\
+	[BCM63XX_RESET_SPI]		= BCM## __cpu ##_RESET_SPI,	\
+	[BCM63XX_RESET_ENET]		= BCM## __cpu ##_RESET_ENET,	\
+	[BCM63XX_RESET_USBH]		= BCM## __cpu ##_RESET_USBH,	\
+	[BCM63XX_RESET_USBD]		= BCM## __cpu ##_RESET_USBD,	\
+	[BCM63XX_RESET_DSL]		= BCM## __cpu ##_RESET_DSL,	\
+	[BCM63XX_RESET_SAR]		= BCM## __cpu ##_RESET_SAR,	\
+	[BCM63XX_RESET_EPHY]		= BCM## __cpu ##_RESET_EPHY,	\
+	[BCM63XX_RESET_ENETSW]		= BCM## __cpu ##_RESET_ENETSW,	\
+	[BCM63XX_RESET_PCM]		= BCM## __cpu ##_RESET_PCM,	\
+	[BCM63XX_RESET_MPI]		= BCM## __cpu ##_RESET_MPI,	\
+	[BCM63XX_RESET_PCIE]		= BCM## __cpu ##_RESET_PCIE,	\
+	[BCM63XX_RESET_PCIE_EXT]	= BCM## __cpu ##_RESET_PCIE_EXT,
+
+#define BCM6328_RESET_SPI	SOFTRESET_6328_SPI_MASK
+#define BCM6328_RESET_ENET	0
+#define BCM6328_RESET_USBH	SOFTRESET_6328_USBH_MASK
+#define BCM6328_RESET_USBD	SOFTRESET_6328_USBS_MASK
+#define BCM6328_RESET_DSL	0
+#define BCM6328_RESET_SAR	SOFTRESET_6328_SAR_MASK
+#define BCM6328_RESET_EPHY	SOFTRESET_6328_EPHY_MASK
+#define BCM6328_RESET_ENETSW	SOFTRESET_6328_ENETSW_MASK
+#define BCM6328_RESET_PCM	SOFTRESET_6328_PCM_MASK
+#define BCM6328_RESET_MPI	0
+#define BCM6328_RESET_PCIE	\
+				(SOFTRESET_6328_PCIE_MASK |		\
+				 SOFTRESET_6328_PCIE_CORE_MASK |	\
+				 SOFTRESET_6328_PCIE_HARD_MASK)
+#define BCM6328_RESET_PCIE_EXT	SOFTRESET_6328_PCIE_EXT_MASK
+
+#define BCM6338_RESET_SPI	SOFTRESET_6338_SPI_MASK
+#define BCM6338_RESET_ENET	SOFTRESET_6338_ENET_MASK
+#define BCM6338_RESET_USBH	SOFTRESET_6338_USBH_MASK
+#define BCM6338_RESET_USBD	SOFTRESET_6338_USBS_MASK
+#define BCM6338_RESET_DSL	SOFTRESET_6338_ADSL_MASK
+#define BCM6338_RESET_SAR	SOFTRESET_6338_SAR_MASK
+#define BCM6338_RESET_EPHY	0
+#define BCM6338_RESET_ENETSW	0
+#define BCM6338_RESET_PCM	0
+#define BCM6338_RESET_MPI	0
+#define BCM6338_RESET_PCIE	0
+#define BCM6338_RESET_PCIE_EXT	0
+
+#define BCM6348_RESET_SPI	SOFTRESET_6348_SPI_MASK
+#define BCM6348_RESET_ENET	SOFTRESET_6348_ENET_MASK
+#define BCM6348_RESET_USBH	SOFTRESET_6348_USBH_MASK
+#define BCM6348_RESET_USBD	SOFTRESET_6348_USBS_MASK
+#define BCM6348_RESET_DSL	SOFTRESET_6348_ADSL_MASK
+#define BCM6348_RESET_SAR	SOFTRESET_6348_SAR_MASK
+#define BCM6348_RESET_EPHY	0
+#define BCM6348_RESET_ENETSW	0
+#define BCM6348_RESET_PCM	0
+#define BCM6348_RESET_MPI	0
+#define BCM6348_RESET_PCIE	0
+#define BCM6348_RESET_PCIE_EXT	0
+
+#define BCM6358_RESET_SPI	SOFTRESET_6358_SPI_MASK
+#define BCM6358_RESET_ENET	SOFTRESET_6358_ENET_MASK
+#define BCM6358_RESET_USBH	SOFTRESET_6358_USBH_MASK
+#define BCM6358_RESET_USBD	0
+#define BCM6358_RESET_DSL	SOFTRESET_6358_ADSL_MASK
+#define BCM6358_RESET_SAR	SOFTRESET_6358_SAR_MASK
+#define BCM6358_RESET_EPHY	SOFTRESET_6358_EPHY_MASK
+#define BCM6358_RESET_ENETSW	0
+#define BCM6358_RESET_PCM	SOFTRESET_6358_PCM_MASK
+#define BCM6358_RESET_MPI	SOFTRESET_6358_MPI_MASK
+#define BCM6358_RESET_PCIE	0
+#define BCM6358_RESET_PCIE_EXT	0
+
+#define BCM6368_RESET_SPI	SOFTRESET_6368_SPI_MASK
+#define BCM6368_RESET_ENET	0
+#define BCM6368_RESET_USBH	SOFTRESET_6368_USBH_MASK
+#define BCM6368_RESET_USBD	SOFTRESET_6368_USBS_MASK
+#define BCM6368_RESET_DSL	0
+#define BCM6368_RESET_SAR	SOFTRESET_6368_SAR_MASK
+#define BCM6368_RESET_EPHY	SOFTRESET_6368_EPHY_MASK
+#define BCM6368_RESET_ENETSW	0
+#define BCM6368_RESET_PCM	SOFTRESET_6368_PCM_MASK
+#define BCM6368_RESET_MPI	SOFTRESET_6368_MPI_MASK
+#define BCM6368_RESET_PCIE	0
+#define BCM6368_RESET_PCIE_EXT	0
+
+#ifdef BCMCPU_RUNTIME_DETECT
+
+/*
+ * core reset bits
+ */
+static const u32 bcm6328_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6328)
+};
+
+static const u32 bcm6338_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6338)
+};
+
+static const u32 bcm6348_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6348)
+};
+
+static const u32 bcm6358_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6358)
+};
+
+static const u32 bcm6368_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6368)
+};
+
+const u32 *bcm63xx_reset_bits;
+static int reset_reg;
+
+static int __init bcm63xx_reset_bits_init(void)
+{
+	if (BCMCPU_IS_6328()) {
+		reset_reg = PERF_SOFTRESET_6328_REG;
+		bcm63xx_reset_bits = bcm6328_reset_bits;
+	} else if (BCMCPU_IS_6338()) {
+		reset_reg = PERF_SOFTRESET_REG;
+		bcm63xx_reset_bits = bcm6338_reset_bits;
+	} else if (BCMCPU_IS_6348()) {
+		reset_reg = PERF_SOFTRESET_REG;
+		bcm63xx_reset_bits = bcm6348_reset_bits;
+	} else if (BCMCPU_IS_6358()) {
+		reset_reg = PERF_SOFTRESET_6358_REG;
+		bcm63xx_reset_bits = bcm6358_reset_bits;
+	} else if (BCMCPU_IS_6368()) {
+		reset_reg = PERF_SOFTRESET_6368_REG;
+		bcm63xx_reset_bits = bcm6368_reset_bits;
+	}
+
+	return 0;
+}
+#else
+
+#ifdef CONFIG_BCM63XX_CPU_6328
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6328)
+};
+#define reset_reg PERF_SOFTRESET_6328_REG
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6338
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6338)
+};
+#define reset_reg PERF_SOFTRESET_REG
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6345
+static const u32 bcm63xx_reset_bits[] = { };
+#define reset_reg 0
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6348
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6348)
+};
+#define reset_reg PERF_SOFTRESET_REG
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6358
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6358)
+};
+#define reset_reg PERF_SOFTRESET_6358_REG
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6368
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(6368)
+};
+#define reset_reg PERF_SOFTRESET_6368_REG
+#endif
+
+static int __init bcm63xx_reset_bits_init(void) { return 0; }
+#endif
+
+static DEFINE_SPINLOCK(reset_mutex);
+
+static void __bcm63xx_core_set_reset(u32 mask, int enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	if (!mask)
+		return;
+
+	spin_lock_irqsave(&reset_mutex, flags);
+	val = bcm_perf_readl(reset_reg);
+
+	if (enable)
+		val &= ~mask;
+	else
+		val |= mask;
+
+	bcm_perf_writel(val, reset_reg);
+	spin_unlock_irqrestore(&reset_mutex, flags);
+}
+
+void bcm63xx_core_set_reset(enum bcm63xx_core_reset core, int reset)
+{
+	__bcm63xx_core_set_reset(bcm63xx_reset_bits[core], reset);
+}
+EXPORT_SYMBOL(bcm63xx_core_set_reset);
+
+postcore_initcall(bcm63xx_reset_bits_init);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h
new file mode 100644
index 0000000..3a6eb9c
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h
@@ -0,0 +1,21 @@
+#ifndef __BCM63XX_RESET_H
+#define __BCM63XX_RESET_H
+
+enum bcm63xx_core_reset {
+	BCM63XX_RESET_SPI,
+	BCM63XX_RESET_ENET,
+	BCM63XX_RESET_USBH,
+	BCM63XX_RESET_USBD,
+	BCM63XX_RESET_SAR,
+	BCM63XX_RESET_DSL,
+	BCM63XX_RESET_EPHY,
+	BCM63XX_RESET_ENETSW,
+	BCM63XX_RESET_PCM,
+	BCM63XX_RESET_MPI,
+	BCM63XX_RESET_PCIE,
+	BCM63XX_RESET_PCIE_EXT,
+};
+
+void bcm63xx_core_set_reset(enum bcm63xx_core_reset, int reset);
+
+#endif
-- 
1.7.2.5
