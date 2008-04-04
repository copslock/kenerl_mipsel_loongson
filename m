Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 17:56:39 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20963 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S529372AbYDDP4O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 17:56:14 +0200
Received: from localhost (p2014-ipad306funabasi.chiba.ocn.ne.jp [123.217.172.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 86063AA8C; Sat,  5 Apr 2008 00:54:53 +0900 (JST)
Date:	Sat, 05 Apr 2008 00:55:41 +0900 (JST)
Message-Id: <20080405.005541.92586328.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/4] generic txx9 gpio support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This is a board-independent TXx9 gpio API implementation using gpiolib.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig            |    5 ++
 arch/mips/kernel/Makefile    |    2 +
 arch/mips/kernel/gpio_txx9.c |   87 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/txx9pio.h   |   29 ++++++++++++++
 4 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8724ed3..d06e204 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -788,6 +788,11 @@ config CSRC_R4K
 config CSRC_SB1250
 	bool
 
+config GPIO_TXX9
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
+	bool
+
 config CFE
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 9e78e1a..1eaf012 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -77,6 +77,8 @@ obj-$(CONFIG_64BIT)		+= cpu-bugs64.o
 
 obj-$(CONFIG_I8253)		+= i8253.o
 
+obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
+
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
diff --git a/arch/mips/kernel/gpio_txx9.c b/arch/mips/kernel/gpio_txx9.c
new file mode 100644
index 0000000..b1436a8
--- /dev/null
+++ b/arch/mips/kernel/gpio_txx9.c
@@ -0,0 +1,87 @@
+/*
+ * A gpio chip driver for TXx9 SoCs
+ *
+ * Copyright (C) 2008 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/gpio.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <asm/txx9pio.h>
+
+static DEFINE_SPINLOCK(txx9_gpio_lock);
+
+static struct txx9_pio_reg __iomem *txx9_pioptr;
+
+static int txx9_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	return __raw_readl(&txx9_pioptr->din) & (1 << offset);
+}
+
+static void txx9_gpio_set_raw(unsigned int offset, int value)
+{
+	u32 val;
+	val = __raw_readl(&txx9_pioptr->dout);
+	if (value)
+		val |= 1 << offset;
+	else
+		val &= ~(1 << offset);
+	__raw_writel(val, &txx9_pioptr->dout);
+}
+
+static void txx9_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&txx9_gpio_lock, flags);
+	txx9_gpio_set_raw(offset, value);
+	mmiowb();
+	spin_unlock_irqrestore(&txx9_gpio_lock, flags);
+}
+
+static int txx9_gpio_dir_in(struct gpio_chip *chip, unsigned int offset)
+{
+	spin_lock_irq(&txx9_gpio_lock);
+	__raw_writel(__raw_readl(&txx9_pioptr->dir) & ~(1 << offset),
+		     &txx9_pioptr->dir);
+	mmiowb();
+	spin_unlock_irq(&txx9_gpio_lock);
+	return 0;
+}
+
+static int txx9_gpio_dir_out(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	spin_lock_irq(&txx9_gpio_lock);
+	txx9_gpio_set_raw(offset, value);
+	__raw_writel(__raw_readl(&txx9_pioptr->dir) | (1 << offset),
+		     &txx9_pioptr->dir);
+	mmiowb();
+	spin_unlock_irq(&txx9_gpio_lock);
+	return 0;
+}
+
+static struct gpio_chip txx9_gpio_chip = {
+	.get = txx9_gpio_get,
+	.set = txx9_gpio_set,
+	.direction_input = txx9_gpio_dir_in,
+	.direction_output = txx9_gpio_dir_out,
+	.label = "TXx9",
+};
+
+int __init txx9_gpio_init(unsigned long baseaddr,
+			  unsigned int base, unsigned int num)
+{
+	txx9_pioptr = ioremap(baseaddr, sizeof(struct txx9_pio_reg));
+	if (!txx9_pioptr)
+		return -ENODEV;
+	txx9_gpio_chip.base = base;
+	txx9_gpio_chip.ngpio = num;
+	return gpiochip_add(&txx9_gpio_chip);
+}
diff --git a/include/asm-mips/txx9pio.h b/include/asm-mips/txx9pio.h
new file mode 100644
index 0000000..3d6fa9f
--- /dev/null
+++ b/include/asm-mips/txx9pio.h
@@ -0,0 +1,29 @@
+/*
+ * include/asm-mips/txx9pio.h
+ * TX39/TX49 PIO controller definitions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_TXX9PIO_H
+#define __ASM_TXX9PIO_H
+
+#include <linux/types.h>
+
+struct txx9_pio_reg {
+	__u32 dout;
+	__u32 din;
+	__u32 dir;
+	__u32 od;
+	__u32 flag[2];
+	__u32 pol;
+	__u32 intc;
+	__u32 maskcpu;
+	__u32 maskext;
+};
+
+int txx9_gpio_init(unsigned long baseaddr,
+		   unsigned int base, unsigned int num);
+
+#endif /* __ASM_TXX9PIO_H */
