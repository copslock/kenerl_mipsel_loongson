Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 23:27:38 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.148]:30356 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1493430AbZKWW1e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 23:27:34 +0100
Received: by ey-out-1920.google.com with SMTP id 26so1375775eyw.52
        for <linux-mips@linux-mips.org>; Mon, 23 Nov 2009 14:27:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ClS22dBhq8NDhl8UjpcwHo3mnClXSeAqsW75vaFFhxw=;
        b=QJdXx2j4Nd0W+pus51p4SKJCBHJ51NTqt8u/6wa+LlFuNS8w7uVtJqeP9HpWI1TGp7
         vU+1BQp6f//yecEbfYAXUFZBExX6sO/3i6yEMwoKv7hQ/eLefVfkcoF5qRTTtLunKyUg
         nl2MYyzjoLeUv/4oGq/+HphAl6IEQHIQ5+1EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SiM0XY07Qp32u/sO5vdQD8SxgUDlDijh+UvIk526uIF3O0bgMEtF/snElsr7CbH3jH
         zpSQq0Z5XwT3y1AipCjZcIRSa0+YsCXahOUqDGkU7k5B5w8Iper4WGAHSO48c1GDBs6p
         kWYL0d2rlNy6fo7djVTkimp060fIVZOXguVtU=
Received: by 10.216.85.69 with SMTP id t47mr1738895wee.107.1259005193289;
        Mon, 23 Nov 2009 11:39:53 -0800 (PST)
Received: from localhost.localdomain (p5496D521.dip.t-dialin.net [84.150.213.33])
        by mx.google.com with ESMTPS id g11sm10270817gve.3.2009.11.23.11.39.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 11:39:52 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mlau@msc-ge.com>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/3] MIPS: Alchemy: use runtime cpu detection in GPIO code.
Date:	Mon, 23 Nov 2009 20:40:00 +0100
Message-Id: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mlau@msc-ge.com>

Remove the cpu subtype cpp macros in favor of runtime detection,
to improve compile coverage of the alchemy common code.
(Increases kernel size by 700 bytes).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/gpiolib-au1000.c       |   10 +--
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   90 ++++++++++++-----------
 2 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/arch/mips/alchemy/common/gpiolib-au1000.c b/arch/mips/alchemy/common/gpiolib-au1000.c
index 1bfa91f..c8e1a94 100644
--- a/arch/mips/alchemy/common/gpiolib-au1000.c
+++ b/arch/mips/alchemy/common/gpiolib-au1000.c
@@ -36,7 +36,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/gpio.h>
 
-#if !defined(CONFIG_SOC_AU1000)
 static int gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
 	return alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
@@ -63,7 +62,7 @@ static int gpio2_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	return alchemy_gpio2_to_irq(offset + ALCHEMY_GPIO2_BASE);
 }
-#endif /* !defined(CONFIG_SOC_AU1000) */
+
 
 static int gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
@@ -104,7 +103,6 @@ struct gpio_chip alchemy_gpio_chip[] = {
 		.base			= ALCHEMY_GPIO1_BASE,
 		.ngpio			= ALCHEMY_GPIO1_NUM,
 	},
-#if !defined(CONFIG_SOC_AU1000)
 	[1] = {
 		.label                  = "alchemy-gpio2",
 		.direction_input        = gpio2_direction_input,
@@ -115,15 +113,13 @@ struct gpio_chip alchemy_gpio_chip[] = {
 		.base                   = ALCHEMY_GPIO2_BASE,
 		.ngpio                  = ALCHEMY_GPIO2_NUM,
 	},
-#endif
 };
 
 static int __init alchemy_gpiolib_init(void)
 {
 	gpiochip_add(&alchemy_gpio_chip[0]);
-#if !defined(CONFIG_SOC_AU1000)
-	gpiochip_add(&alchemy_gpio_chip[1]);
-#endif
+	if (alchemy_get_cputype() != ALCHEMY_CPU_AU1000)
+		gpiochip_add(&alchemy_gpio_chip[1]);
 
 	return 0;
 }
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 9cf32d9..62d2f13 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -236,19 +236,19 @@ static inline int alchemy_gpio1_is_valid(int gpio)
 
 static inline int alchemy_gpio1_to_irq(int gpio)
 {
-#if defined(CONFIG_SOC_AU1000)
-	return au1000_gpio1_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1100)
-	return au1100_gpio1_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1500)
-	return au1500_gpio1_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1550)
-	return au1550_gpio1_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1200)
-	return au1200_gpio1_to_irq(gpio);
-#else
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+		return au1000_gpio1_to_irq(gpio);
+	case ALCHEMY_CPU_AU1100:
+		return au1100_gpio1_to_irq(gpio);
+	case ALCHEMY_CPU_AU1500:
+		return au1500_gpio1_to_irq(gpio);
+	case ALCHEMY_CPU_AU1550:
+		return au1550_gpio1_to_irq(gpio);
+	case ALCHEMY_CPU_AU1200:
+		return au1200_gpio1_to_irq(gpio);
+	}
 	return -ENXIO;
-#endif
 }
 
 /*
@@ -306,19 +306,19 @@ static inline int alchemy_gpio2_is_valid(int gpio)
 
 static inline int alchemy_gpio2_to_irq(int gpio)
 {
-#if defined(CONFIG_SOC_AU1000)
-	return au1000_gpio2_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1100)
-	return au1100_gpio2_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1500)
-	return au1500_gpio2_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1550)
-	return au1550_gpio2_to_irq(gpio);
-#elif defined(CONFIG_SOC_AU1200)
-	return au1200_gpio2_to_irq(gpio);
-#else
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+		return au1000_gpio2_to_irq(gpio);
+	case ALCHEMY_CPU_AU1100:
+		return au1100_gpio2_to_irq(gpio);
+	case ALCHEMY_CPU_AU1500:
+		return au1500_gpio2_to_irq(gpio);
+	case ALCHEMY_CPU_AU1550:
+		return au1550_gpio2_to_irq(gpio);
+	case ALCHEMY_CPU_AU1200:
+		return au1200_gpio2_to_irq(gpio);
+	}
 	return -ENXIO;
-#endif
 }
 
 /**********************************************************************/
@@ -374,10 +374,13 @@ static inline void alchemy_gpio2_enable_int(int gpio2)
 
 	gpio2 -= ALCHEMY_GPIO2_BASE;
 
-#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
 	/* Au1100/Au1500 have GPIO208-215 enable bits at 0..7 */
-	gpio2 -= 8;
-#endif
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1100:
+	case ALCHEMY_CPU_AU1500:
+		gpio2 -= 8;
+	}
+
 	local_irq_save(flags);
 	__alchemy_gpio2_mod_int(gpio2, 1);
 	local_irq_restore(flags);
@@ -395,10 +398,13 @@ static inline void alchemy_gpio2_disable_int(int gpio2)
 
 	gpio2 -= ALCHEMY_GPIO2_BASE;
 
-#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
 	/* Au1100/Au1500 have GPIO208-215 enable bits at 0..7 */
-	gpio2 -= 8;
-#endif
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1100:
+	case ALCHEMY_CPU_AU1500:
+		gpio2 -= 8;
+	}
+
 	local_irq_save(flags);
 	__alchemy_gpio2_mod_int(gpio2, 0);
 	local_irq_restore(flags);
@@ -484,19 +490,19 @@ static inline int alchemy_gpio_to_irq(int gpio)
 
 static inline int alchemy_irq_to_gpio(int irq)
 {
-#if defined(CONFIG_SOC_AU1000)
-	return au1000_irq_to_gpio(irq);
-#elif defined(CONFIG_SOC_AU1100)
-	return au1100_irq_to_gpio(irq);
-#elif defined(CONFIG_SOC_AU1500)
-	return au1500_irq_to_gpio(irq);
-#elif defined(CONFIG_SOC_AU1550)
-	return au1550_irq_to_gpio(irq);
-#elif defined(CONFIG_SOC_AU1200)
-	return au1200_irq_to_gpio(irq);
-#else
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+		return au1000_irq_to_gpio(irq);
+	case ALCHEMY_CPU_AU1100:
+		return au1100_irq_to_gpio(irq);
+	case ALCHEMY_CPU_AU1500:
+		return au1500_irq_to_gpio(irq);
+	case ALCHEMY_CPU_AU1550:
+		return au1550_irq_to_gpio(irq);
+	case ALCHEMY_CPU_AU1200:
+		return au1200_irq_to_gpio(irq);
+	}
 	return -ENXIO;
-#endif
 }
 
 /**********************************************************************/
-- 
1.6.5.3
