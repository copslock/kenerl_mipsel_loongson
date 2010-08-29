Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Aug 2010 17:08:30 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:64100 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0H2PHq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Aug 2010 17:07:46 +0200
Received: by wwb31 with SMTP id 31so5486049wwb.24
        for <multiple recipients>; Sun, 29 Aug 2010 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=Ji8b7lJagnwohZXDaSh6i3t6QL24/OzGgvbUfapcXRI=;
        b=xslik1s5HSBiHQz1Os7IW1VGYfsa1VFeVttX6vq5AQK06LHzm5ZPIKF/Lb3bREtY2s
         bKaPQ+fpCgHzQughaHe8O7CzR6C9cE7Kl28/V/eiJCy9f2+dpBNplwYlhoNm8ZaHeNO5
         ueCUE3Bt4NIt/jkg77MInCHJP0aD7KUvNQtwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=LIEMq7sp6eMyHtGT0AX5r2bAa2ry0N05tUnVWWOs3FLQZGeEgUyxA9+u5gpLh0I2aP
         6XwG/OC3mwFDeLv5xhWfW9LAuZCCyKPon1ck5pL9EiqVLtTB3ssavXaJE725M9XkEicq
         HMxVAhao51DJ3nSYoswseyew9AImLuvZZbsHM=
Received: by 10.216.46.15 with SMTP id q15mr3623226web.103.1283094461165;
        Sun, 29 Aug 2010 08:07:41 -0700 (PDT)
Received: from lenovo.localnet (129.199.66-86.rev.gaoland.net [86.66.199.129])
        by mx.google.com with ESMTPS id p42sm3824598weq.12.2010.08.29.08.07.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 08:07:40 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 29 Aug 2010 17:08:44 +0200
Subject: [PATCH 2/2] AR7: add support for Titan (TNETV10xx) SoC variant
MIME-Version: 1.0
X-UID:  186
X-Length: 16906
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201008291708.45299.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Add support for Titan TNETV1050,1055,1056,1060 variants. This SoC is almost
completely identical to AR7 except on a few points:
- a second bank of gpios is available
- vlynq0 on titan is vlynq1 on ar7
- different PHY addresses for cpmac0

This SoC can be found on commercial products like the Linksys WRTP54G

Signed-off-by: Xin Zhen <xlonestar2000@aim.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index f848342..425dfa5 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
  * Copyright (C) 2007 Eugene Konev <ejka@openwrt.org>
- * Copyright (C) 2009 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2009-2010 Florian Fainelli <florian@openwrt.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -37,6 +37,16 @@ static int ar7_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 	return readl(gpio_in) & (1 << gpio);
 }
 
+static int titan_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_in0 = gpch->regs + TITAN_GPIO_INPUT_0;
+	void __iomem *gpio_in1 = gpch->regs + TITAN_GPIO_INPUT_1;
+
+	return readl(gpio >> 5 ? gpio_in1 : gpio_in0) & (1 << (gpio & 0x1f));
+}
+
 static void ar7_gpio_set_value(struct gpio_chip *chip,
 				unsigned gpio, int value)
 {
@@ -51,6 +61,21 @@ static void ar7_gpio_set_value(struct gpio_chip *chip,
 	writel(tmp, gpio_out);
 }
 
+static void titan_gpio_set_value(struct gpio_chip *chip,
+				unsigned gpio, int value)
+{
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_out0 = gpch->regs + TITAN_GPIO_OUTPUT_0;
+	void __iomem *gpio_out1 = gpch->regs + TITAN_GPIO_OUTPUT_1;
+	unsigned tmp;
+
+	tmp = readl(gpio >> 5 ? gpio_out1 : gpio_out0) & ~(1 << (gpio & 0x1f));
+	if (value)
+		tmp |= 1 << (gpio & 0x1f);
+	writel(tmp, gpio >> 5 ? gpio_out1 : gpio_out0);
+}
+
 static int ar7_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
 	struct ar7_gpio_chip *gpch =
@@ -62,6 +87,21 @@ static int ar7_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 	return 0;
 }
 
+static int titan_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_dir0 = gpch->regs + TITAN_GPIO_DIR_0;
+	void __iomem *gpio_dir1 = gpch->regs + TITAN_GPIO_DIR_1;
+
+	if (gpio >= TITAN_GPIO_MAX)
+		return -EINVAL;
+
+	writel(readl(gpio >> 5 ? gpio_dir1 : gpio_dir0) | (1 << (gpio & 0x1f)),
+			gpio >> 5 ? gpio_dir1 : gpio_dir0);
+	return 0;
+}
+
 static int ar7_gpio_direction_output(struct gpio_chip *chip,
 					unsigned gpio, int value)
 {
@@ -75,6 +115,24 @@ static int ar7_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int titan_gpio_direction_output(struct gpio_chip *chip,
+					unsigned gpio, int value)
+{
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_dir0 = gpch->regs + TITAN_GPIO_DIR_0;
+	void __iomem *gpio_dir1 = gpch->regs + TITAN_GPIO_DIR_1;
+
+	if (gpio >= TITAN_GPIO_MAX)
+		return -EINVAL;
+
+	titan_gpio_set_value(chip, gpio, value);
+	writel(readl(gpio >> 5 ? gpio_dir1 : gpio_dir0) & ~(1 <<
+		(gpio & 0x1f)), gpio >> 5 ? gpio_dir1 : gpio_dir0);
+
+	return 0;
+}
+
 static struct ar7_gpio_chip ar7_gpio_chip = {
 	.chip = {
 		.label			= "ar7-gpio",
@@ -87,7 +145,19 @@ static struct ar7_gpio_chip ar7_gpio_chip = {
 	}
 };
 
-int ar7_gpio_enable(unsigned gpio)
+static struct ar7_gpio_chip titan_gpio_chip = {
+	.chip = {
+		.label			= "titan-gpio",
+		.direction_input	= titan_gpio_direction_input,
+		.direction_output	= titan_gpio_direction_output,
+		.set			= titan_gpio_set_value,
+		.get			= titan_gpio_get_value,
+		.base			= 0,
+		.ngpio			= TITAN_GPIO_MAX,
+	}
+};
+
+static inline int ar7_gpio_enable_ar7(unsigned gpio)
 {
 	void __iomem *gpio_en = ar7_gpio_chip.regs + AR7_GPIO_ENABLE;
 
@@ -95,9 +165,26 @@ int ar7_gpio_enable(unsigned gpio)
 
 	return 0;
 }
+
+static inline int ar7_gpio_enable_titan(unsigned gpio)
+{
+	void __iomem *gpio_en0 = titan_gpio_chip.regs  + TITAN_GPIO_ENBL_0;
+	void __iomem *gpio_en1 = titan_gpio_chip.regs  + TITAN_GPIO_ENBL_1;
+
+	writel(readl(gpio >> 5 ? gpio_en1 : gpio_en0) | (1 << (gpio & 0x1f)),
+		gpio >> 5 ? gpio_en1 : gpio_en0);
+
+	return 0;
+}
+
+int ar7_gpio_enable(unsigned gpio)
+{
+	return ar7_is_titan() ? ar7_gpio_enable_titan(gpio) :
+				ar7_gpio_enable_ar7(gpio);
+}
 EXPORT_SYMBOL(ar7_gpio_enable);
 
-int ar7_gpio_disable(unsigned gpio)
+static inline int ar7_gpio_disable_ar7(unsigned gpio)
 {
 	void __iomem *gpio_en = ar7_gpio_chip.regs + AR7_GPIO_ENABLE;
 
@@ -105,26 +192,159 @@ int ar7_gpio_disable(unsigned gpio)
 
 	return 0;
 }
+
+static inline int ar7_gpio_disable_titan(unsigned gpio)
+{
+	void __iomem *gpio_en0 = titan_gpio_chip.regs + TITAN_GPIO_ENBL_0;
+	void __iomem *gpio_en1 = titan_gpio_chip.regs + TITAN_GPIO_ENBL_1;
+
+	writel(readl(gpio >> 5 ? gpio_en1 : gpio_en0) & ~(1 << (gpio & 0x1f)),
+			gpio >> 5 ? gpio_en1 : gpio_en0);
+
+	return 0;
+}
+
+int ar7_gpio_disable(unsigned gpio)
+{
+	return ar7_is_titan() ? ar7_gpio_disable_titan(gpio) :
+				ar7_gpio_disable_ar7(gpio);
+}
 EXPORT_SYMBOL(ar7_gpio_disable);
 
+struct titan_gpio_cfg {
+	u32 reg;
+	u32 shift;
+	u32 func;
+};
+
+static struct titan_gpio_cfg titan_gpio_table[] = {
+	/* reg, start bit, mux value */
+	{4, 24, 1},
+	{4, 26, 1},
+	{4, 28, 1},
+	{4, 30, 1},
+	{5, 6, 1},
+	{5, 8, 1},
+	{5, 10, 1},
+	{5, 12, 1},
+	{7, 14, 3},
+	{7, 16, 3},
+	{7, 18, 3},
+	{7, 20, 3},
+	{7, 22, 3},
+	{7, 26, 3},
+	{7, 28, 3},
+	{7, 30, 3},
+	{8, 0, 3},
+	{8, 2, 3},
+	{8, 4, 3},
+	{8, 10, 3},
+	{8, 14, 3},
+	{8, 16, 3},
+	{8, 18, 3},
+	{8, 20, 3},
+	{9, 8, 3},
+	{9, 10, 3},
+	{9, 12, 3},
+	{9, 14, 3},
+	{9, 18, 3},
+	{9, 20, 3},
+	{9, 24, 3},
+	{9, 26, 3},
+	{9, 28, 3},
+	{9, 30, 3},
+	{10, 0, 3},
+	{10, 2, 3},
+	{10, 8, 3},
+	{10, 10, 3},
+	{10, 12, 3},
+	{10, 14, 3},
+	{13, 12, 3},
+	{13, 14, 3},
+	{13, 16, 3},
+	{13, 18, 3},
+	{13, 24, 3},
+	{13, 26, 3},
+	{13, 28, 3},
+	{13, 30, 3},
+	{14, 2, 3},
+	{14, 6, 3},
+	{14, 8, 3},
+	{14, 12, 3}
+};
+
+static int titan_gpio_pinsel(unsigned gpio)
+{
+	struct titan_gpio_cfg gpio_cfg;
+	u32 mux_status, pin_sel_reg, tmp;
+	void __iomem *pin_sel = (void __iomem *)KSEG1ADDR(AR7_REGS_PINSEL);
+
+	if (gpio >= ARRAY_SIZE(titan_gpio_table))
+		return -EINVAL;
+
+	gpio_cfg = titan_gpio_table[gpio];
+	pin_sel_reg = gpio_cfg.reg - 1;
+
+	mux_status = (readl(pin_sel + pin_sel_reg) >> gpio_cfg.shift) & 0x3;
+
+	/* Check the mux status */
+	if (!((mux_status == 0) || (mux_status == gpio_cfg.func)))
+		return 0;
+
+	/* Set the pin sel value */
+	tmp = readl(pin_sel + pin_sel_reg);
+	tmp |= ((gpio_cfg.func & 0x3) << gpio_cfg.shift);
+	writel(tmp, pin_sel + pin_sel_reg);
+
+	return 0;
+}
+
+/* Perform minimal Titan GPIO configuration */
+static void titan_gpio_init(void)
+{
+	unsigned i;
+
+	for (i = 44; i < 48; i++) {
+		titan_gpio_pinsel(i);
+		ar7_gpio_enable_titan(i);
+		titan_gpio_direction_input(&titan_gpio_chip.chip, i);
+	}
+}
+
 int __init ar7_gpio_init(void)
 {
 	int ret;
+	struct ar7_gpio_chip *gpch;
+	unsigned size;
+
+	if (!ar7_is_titan()) {
+		gpch = &ar7_gpio_chip;
+		size = 0x10;
+	} else {
+		gpch = &titan_gpio_chip;
+		size = 0x1f;
+	}
 
-	ar7_gpio_chip.regs = ioremap_nocache(AR7_REGS_GPIO,
+	gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
 					AR7_REGS_GPIO + 0x10);
 
-	if (!ar7_gpio_chip.regs) {
-		printk(KERN_ERR "ar7-gpio: failed to ioremap regs\n");
+	if (!gpch->regs) {
+		printk(KERN_ERR "%s: failed to ioremap regs\n",
+					gpch->chip.label);
 		return -ENOMEM;
 	}
 
-	ret = gpiochip_add(&ar7_gpio_chip.chip);
+	ret = gpiochip_add(&gpch->chip);
 	if (ret) {
-		printk(KERN_ERR "ar7-gpio: failed to add gpiochip\n");
+		printk(KERN_ERR "%s: failed to add gpiochip\n",
+					gpch->chip.label);
 		return ret;
 	}
-	printk(KERN_INFO "ar7-gpio: registered %d GPIOs\n",
-				ar7_gpio_chip.chip.ngpio);
+	printk(KERN_INFO "%s: registered %d GPIOs\n",
+				gpch->chip.label, gpch->chip.ngpio);
+
+	if (ar7_is_titan())
+		titan_gpio_init();
+
 	return ret;
 }
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 0da5b2b..7d2fab3 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -357,6 +357,11 @@ static struct gpio_led default_leds[] = {
 	},
 };
 
+static struct gpio_led titan_leds[] = {
+	{ .name = "status", .gpio = 8, .active_low = 1, },
+	{ .name = "wifi", .gpio = 13, .active_low = 1, },
+};
+
 static struct gpio_led dsl502t_leds[] = {
 	{
 		.name			= "status",
@@ -495,6 +500,9 @@ static void __init detect_leds(void)
 	} else if (strstr(prid, "DG834")) {
 		ar7_led_data.num_leds = ARRAY_SIZE(dg834g_leds);
 		ar7_led_data.leds = dg834g_leds;
+	} else if (strstr(prid, "CYWM") || strstr(prid, "CYWL")) {
+		ar7_led_data.num_leds = ARRAY_SIZE(titan_leds);
+		ar7_led_data.leds = titan_leds;
 	}
 }
 
@@ -560,6 +568,51 @@ static int __init ar7_register_uarts(void)
 	return 0;
 }
 
+static void __init titan_fixup_devices(void)
+{
+	/* Set vlynq0 data */
+	vlynq_low_data.reset_bit = 15;
+	vlynq_low_data.gpio_bit = 14;
+
+	/* Set vlynq1 data */
+	vlynq_high_data.reset_bit = 16;
+	vlynq_high_data.gpio_bit = 7;
+
+	/* Set vlynq0 resources */
+	vlynq_low_res[0].start = TITAN_REGS_VLYNQ0;
+	vlynq_low_res[0].end = TITAN_REGS_VLYNQ0 + 0xff;
+	vlynq_low_res[1].start = 33;
+	vlynq_low_res[1].end = 33;
+	vlynq_low_res[2].start = 0x0c000000;
+	vlynq_low_res[2].end = 0x0fffffff;
+	vlynq_low_res[3].start = 80;
+	vlynq_low_res[3].end = 111;
+
+	/* Set vlynq1 resources */
+	vlynq_high_res[0].start = TITAN_REGS_VLYNQ1;
+	vlynq_high_res[0].end = TITAN_REGS_VLYNQ1 + 0xff;
+	vlynq_high_res[1].start = 34;
+	vlynq_high_res[1].end = 34;
+	vlynq_high_res[2].start = 0x40000000;
+	vlynq_high_res[2].end = 0x43ffffff;
+	vlynq_high_res[3].start = 112;
+	vlynq_high_res[3].end = 143;
+
+	/* Set cpmac0 data */
+	cpmac_low_data.phy_mask = 0x40000000;
+
+	/* Set cpmac1 data */
+	cpmac_high_data.phy_mask = 0x80000000;
+
+	/* Set cpmac0 resources */
+	cpmac_low_res[0].start = TITAN_REGS_MAC0;
+	cpmac_low_res[0].end = TITAN_REGS_MAC0 + 0x7ff;
+
+	/* Set cpmac1 resources */
+	cpmac_high_res[0].start = TITAN_REGS_MAC1;
+	cpmac_high_res[0].end = TITAN_REGS_MAC1 + 0x7ff;
+}
+
 static int __init ar7_register_devices(void)
 {
 	void __iomem *bootcr;
@@ -574,6 +627,9 @@ static int __init ar7_register_devices(void)
 	if (res)
 		pr_warning("unable to register physmap-flash: %d\n", res);
 
+	if (ar7_is_titan())
+		titan_fixup_devices();
+
 	ar7_device_disable(vlynq_low_data.reset_bit);
 	res = platform_device_register(&vlynq_low);
 	if (res)
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 3a801d2..f20b53e 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -23,6 +23,7 @@
 #include <asm/reboot.h>
 #include <asm/mach-ar7/ar7.h>
 #include <asm/mach-ar7/prom.h>
+#include <asm/mach-ar7/gpio.h>
 
 static void ar7_machine_restart(char *command)
 {
@@ -49,6 +50,8 @@ static void ar7_machine_power_off(void)
 const char *get_system_type(void)
 {
 	u16 chip_id = ar7_chip_id();
+	u16 titan_variant_id = titan_chip_id();
+
 	switch (chip_id) {
 	case AR7_CHIP_7100:
 		return "TI AR7 (TNETD7100)";
@@ -56,6 +59,17 @@ const char *get_system_type(void)
 		return "TI AR7 (TNETD7200)";
 	case AR7_CHIP_7300:
 		return "TI AR7 (TNETD7300)";
+	case AR7_CHIP_TITAN:
+		switch (titan_variant_id) {
+		case TITAN_CHIP_1050:
+			return "TI AR7 (TNETV1050)";
+		case TITAN_CHIP_1055:
+			return "TI AR7 (TNETV1055)";
+		case TITAN_CHIP_1056:
+			return "TI AR7 (TNETV1056)";
+		case TITAN_CHIP_1060:
+			return "TI AR7 (TNETV1060)";
+		}
 	default:
 		return "TI AR7 (unknown)";
 	}
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index ddb413e..7919d76 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -39,6 +39,7 @@
 #define AR7_REGS_UART0	(AR7_REGS_BASE + 0x0e00)
 #define AR7_REGS_USB	(AR7_REGS_BASE + 0x1200)
 #define AR7_REGS_RESET	(AR7_REGS_BASE + 0x1600)
+#define AR7_REGS_PINSEL (AR7_REGS_BASE + 0x160C)
 #define AR7_REGS_VLYNQ0	(AR7_REGS_BASE + 0x1800)
 #define AR7_REGS_DCL	(AR7_REGS_BASE + 0x1a00)
 #define AR7_REGS_VLYNQ1	(AR7_REGS_BASE + 0x1c00)
@@ -50,6 +51,14 @@
 #define UR8_REGS_WDT	(AR7_REGS_BASE + 0x0b00)
 #define UR8_REGS_UART1	(AR7_REGS_BASE + 0x0f00)
 
+/* Titan registers */
+#define TITAN_REGS_ESWITCH_BASE	(0x08640000)
+#define TITAN_REGS_MAC0		(TITAN_REGS_ESWITCH_BASE)
+#define TITAN_REGS_MAC1		(TITAN_REGS_ESWITCH_BASE + 0x0800)
+#define TITAN_REGS_MDIO		(TITAN_REGS_ESWITCH_BASE + 0x02000)
+#define TITAN_REGS_VLYNQ0	(AR7_REGS_BASE + 0x1c00)
+#define TITAN_REGS_VLYNQ1	(AR7_REGS_BASE + 0x1300)
+
 #define AR7_RESET_PERIPHERAL	0x0
 #define AR7_RESET_SOFTWARE	0x4
 #define AR7_RESET_STATUS	0x8
@@ -59,15 +68,30 @@
 #define AR7_RESET_BIT_MDIO	22
 #define AR7_RESET_BIT_EPHY	26
 
+#define TITAN_RESET_BIT_EPHY1	28
+
 /* GPIO control registers */
 #define AR7_GPIO_INPUT	0x0
 #define AR7_GPIO_OUTPUT	0x4
 #define AR7_GPIO_DIR	0x8
 #define AR7_GPIO_ENABLE	0xc
+#define TITAN_GPIO_INPUT_0	0x0
+#define TITAN_GPIO_INPUT_1	0x4
+#define TITAN_GPIO_OUTPUT_0	0x8
+#define TITAN_GPIO_OUTPUT_1	0xc
+#define TITAN_GPIO_DIR_0	0x10
+#define TITAN_GPIO_DIR_1	0x14
+#define TITAN_GPIO_ENBL_0	0x18
+#define TITAN_GPIO_ENBL_1	0x1c
 
 #define AR7_CHIP_7100	0x18
 #define AR7_CHIP_7200	0x2b
 #define AR7_CHIP_7300	0x05
+#define AR7_CHIP_TITAN	0x07
+#define TITAN_CHIP_1050	0x0f
+#define TITAN_CHIP_1055	0x0e
+#define TITAN_CHIP_1056	0x0d
+#define TITAN_CHIP_1060	0x07
 
 /* Interrupts */
 #define AR7_IRQ_UART0	15
@@ -95,14 +119,29 @@ struct plat_dsl_data {
 
 extern int ar7_cpu_clock, ar7_bus_clock, ar7_dsp_clock;
 
+static inline int ar7_is_titan(void)
+{
+	return (readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x24)) & 0xffff) ==
+		AR7_CHIP_TITAN;
+}
+
 static inline u16 ar7_chip_id(void)
 {
-	return readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x14)) & 0xffff;
+	return ar7_is_titan() ? AR7_CHIP_TITAN : (readl((void *)
+		KSEG1ADDR(AR7_REGS_GPIO + 0x14)) & 0xffff);
+}
+
+static inline u16 titan_chip_id(void)
+{
+	unsigned int val = readl((void *)KSEG1ADDR(AR7_REGS_GPIO +
+						TITAN_GPIO_INPUT_1));
+	return ((val >> 12) & 0x0f);
 }
 
 static inline u8 ar7_chip_rev(void)
 {
-	return (readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x14)) >> 16) & 0xff;
+	return (readl((void *)KSEG1ADDR(AR7_REGS_GPIO + (ar7_is_titan() ? 0x24 :
+		0x14))) >> 16) & 0xff;
 }
 
 struct clk {
@@ -163,4 +202,6 @@ static inline void ar7_device_off(u32 bit)
 
 int __init ar7_gpio_init(void);
 
+int __init ar7_gpio_init(void);
+
 #endif /* __AR7_H__ */
diff --git a/arch/mips/include/asm/mach-ar7/gpio.h b/arch/mips/include/asm/mach-ar7/gpio.h
index abc317c..c177cd1 100644
--- a/arch/mips/include/asm/mach-ar7/gpio.h
+++ b/arch/mips/include/asm/mach-ar7/gpio.h
@@ -22,7 +22,8 @@
 #include <asm/mach-ar7/ar7.h>
 
 #define AR7_GPIO_MAX 32
-#define NR_BUILTIN_GPIO AR7_GPIO_MAX
+#define TITAN_GPIO_MAX	51
+#define NR_BUILTIN_GPIO TITAN_GPIO_MAX
 
 #define gpio_to_irq(gpio)	-1
 
