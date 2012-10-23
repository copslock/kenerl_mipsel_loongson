Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:48:56 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:65033 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825697Ab2JWRsAT8HUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:00 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so2431934lag.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yakIoMfL5F1d1mjAp/1GKIw+GanWAlI5GQhptN7LBJM=;
        b=n57xy8lPNpXH1DjutymRcCARcAE5OpagwgCCCDQzn9Tcma5LPmlm+ueJywl7N/GyA8
         L3pf02lZf8TtVgHmgKPoutVYilnPTyCnoPIE2yKWnXmLzZ2ybKP6Di5Lea7rGgLsyCsr
         4EgH+cE68uDKFRMp4NoOg8hf+lkIpLg4jLcLg0Ivm9+LgeWPR9pEK7gwye7O9DTkCES6
         QLkKfKJELgkd3+rVQ/BUWnlOwg2UQq3ADD3vxGjv2rYTNvWpanC0zup86hAz5aZ8HGFa
         O9/N/2Vk8L1jMhaJPiU0wapw7a4rGQDK73VTr8DMpXkoM1uCJUV05sefqO2D8EIxHXG/
         GaBA==
Received: by 10.152.144.201 with SMTP id so9mr12223311lab.24.1351014474583;
        Tue, 23 Oct 2012 10:47:54 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:53 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 03/13] MIPS: JZ4750D: Add IRQ handler code
Date:   Tue, 23 Oct 2012 21:43:51 +0400
Message-Id: <1351014241-3207-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Add support for IRQ handling on a JZ4750D SoC.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/include/asm/mach-jz4750d/irq.h |   29 ++++++
 arch/mips/jz4750d/irq.c                  |  158 ++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-jz4750d/irq.h
 create mode 100644 arch/mips/jz4750d/irq.c

diff --git a/arch/mips/include/asm/mach-jz4750d/irq.h b/arch/mips/include/asm/mach-jz4750d/irq.h
new file mode 100644
index 0000000..3b157d0
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4750d/irq.h
@@ -0,0 +1,29 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D IRQ definitions
+ *
+ *  based on JZ4740 IRQ definitions
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __ASM_MACH_JZ4750D_IRQ_H__
+#define __ASM_MACH_JZ4750D_IRQ_H__
+
+#define MIPS_CPU_IRQ_BASE 0
+#define JZ4750D_IRQ_BASE 8
+
+#define JZ4750D_IRQ(x)		(JZ4750D_IRQ_BASE + (x))
+
+#define JZ4750D_IRQ_UART1	JZ4750D_IRQ(8)
+#define JZ4750D_IRQ_UART0	JZ4750D_IRQ(9)
+#define JZ4750D_IRQ_TCU1	JZ4750D_IRQ(22)
+
+#define NR_IRQS (256)
+
+#endif
diff --git a/arch/mips/jz4750d/irq.c b/arch/mips/jz4750d/irq.c
new file mode 100644
index 0000000..dcd1153
--- /dev/null
+++ b/arch/mips/jz4750d/irq.c
@@ -0,0 +1,158 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform IRQ support
+ *
+ *  based on JZ4740 platform IRQ support
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include <asm/io.h>
+#include <asm/mipsregs.h>
+#include <asm/irq_cpu.h>
+
+#include <asm/mach-jz4750d/base.h>
+
+static void __iomem *jz_intc_base;
+static uint32_t jz_intc_wakeup;
+
+#define JZ_REG_INTC_STATUS	0x00
+#define JZ_REG_INTC_MASK	0x04
+#define JZ_REG_INTC_SET_MASK	0x08
+#define JZ_REG_INTC_CLEAR_MASK	0x0c
+#define JZ_REG_INTC_PENDING	0x10
+
+#define IRQ_BIT(x) BIT((x) - JZ4750D_IRQ_BASE)
+
+static inline unsigned long intc_irq_bit(struct irq_data *data)
+{
+	return (unsigned long)irq_data_get_irq_chip_data(data);
+}
+
+static void intc_irq_unmask(struct irq_data *d)
+{
+	writel(intc_irq_bit(d), jz_intc_base + JZ_REG_INTC_CLEAR_MASK);
+}
+
+static void intc_irq_mask(struct irq_data *d)
+{
+	writel(intc_irq_bit(d), jz_intc_base + JZ_REG_INTC_SET_MASK);
+}
+
+static int intc_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	if (on)
+		jz_intc_wakeup |= intc_irq_bit(d);
+	else
+		jz_intc_wakeup &= ~intc_irq_bit(d);
+
+	return 0;
+}
+
+static struct irq_chip intc_irq_type = {
+	.name =		"INTC",
+	.irq_mask =	intc_irq_mask,
+	.irq_mask_ack =	intc_irq_mask,
+	.irq_unmask =	intc_irq_unmask,
+	.irq_set_wake =	intc_irq_set_wake,
+};
+
+static irqreturn_t jz4750d_cascade(int irq, void *data)
+{
+	uint32_t irq_reg;
+
+	irq_reg = readl(jz_intc_base + JZ_REG_INTC_PENDING);
+
+	if (irq_reg)
+		generic_handle_irq(__fls(irq_reg) + JZ4750D_IRQ_BASE);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction jz4750d_cascade_action = {
+	.handler = jz4750d_cascade,
+	.name = "JZ4750D cascade interrupt",
+};
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	mips_cpu_irq_init();
+
+	jz_intc_base = ioremap(JZ4750D_INTC_BASE_ADDR, 0x14);
+
+	for (i = JZ4750D_IRQ_BASE; i < JZ4750D_IRQ_BASE + 32; i++) {
+		irq_set_chip_data(i, (void *)IRQ_BIT(i));
+		irq_set_chip_and_handler(i, &intc_irq_type, handle_level_irq);
+	}
+
+	setup_irq(2, &jz4750d_cascade_action);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+	if (pending & STATUSF_IP2)
+		do_IRQ(2);
+	else if (pending & STATUSF_IP3)
+		do_IRQ(3);
+	else
+		spurious_interrupt();
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static inline void intc_seq_reg(struct seq_file *s, const char *name,
+	unsigned int reg)
+{
+	seq_printf(s, "%s:\t\t%08x\n", name, readl(jz_intc_base + reg));
+}
+
+static int intc_regs_show(struct seq_file *s, void *unused)
+{
+	intc_seq_reg(s, "Status", JZ_REG_INTC_STATUS);
+	intc_seq_reg(s, "Mask", JZ_REG_INTC_MASK);
+	intc_seq_reg(s, "Pending", JZ_REG_INTC_PENDING);
+
+	return 0;
+}
+
+static int intc_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, intc_regs_show, NULL);
+}
+
+static const struct file_operations intc_regs_operations = {
+	.open		= intc_regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init intc_debugfs_init(void)
+{
+	(void) debugfs_create_file("jz_regs_intc", S_IFREG | S_IRUGO,
+				NULL, NULL, &intc_regs_operations);
+	return 0;
+}
+subsys_initcall(intc_debugfs_init);
+
+#endif
-- 
1.7.10.4
