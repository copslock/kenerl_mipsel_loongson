Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:15:51 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37595 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010964AbaKDGO1rZl6- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:27 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so13052835pdj.33
        for <multiple recipients>; Mon, 03 Nov 2014 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rbZTvygnP9v9VvArMxQyoEA0t5WbOyVHFbggEXSLnM4=;
        b=Es+AV6XZSZGcTQbrl3h4+MAXAkj/kO9sz4mupmdT4wVgizpwfDAtGS5WPEmAGt6G6y
         3HqTw60HAJ0EBCnmRtFuyq3iUa1AIz+2kDJx2vh7Mn9+gRdcn0XSWjZ0fiMkiuLD7RrU
         JAFkMI5JQsqQHishqvhHNYKKuTwQkJigUQetO8fol9onwyfOTGe/oCGpr6JeIhMJF61l
         LEbbvaNdFiVnJDJod8qg4UAoJweqKNeBathge9+y5J7ApjVn2nlzmuvF3O1kJQiAh07s
         f6wz4lOrdQzj5JYQU0C6w1jnaSBmCpO4zB66n0G/AblkSwgaap03IMxR5c/DGcGZQp17
         QJHA==
X-Received: by 10.66.253.164 with SMTP id ab4mr47804888pad.59.1415081661122;
        Mon, 03 Nov 2014 22:14:21 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.14.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:14:20 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, Hongbing Hu <huhb@lemote.com>
Subject: [PATCH V2 07/12] MIPS: Loongson: Add Loongson-3A/3B GPIO support
Date:   Tue,  4 Nov 2014 14:13:28 +0800
Message-Id: <1415081610-25639-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43856
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongbing Hu <huhb@lemote.com>
---
 arch/mips/Kconfig                |    1 +
 arch/mips/loongson/common/gpio.c |   53 ++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3dc152..2a488f4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1198,6 +1198,7 @@ config CPU_LOONGSON3
 	select CPU_SUPPORTS_HUGEPAGES
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
+	select ARCH_REQUIRE_GPIOLIB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
diff --git a/arch/mips/loongson/common/gpio.c b/arch/mips/loongson/common/gpio.c
index 29dbaa2..ecc828a 100644
--- a/arch/mips/loongson/common/gpio.c
+++ b/arch/mips/loongson/common/gpio.c
@@ -1,8 +1,9 @@
 /*
- *  STLS2F GPIO Support
+ *  Loongson-2F/3A/3B GPIO Support
  *
  *  Copyright (c) 2008 Richard Liu,  STMicroelectronics	 <richard.liu@st.com>
  *  Copyright (c) 2008-2010 Arnaud Patard <apatard@mandriva.com>
+ *  Copyright (c) 2014 Huacai Chen <chenhc@lemote.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -20,7 +21,15 @@
 #include <linux/gpio.h>
 
 #define STLS2F_N_GPIO		4
-#define STLS2F_GPIO_IN_OFFSET	16
+#define STLS3A_N_GPIO		16
+
+#ifdef CONFIG_CPU_LOONGSON3
+#define LOONGSON_N_GPIO	STLS3A_N_GPIO
+#else
+#define LOONGSON_N_GPIO	STLS2F_N_GPIO
+#endif
+
+#define LOONGSON_GPIO_IN_OFFSET	16
 
 static DEFINE_SPINLOCK(gpio_lock);
 
@@ -29,10 +38,10 @@ int gpio_get_value(unsigned gpio)
 	u32 val;
 	u32 mask;
 
-	if (gpio >= STLS2F_N_GPIO)
+	if (gpio >= LOONGSON_N_GPIO)
 		return __gpio_get_value(gpio);
 
-	mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
+	mask = 1 << (gpio + LOONGSON_GPIO_IN_OFFSET);
 	spin_lock(&gpio_lock);
 	val = LOONGSON_GPIODATA;
 	spin_unlock(&gpio_lock);
@@ -46,7 +55,7 @@ void gpio_set_value(unsigned gpio, int state)
 	u32 val;
 	u32 mask;
 
-	if (gpio >= STLS2F_N_GPIO) {
+	if (gpio >= LOONGSON_N_GPIO) {
 		__gpio_set_value(gpio, state);
 		return ;
 	}
@@ -66,19 +75,19 @@ EXPORT_SYMBOL(gpio_set_value);
 
 int gpio_cansleep(unsigned gpio)
 {
-	if (gpio < STLS2F_N_GPIO)
+	if (gpio < LOONGSON_N_GPIO)
 		return 0;
 	else
 		return __gpio_cansleep(gpio);
 }
 EXPORT_SYMBOL(gpio_cansleep);
 
-static int ls2f_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+static int loongson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
 	u32 temp;
 	u32 mask;
 
-	if (gpio >= STLS2F_N_GPIO)
+	if (gpio >= LOONGSON_N_GPIO)
 		return -EINVAL;
 
 	spin_lock(&gpio_lock);
@@ -91,13 +100,13 @@ static int ls2f_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 	return 0;
 }
 
-static int ls2f_gpio_direction_output(struct gpio_chip *chip,
+static int loongson_gpio_direction_output(struct gpio_chip *chip,
 		unsigned gpio, int level)
 {
 	u32 temp;
 	u32 mask;
 
-	if (gpio >= STLS2F_N_GPIO)
+	if (gpio >= LOONGSON_N_GPIO)
 		return -EINVAL;
 
 	gpio_set_value(gpio, level);
@@ -111,29 +120,29 @@ static int ls2f_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int ls2f_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+static int loongson_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
 	return gpio_get_value(gpio);
 }
 
-static void ls2f_gpio_set_value(struct gpio_chip *chip,
+static void loongson_gpio_set_value(struct gpio_chip *chip,
 		unsigned gpio, int value)
 {
 	gpio_set_value(gpio, value);
 }
 
-static struct gpio_chip ls2f_chip = {
-	.label			= "ls2f",
-	.direction_input	= ls2f_gpio_direction_input,
-	.get			= ls2f_gpio_get_value,
-	.direction_output	= ls2f_gpio_direction_output,
-	.set			= ls2f_gpio_set_value,
+static struct gpio_chip loongson_chip = {
+	.label                  = "Loongson-gpio-chip",
+	.direction_input        = loongson_gpio_direction_input,
+	.get                    = loongson_gpio_get_value,
+	.direction_output       = loongson_gpio_direction_output,
+	.set                    = loongson_gpio_set_value,
 	.base			= 0,
-	.ngpio			= STLS2F_N_GPIO,
+	.ngpio                  = LOONGSON_N_GPIO,
 };
 
-static int __init ls2f_gpio_setup(void)
+static int __init loongson_gpio_setup(void)
 {
-	return gpiochip_add(&ls2f_chip);
+	return gpiochip_add(&loongson_chip);
 }
-arch_initcall(ls2f_gpio_setup);
+arch_initcall(loongson_gpio_setup);
-- 
1.7.7.3
