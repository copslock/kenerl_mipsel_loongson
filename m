Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2014 05:58:40 +0100 (CET)
Received: from SMTPBG220.QQ.COM ([183.60.2.223]:47564 "EHLO smtpbg220.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009149AbaL1E6ZZ3KGz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Dec 2014 05:58:25 +0100
X-QQ-mid: bizesmtp7t1419742663t268t012
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 28 Dec 2014 12:57:39 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH42B00B0000000
X-QQ-FEAT: wto48VEmSUFDm1qkc5woiPNxbUsXMYLmOR5riGQNnH9uj4EpVKH5vjsDZ6AFC
        QjJJDPhXNnFFXGO3sNrRGZJnS08llnDTTrsPMSRZf4if8TOAc88rx9zaEx8OjlW4dXex4ll
        JWUCACcsYt8w3mkZBnQys6/dqrQeFm0iv+iTMmB4bEsfHozEqgICiuNHkMYxsQLs6DEwxhs
        8Ih2wfnabnXcyQrcABAyAKKAiCShUzFRLCyCq306n4g==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-gpio@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 3/8] MIPS: Cleanup Loongson-2F's gpio driver
Date:   Sun, 28 Dec 2014 12:57:32 +0800
Message-Id: <1419742654-15094-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This cleanup is prepare to move the driver to drivers/gpio. Custom
definitions of gpio_get_value()/gpio_set_value() are dropped.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson/gpio.h |   15 +++---
 arch/mips/loongson/common/gpio.c           |   82 +++++++++++-----------------
 2 files changed, 39 insertions(+), 58 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/gpio.h b/arch/mips/include/asm/mach-loongson/gpio.h
index 211a7b7..b3b2169 100644
--- a/arch/mips/include/asm/mach-loongson/gpio.h
+++ b/arch/mips/include/asm/mach-loongson/gpio.h
@@ -1,8 +1,9 @@
 /*
- * STLS2F GPIO Support
+ * Loongson GPIO Support
  *
  * Copyright (c) 2008  Richard Liu, STMicroelectronics <richard.liu@st.com>
  * Copyright (c) 2008-2010  Arnaud Patard <apatard@mandriva.com>
+ * Copyright (c) 2014  Huacai Chen <chenhc@lemote.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -10,14 +11,14 @@
  * (at your option) any later version.
  */
 
-#ifndef __STLS2F_GPIO_H
-#define __STLS2F_GPIO_H
+#ifndef __LOONGSON_GPIO_H
+#define __LOONGSON_GPIO_H
 
 #include <asm-generic/gpio.h>
 
-extern void gpio_set_value(unsigned gpio, int value);
-extern int gpio_get_value(unsigned gpio);
-extern int gpio_cansleep(unsigned gpio);
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
+#define gpio_cansleep __gpio_cansleep
 
 /* The chip can do interrupt
  * but it has not been tested and doc not clear
@@ -32,4 +33,4 @@ static inline int irq_to_gpio(int gpio)
 	return -EINVAL;
 }
 
-#endif				/* __STLS2F_GPIO_H */
+#endif	/* __LOONGSON_GPIO_H */
diff --git a/arch/mips/loongson/common/gpio.c b/arch/mips/loongson/common/gpio.c
index 29dbaa2..087aac3 100644
--- a/arch/mips/loongson/common/gpio.c
+++ b/arch/mips/loongson/common/gpio.c
@@ -24,55 +24,6 @@
 
 static DEFINE_SPINLOCK(gpio_lock);
 
-int gpio_get_value(unsigned gpio)
-{
-	u32 val;
-	u32 mask;
-
-	if (gpio >= STLS2F_N_GPIO)
-		return __gpio_get_value(gpio);
-
-	mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
-	spin_lock(&gpio_lock);
-	val = LOONGSON_GPIODATA;
-	spin_unlock(&gpio_lock);
-
-	return (val & mask) != 0;
-}
-EXPORT_SYMBOL(gpio_get_value);
-
-void gpio_set_value(unsigned gpio, int state)
-{
-	u32 val;
-	u32 mask;
-
-	if (gpio >= STLS2F_N_GPIO) {
-		__gpio_set_value(gpio, state);
-		return ;
-	}
-
-	mask = 1 << gpio;
-
-	spin_lock(&gpio_lock);
-	val = LOONGSON_GPIODATA;
-	if (state)
-		val |= mask;
-	else
-		val &= (~mask);
-	LOONGSON_GPIODATA = val;
-	spin_unlock(&gpio_lock);
-}
-EXPORT_SYMBOL(gpio_set_value);
-
-int gpio_cansleep(unsigned gpio)
-{
-	if (gpio < STLS2F_N_GPIO)
-		return 0;
-	else
-		return __gpio_cansleep(gpio);
-}
-EXPORT_SYMBOL(gpio_cansleep);
-
 static int ls2f_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
 	u32 temp;
@@ -113,13 +64,41 @@ static int ls2f_gpio_direction_output(struct gpio_chip *chip,
 
 static int ls2f_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
-	return gpio_get_value(gpio);
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
+	return (val & mask) != 0;
 }
 
 static void ls2f_gpio_set_value(struct gpio_chip *chip,
 		unsigned gpio, int value)
 {
-	gpio_set_value(gpio, value);
+	u32 val;
+	u32 mask;
+
+	if (gpio >= STLS2F_N_GPIO) {
+		__gpio_set_value(gpio, value);
+		return;
+	}
+
+	mask = 1 << gpio;
+
+	spin_lock(&gpio_lock);
+	val = LOONGSON_GPIODATA;
+	if (value)
+		val |= mask;
+	else
+		val &= (~mask);
+	LOONGSON_GPIODATA = val;
+	spin_unlock(&gpio_lock);
 }
 
 static struct gpio_chip ls2f_chip = {
@@ -130,6 +109,7 @@ static struct gpio_chip ls2f_chip = {
 	.set			= ls2f_gpio_set_value,
 	.base			= 0,
 	.ngpio			= STLS2F_N_GPIO,
+	.can_sleep		= false,
 };
 
 static int __init ls2f_gpio_setup(void)
-- 
1.7.7.3
