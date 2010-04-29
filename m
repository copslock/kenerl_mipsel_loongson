Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 11:59:04 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:41352 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492579Ab0D2J5C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 11:57:02 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id ACC6627401A; Thu, 29 Apr 2010 11:57:01 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 70837274012
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:57:00 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 0CCD584250
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 12:14:41 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 43BFAFF855
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:58:54 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] loongson 2f: Add gpio/gpioilb support
Organization: Mandriva
Date:   Thu, 29 Apr 2010 11:58:54 +0200
Message-ID: <m3sk6ewpep.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=


This patch is adding support for the 4 GPIO availables on the ST LS2F
cpus.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=stls2f_gpio.patch

 arch/mips/Kconfig                        |    2 	2 +	0 -	0 !
 arch/mips/include/asm/mach-lemote/gpio.h |   33 	33 +	0 -	0 !
 arch/mips/loongson/common/Makefile           |    2 	2 +	0 -	0 !
 arch/mips/loongson/common/gpio.c             |  128 	128 +	0 -	0 !
 arch/mips/loongson/common/platform.c         |   25 	25 +	0 -	0 !
 5 files changed, 190 insertions(+)

Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig
+++ linux-2.6/arch/mips/Kconfig
@@ -1073,6 +1073,8 @@ config CPU_LOONGSON2F
 	bool "Loongson 2F"
 	depends on SYS_HAS_CPU_LOONGSON2F
 	select CPU_LOONGSON2
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  The Loongson 2F processor implements the MIPS III instruction set
 	  with many extensions.
Index: linux-2.6/arch/mips/loongson/common/gpio.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/loongson/common/gpio.c
@@ -0,0 +1,140 @@
+/*
+ *  STLS2F GPIO Support
+ *
+ *  Copyright (c) 2008 Richard Liu,  STMicroelectronics  <richard.liu@st.com>
+ *  Copyright (c) 2008-2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <asm/types.h>
+#include <loongson.h>
+#include <linux/gpio.h>
+
+#define STLS2F_N_GPIO		4
+#define STLS2F_GPIO_IN_OFFSET	16
+
+static DEFINE_SPINLOCK(gpio_lock);
+
+int gpio_get_value(unsigned gpio)
+{
+	u32 val;
+	u32 mask;
+
+	if (gpio >= STLS2F_N_GPIO)
+		return __gpio_get_value(gpio);
+
+	mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
+	spin_lock(&gpio_lock);
+	val = LOONGSON_GPIODATA;
+	spin_unlock(&gpio_lock);
+
+	return ((val & mask) != 0);
+}
+EXPORT_SYMBOL(gpio_get_value);
+
+void gpio_set_value(unsigned gpio, int state)
+{
+	u32 val;
+	u32 mask;
+
+	if (gpio >= STLS2F_N_GPIO) {
+		__gpio_set_value(gpio, state);
+		return ;
+	}
+
+	mask = 1 << gpio;
+
+	spin_lock(&gpio_lock);
+	val = LOONGSON_GPIODATA;
+	if (state)
+		val |= mask;
+	else
+		val &= (~mask);
+	LOONGSON_GPIODATA = val;
+	spin_unlock(&gpio_lock);
+}
+EXPORT_SYMBOL(gpio_set_value);
+
+int gpio_cansleep(unsigned gpio)
+{
+	if (gpio < STLS2F_N_GPIO)
+		return 0;
+	else
+		return __gpio_cansleep(gpio);
+}
+EXPORT_SYMBOL(gpio_cansleep);
+
+static int ls2f_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	u32 temp;
+	u32 mask;
+
+	if (gpio >= STLS2F_N_GPIO)
+		return -EINVAL;
+
+	spin_lock(&gpio_lock);
+	mask = 1 << gpio;
+	temp = LOONGSON_GPIOIE;
+	temp |= mask;
+	LOONGSON_GPIOIE = temp;
+	spin_unlock(&gpio_lock);
+
+	return 0;
+}
+
+static int ls2f_gpio_direction_output(struct gpio_chip *chip,
+		unsigned gpio, int level)
+{
+	u32 temp;
+	u32 mask;
+
+	if (gpio >= STLS2F_N_GPIO)
+		return -EINVAL;
+
+	gpio_set_value(gpio, level);
+	spin_lock(&gpio_lock);
+	mask = 1 << gpio;
+	temp = LOONGSON_GPIOIE;
+	temp &= (~mask);
+	LOONGSON_GPIOIE = temp;
+	spin_unlock(&gpio_lock);
+
+	return 0;
+}
+
+static int ls2f_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	return gpio_get_value(gpio);
+}
+
+static void ls2f_gpio_set_value(struct gpio_chip *chip,
+		unsigned gpio, int value)
+{
+	gpio_set_value(gpio, value);
+}
+
+static struct gpio_chip ls2f_chip = {
+	.label                  = "ls2f",
+	.direction_input        = ls2f_gpio_direction_input,
+	.get                    = ls2f_gpio_get_value,
+	.direction_output       = ls2f_gpio_direction_output,
+	.set                    = ls2f_gpio_set_value,
+	.base                   = 0,
+	.ngpio                  = STLS2F_N_GPIO,
+};
+
+static int __init ls2f_gpio_setup(void)
+{
+	return gpiochip_add(&ls2f_chip);
+}
+arch_initcall(ls2f_gpio_setup);
+
Index: linux-2.6/arch/mips/loongson/common/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/loongson/common/Makefile
+++ linux-2.6/arch/mips/loongson/common/Makefile
@@ -4,6 +4,7 @@
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
     pci.o bonito-irq.o mem.o machtype.o platform.o
+obj-$(CONFIG_GENERIC_GPIO) += gpio.o
 
 #
 # Serial port support
Index: linux-2.6/arch/mips/include/asm/mach-loongson/gpio.h
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/include/asm/mach-loongson/gpio.h
@@ -0,0 +1,35 @@
+/*
+ * STLS2F GPIO Support
+ *
+ * Copyright (c) 2008  Richard Liu, STMicroelectronics <richard.liu@st.com>
+ * Copyright (c) 2008-2010  Arnaud Patard <apatard@mandriva.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef	__STLS2F_GPIO_H
+#define	__STLS2F_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+extern void gpio_set_value(unsigned gpio, int value);
+extern int gpio_get_value(unsigned gpio);
+extern int gpio_cansleep(unsigned gpio);
+
+/* The chip can do interrupt
+ * but it has not been tested and doc not clear
+ */
+static inline int gpio_to_irq(int gpio)
+{
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(int gpio)
+{
+	return -EINVAL;
+}
+
+#endif				/* __STLS2F_GPIO_H */

--=-=-=--
