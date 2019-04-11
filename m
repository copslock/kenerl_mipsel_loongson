Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125CC10F13
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68762083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NyswwkSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfDKMTv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:19:51 -0400
Received: from forward102o.mail.yandex.net ([37.140.190.182]:42153 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMTv (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:19:51 -0400
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10b])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 77E7866805EE;
        Thu, 11 Apr 2019 15:19:46 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Yzud8aYl5R-JkEmVGnp;
        Thu, 11 Apr 2019 15:19:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985186;
        bh=ZCgxGgbI3NnxP3eiQoMlAP/gbLLFRw0bOAEapVEEYQw=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=NyswwkSGVdV2E4mXVVn+Mk1RbFu3ENa5geHWGGjXJ8gu6Mo2Rlk79VYxwvfZ0ncsB
         X9mQPFy2lSo4fALreNNp9ClsMyl8P8Myq8wtQMpSiaBFAtTHwP8TTn1jkYjBXIuZr+
         XS22L+IWyYpEpAq73k22mFF8yxDHYDxo9K7nQJhU=
Authentication-Results: mxback2j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-JcCm2oNu;
        Thu, 11 Apr 2019 15:19:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/6] MIPS: Loongson32: Add DeviceTree support
Date:   Thu, 11 Apr 2019 20:19:11 +0800
Message-Id: <20190411121915.8040-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411121915.8040-1-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
 <20190411121915.8040-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Initial DeviceTree support for loongson32
Also remove the old IRQ driver since it have been replaced
by generic LS1X_IRQ.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                    |   5 +-
 arch/mips/loongson32/common/Makefile |   2 +-
 arch/mips/loongson32/common/irq.c    | 196 ---------------------------
 arch/mips/loongson32/common/setup.c  |  18 +++
 4 files changed, 23 insertions(+), 198 deletions(-)
 delete mode 100644 arch/mips/loongson32/common/irq.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ddfb587c4744..15f8cc3c965f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -437,6 +437,9 @@ config LASAT
 
 config MACH_LOONGSON32
 	bool "Loongson-1 family of machines"
+	select USE_OF
+	select BUILTIN_DTB
+	select LS1X_IRQ
 	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables support for the Loongson-1 family of machines.
@@ -3024,7 +3027,7 @@ endchoice
 choice
 	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
 	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
-					 !MIPS_MALTA && \
+					 !MACH_LOONGSON32 && !MIPS_MALTA && \
 					 !CAVIUM_OCTEON_SOC
 	default MIPS_CMDLINE_FROM_BOOTLOADER
 
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
index 723b4ce3b8f0..5b29badb0950 100644
--- a/arch/mips/loongson32/common/Makefile
+++ b/arch/mips/loongson32/common/Makefile
@@ -2,4 +2,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= time.o irq.o platform.o prom.o reset.o setup.o
+obj-y	+= time.o platform.o prom.o reset.o setup.o
diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
deleted file mode 100644
index 635a4abe1f48..000000000000
--- a/arch/mips/loongson32/common/irq.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <asm/irq_cpu.h>
-
-#include <loongson1.h>
-#include <irq.h>
-
-#define LS1X_INTC_REG(n, x) \
-		((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (n * 0x18) + (x)))
-
-#define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
-#define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
-#define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
-#define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
-#define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
-#define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
-
-static void ls1x_irq_ack(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
-			| (1 << bit), LS1X_INTC_INTCLR(n));
-}
-
-static void ls1x_irq_mask(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			& ~(1 << bit), LS1X_INTC_INTIEN(n));
-}
-
-static void ls1x_irq_mask_ack(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			& ~(1 << bit), LS1X_INTC_INTIEN(n));
-	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
-			| (1 << bit), LS1X_INTC_INTCLR(n));
-}
-
-static void ls1x_irq_unmask(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			| (1 << bit), LS1X_INTC_INTIEN(n));
-}
-
-static int ls1x_irq_settype(struct irq_data *d, unsigned int type)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	switch (type) {
-	case IRQ_TYPE_LEVEL_HIGH:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			| (1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			& ~(1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			| (1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			| (1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			& ~(1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			| (1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_EDGE_BOTH:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			& ~(1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			| (1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_NONE:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct irq_chip ls1x_irq_chip = {
-	.name		= "LS1X-INTC",
-	.irq_ack	= ls1x_irq_ack,
-	.irq_mask	= ls1x_irq_mask,
-	.irq_mask_ack	= ls1x_irq_mask_ack,
-	.irq_unmask	= ls1x_irq_unmask,
-	.irq_set_type   = ls1x_irq_settype,
-};
-
-static void ls1x_irq_dispatch(int n)
-{
-	u32 int_status, irq;
-
-	/* Get pending sources, masked by current enables */
-	int_status = __raw_readl(LS1X_INTC_INTISR(n)) &
-			__raw_readl(LS1X_INTC_INTIEN(n));
-
-	if (int_status) {
-		irq = LS1X_IRQ(n, __ffs(int_status));
-		do_IRQ(irq);
-	}
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending;
-
-	pending = read_c0_cause() & read_c0_status() & ST0_IM;
-
-	if (pending & CAUSEF_IP7)
-		do_IRQ(TIMER_IRQ);
-	else if (pending & CAUSEF_IP2)
-		ls1x_irq_dispatch(0); /* INT0 */
-	else if (pending & CAUSEF_IP3)
-		ls1x_irq_dispatch(1); /* INT1 */
-	else if (pending & CAUSEF_IP4)
-		ls1x_irq_dispatch(2); /* INT2 */
-	else if (pending & CAUSEF_IP5)
-		ls1x_irq_dispatch(3); /* INT3 */
-	else if (pending & CAUSEF_IP6)
-		ls1x_irq_dispatch(4); /* INT4 */
-	else
-		spurious_interrupt();
-
-}
-
-static struct irqaction cascade_irqaction = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
-static void __init ls1x_irq_init(int base)
-{
-	int n;
-
-	/* Disable interrupts and clear pending,
-	 * setup all IRQs as high level triggered
-	 */
-	for (n = 0; n < INTN; n++) {
-		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
-		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
-		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
-		/* set DMA0, DMA1 and DMA2 to edge trigger */
-		__raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
-	}
-
-
-	for (n = base; n < NR_IRQS; n++) {
-		irq_set_chip_and_handler(n, &ls1x_irq_chip,
-					 handle_level_irq);
-	}
-
-	setup_irq(INT0_IRQ, &cascade_irqaction);
-	setup_irq(INT1_IRQ, &cascade_irqaction);
-	setup_irq(INT2_IRQ, &cascade_irqaction);
-	setup_irq(INT3_IRQ, &cascade_irqaction);
-#if defined(CONFIG_LOONGSON1_LS1C)
-	setup_irq(INT4_IRQ, &cascade_irqaction);
-#endif
-}
-
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init();
-	ls1x_irq_init(LS1X_IRQ_BASE);
-}
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 1640744288ee..5ede65a79d6f 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -8,12 +8,30 @@
  */
 
 #include <asm/bootinfo.h>
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+#include <asm/prom.h>
 
+#include <asm/bootinfo.h>
 #include <prom.h>
 
 void __init plat_mem_setup(void)
 {
 	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+	__dt_setup_arch(__dtb_start);
+}
+
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+}
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
 }
 
 const char *get_system_type(void)
-- 
2.21.0

