Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:12:00 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:38604 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903851Ab1KPTLO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 20:11:14 +0100
Received: by mail-wy0-f177.google.com with SMTP id 21so1101328wyh.36
        for <multiple recipients>; Wed, 16 Nov 2011 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=2UJe9XRkhnbALt7n68K9+URx7tVHAl0ByrXy8kGJtFE=;
        b=AhQ3QVCWRa6jxXlsq/v5eI2VV7QPopuHdZ4BJv9Q1OZtrByWiX5TQ4ERN9qEpITiRM
         U4s1HeeTVhAUGiukOx5GJiWZO8p14kd3/F1V/rWQFfuvgMChD1KNClD8fYSKwEddqeK1
         1FQXw9FwS7u4+SO8tv3JzfA05UEr1f05CzKKU=
Received: by 10.227.207.201 with SMTP id fz9mr19619920wbb.25.1321470674111;
        Wed, 16 Nov 2011 11:11:14 -0800 (PST)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id e13sm27140734wbh.17.2011.11.16.11.11.12
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 11:11:13 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/3 v2] MIPS: BCM63xx: fix GPIO set/get for BCM6345
Date:   Wed, 16 Nov 2011 20:11:21 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-rc7-amd64; KDE/4.6.5; x86_64; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201111162011.21163.florian@openwrt.org>
X-archive-position: 31684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13735

On BCM6345, the register offsets for the set/get GPIO registers is wrong.
Use the same logic as the one present in arch/mips/bcm63xx/irq.c to
define the correct gpio_out_low_reg value when support for BCM6345
is compiled in.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- rebased against mips-for-linux-next
- use the same logic as the one present in arch/mips/bcm63xx/irq.c

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index f560fe7..a6c2135 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -4,7 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
- * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2008-2011 Florian Fainelli <florian@openwrt.org>
  */
 
 #include <linux/kernel.h>
@@ -18,6 +18,34 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
+#ifndef BCMCPU_RUNTIME_DETECT
+#define gpio_out_low_reg	GPIO_DATA_LO_REG
+#ifdef CONFIG_BCM63XX_CPU_6345
+#ifdef gpio_out_low_reg
+#undef gpio_out_low_reg
+#define gpio_out_low_reg	GPIO_DATA_LO_REG_6345
+#endif /* gpio_out_low_reg */
+#endif /* CONFIG_BCM63XX_CPU_6345 */
+
+static inline void bcm63xx_gpio_out_low_reg_init(void)
+{
+}
+#else /* ! BCMCPU_RUNTIME_DETECT */
+static u32 gpio_out_low_reg;
+
+static void bcm63xx_gpio_out_low_reg_init(void)
+{
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6345_CPU_ID:
+		gpio_out_low_reg = GPIO_DATA_LO_REG_6345;
+		break;
+	default:
+		gpio_out_low_reg = GPIO_DATA_LO_REG;
+		break;
+	}
+}
+#endif /* ! BCMCPU_RUNTIME_DETECT */
+
 static DEFINE_SPINLOCK(bcm63xx_gpio_lock);
 static u32 gpio_out_low, gpio_out_high;
 
@@ -33,7 +61,7 @@ static void bcm63xx_gpio_set(struct gpio_chip *chip,
 		BUG();
 
 	if (gpio < 32) {
-		reg = GPIO_DATA_LO_REG;
+		reg = gpio_out_low_reg;
 		mask = 1 << gpio;
 		v = &gpio_out_low;
 	} else {
@@ -60,7 +88,7 @@ static int bcm63xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
 		BUG();
 
 	if (gpio < 32) {
-		reg = GPIO_DATA_LO_REG;
+		reg = gpio_out_low_reg;
 		mask = 1 << gpio;
 	} else {
 		reg = GPIO_DATA_HI_REG;
@@ -125,8 +153,11 @@ static struct gpio_chip bcm63xx_gpio_chip = {
 
 int __init bcm63xx_gpio_init(void)
 {
-	gpio_out_low = bcm_gpio_readl(GPIO_DATA_LO_REG);
-	gpio_out_high = bcm_gpio_readl(GPIO_DATA_HI_REG);
+	bcm63xx_gpio_out_low_reg_init();
+
+	gpio_out_low = bcm_gpio_readl(gpio_out_low_reg);
+	if (!BCMCPU_IS_6345())
+		gpio_out_high = bcm_gpio_readl(GPIO_DATA_HI_REG);
 	bcm63xx_gpio_chip.ngpio = bcm63xx_gpio_count();
 	pr_info("registering %d GPIOs\n", bcm63xx_gpio_chip.ngpio);
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 6c9940f..94d4faa 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -437,6 +437,7 @@
 #define GPIO_CTL_LO_REG			0x4
 #define GPIO_DATA_HI_REG		0x8
 #define GPIO_DATA_LO_REG		0xC
+#define GPIO_DATA_LO_REG_6345		0x8
 
 /* GPIO mux registers and constants */
 #define GPIO_MODE_REG			0x18
-- 
1.7.5.4
