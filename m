Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 11:18:15 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:52987 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904080Ab1KDKSJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2011 11:18:09 +0100
Received: by wwf4 with SMTP id 4so2679916wwf.24
        for <multiple recipients>; Fri, 04 Nov 2011 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:message-id:organization:user-agent
         :mime-version:content-transfer-encoding:content-type;
        bh=mXJ3YdfJ+5VNsFCYSPZBZ5fAJKRWW2UKTl75+crbYFM=;
        b=F2kmZRgdl4+gJm6KtcSyUkrvRqQMeDO39YMzYKSNKLozUQ6VvPn4JdjnfoZtIE8ep3
         dQcq4ioaLbIeukAwhS3Oyo6CojnjlnANu+Co1ixRzlXLpSCXy7wbz07sMYY5VjApJRnL
         VCBeXv8vTt+cr3WxbgrzxR1bFi7OQAZnwczbU=
Received: by 10.227.205.2 with SMTP id fo2mr17033437wbb.21.1320401883652;
        Fri, 04 Nov 2011 03:18:03 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id fw16sm15154126wbb.13.2011.11.04.03.18.01
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 03:18:02 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org, hauke@hauke-m.de
Subject: [PATCH v2] MIPS: BCM47xx: fix build with GENERIC_GPIO configuration
Date:   Fri, 04 Nov 2011 11:17:46 +0100
Message-ID: <1536404.fxng9lJsi6@flexo>
Organization: OpenWrt
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-server; KDE/4.7.2; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 31377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3456

Since eb9ae7f2 (gpio: fix build error in include/asm-generic/gpio.h)
the generic version of gpio.h calls __gpio_{set,get}_value which we
do not define. Get rid of asm-generic/gpio.h and define the missing
stubs directly for BCM47xx to build.

Reported-by: Ralf Baechle <ralf@linux-mips.org>
CC: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2:
- fixed the subject (BCM47xxx -> BCM47xx)
- fixed gpio_is_valid to check for the proper gpio number

diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
index 76961ca..2ef17e8 100644
--- a/arch/mips/include/asm/mach-bcm47xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm47xx/gpio.h
@@ -36,6 +36,8 @@ static inline int gpio_get_value(unsigned gpio)
 	return -EINVAL;
 }
 
+#define gpio_get_value_cansleep	gpio_get_value
+
 static inline void gpio_set_value(unsigned gpio, int value)
 {
 	switch (bcm47xx_bus_type) {
@@ -54,6 +56,19 @@ static inline void gpio_set_value(unsigned gpio, int value)
 	}
 }
 
+#define gpio_set_value_cansleep gpio_set_value
+
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return 0;
+}
+
+static inline int gpio_is_valid(unsigned gpio)
+{
+	return gpio < (BCM47XX_EXTIF_GPIO_LINES + BCM47XX_CHIPCO_GPIO_LINES);
+}
+
+
 static inline int gpio_direction_input(unsigned gpio)
 {
 	switch (bcm47xx_bus_type) {
@@ -137,7 +152,4 @@ static inline int gpio_polarity(unsigned gpio, int value)
 }
 
 
-/* cansleep wrappers */
-#include <asm-generic/gpio.h>
-
 #endif /* __BCM47XX_GPIO_H */
-- 
1.7.5.4
