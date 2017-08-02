Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 01:05:12 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:50357 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994866AbdHBW7UCR3IW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Aug 2017 00:59:20 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7CAC3461E3;
        Thu,  3 Aug 2017 00:59:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Qf2z7_dZOZ-I; Thu,  3 Aug 2017 00:59:13 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v8 16/16] MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c implementation
Date:   Thu,  3 Aug 2017 00:57:17 +0200
Message-Id: <20170802225717.24408-17-hauke@hauke-m.de>
In-Reply-To: <20170802225717.24408-1-hauke@hauke-m.de>
References: <20170802225717.24408-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The RCU register are now access through separates drivers. remove the
last pieces of the old implementation.

The GPHY reset bits are now set by the GPHY driver which registers a
reboot notifier. The reboot is triggered by a syscon-reboot driver and
the MIPS specific parts are done by the generic MIPS implementation in
arch/mips/kernel/reset.c.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/Kconfig       |   1 +
 arch/mips/lantiq/xway/Makefile |   2 +-
 arch/mips/lantiq/xway/reset.c  | 147 -----------------------------------------
 3 files changed, 2 insertions(+), 148 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/reset.c

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index f5db4a426568..35bc69b78268 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -18,6 +18,7 @@ config SOC_XWAY
 	select SOC_TYPE_XWAY
 	select HW_HAS_PCI
 	select MFD_SYSCON
+	select MFD_CORE
 
 config SOC_FALCON
 	bool "FALCON"
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 6daf3149e7ca..fbb0747c70b7 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,3 +1,3 @@
-obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o dcdc.o
+obj-y := prom.o sysctrl.o clk.o dma.o gptu.o dcdc.o
 
 obj-y += vmmc.o
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
deleted file mode 100644
index 04cd9a7c04a3..000000000000
--- a/arch/mips/lantiq/xway/reset.c
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <john@phrozen.org>
- *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
- */
-
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/pm.h>
-#include <linux/export.h>
-#include <linux/delay.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/reset-controller.h>
-
-#include <asm/reboot.h>
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-
-/* reset request register */
-#define RCU_RST_REQ		0x0010
-/* reset status register */
-#define RCU_RST_STAT		0x0014
-
-/* xbar BE flag */
-#define RCU_AHB_ENDIAN          0x004C
-#define RCU_VR9_BE_AHB1S        0x00000008
-
-/* reboot bit */
-#define RCU_RD_GPHY0_XRX200	BIT(31)
-#define RCU_RD_SRST		BIT(30)
-#define RCU_RD_GPHY1_XRX200	BIT(29)
-
-/* reset cause */
-#define RCU_STAT_SHIFT		26
-/* boot selection */
-#define RCU_BOOT_SEL(x)		((x >> 18) & 0x7)
-#define RCU_BOOT_SEL_XRX200(x)	(((x >> 17) & 0xf) | ((x >> 8) & 0x10))
-
-/* dwc2 USB configuration registers */
-#define RCU_USB1CFG		0x0018
-#define RCU_USB2CFG		0x0034
-
-/* USB DMA endianness bits */
-#define RCU_USBCFG_HDSEL_BIT	BIT(11)
-#define RCU_USBCFG_HOST_END_BIT	BIT(10)
-#define RCU_USBCFG_SLV_END_BIT	BIT(9)
-
-/* USB reset bits */
-#define RCU_USBRESET		0x0010
-
-#define USBRESET_BIT		BIT(4)
-
-#define RCU_USBRESET2		0x0048
-
-#define USB1RESET_BIT		BIT(4)
-#define USB2RESET_BIT		BIT(5)
-
-#define RCU_CFG1A		0x0038
-#define RCU_CFG1B		0x003C
-
-/* USB PMU devices */
-#define PMU_AHBM		BIT(15)
-#define PMU_USB0		BIT(6)
-#define PMU_USB1		BIT(27)
-
-/* USB PHY PMU devices */
-#define PMU_USB0_P		BIT(0)
-#define PMU_USB1_P		BIT(26)
-
-/* remapped base addr of the reset control unit */
-static void __iomem *ltq_rcu_membase;
-static struct device_node *ltq_rcu_np;
-
-static void ltq_rcu_w32(uint32_t val, uint32_t reg_off)
-{
-	ltq_w32(val, ltq_rcu_membase + reg_off);
-}
-
-static uint32_t ltq_rcu_r32(uint32_t reg_off)
-{
-	return ltq_r32(ltq_rcu_membase + reg_off);
-}
-
-static void ltq_machine_restart(char *command)
-{
-	u32 val = ltq_rcu_r32(RCU_RST_REQ);
-
-	if (of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200"))
-		val |= RCU_RD_GPHY1_XRX200 | RCU_RD_GPHY0_XRX200;
-
-	val |= RCU_RD_SRST;
-
-	local_irq_disable();
-	ltq_rcu_w32(val, RCU_RST_REQ);
-	unreachable();
-}
-
-static void ltq_machine_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
-static void ltq_machine_power_off(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
-static int __init mips_reboot_setup(void)
-{
-	struct resource res;
-
-	ltq_rcu_np = of_find_compatible_node(NULL, NULL, "lantiq,rcu-xway");
-	if (!ltq_rcu_np)
-		ltq_rcu_np = of_find_compatible_node(NULL, NULL,
-							"lantiq,rcu-xrx200");
-
-	/* check if all the reset register range is available */
-	if (!ltq_rcu_np)
-		panic("Failed to load reset resources from devicetree");
-
-	if (of_address_to_resource(ltq_rcu_np, 0, &res))
-		panic("Failed to get rcu memory range");
-
-	if (!request_mem_region(res.start, resource_size(&res), res.name))
-		pr_err("Failed to request rcu memory");
-
-	ltq_rcu_membase = ioremap_nocache(res.start, resource_size(&res));
-	if (!ltq_rcu_membase)
-		panic("Failed to remap core memory");
-
-	_machine_restart = ltq_machine_restart;
-	_machine_halt = ltq_machine_halt;
-	pm_power_off = ltq_machine_power_off;
-
-	return 0;
-}
-
-arch_initcall(mips_reboot_setup);
-- 
2.11.0
