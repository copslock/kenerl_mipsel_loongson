Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2011 16:06:20 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:53397 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904040Ab1KCPGO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Nov 2011 16:06:14 +0100
Received: by wwf27 with SMTP id 27so749522wwf.0
        for <multiple recipients>; Thu, 03 Nov 2011 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=89a/fQ8o6NK6VzBmQfMixbOkfA3BbOf+i+7rzDfQ5+U=;
        b=Un4f4cvCjQbEgq2dponbyM/70NeUieOMxjnJdDLd1emEk86CJfG1MUDWkOQFSmc80W
         ak96NBtIDMlh2IyCPirT6MxcsOtfO9GFJZCDpqUngIQyxGj6qiC4nqC30xNb8HcOOzal
         uCPDnGZGIg7Q9lszT79aIK89uHhTTt/r14Ibg=
Received: by 10.216.137.86 with SMTP id x64mr3107192wei.2.1320332768635;
        Thu, 03 Nov 2011 08:06:08 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id eu16sm10684146wbb.7.2011.11.03.08.06.06
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 08:06:07 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47xxx: fix build with GENERIC_GPIO configuration
Date:   Thu, 03 Nov 2011 16:05:49 +0100
Message-ID: <2526064.yKTpR1Kdyv@flexo>
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-server; KDE/4.7.2; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 31370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2649

Since eb9ae7f2 (gpio: fix build error in include/asm-generic/gpio.h)
the generic version of gpio.h calls __gpio_{set,get}_value which we
do not define. Get rid of asm-generic/gpio.h and define the missing
stubs directly for BCM47xx to build.

Reported-by: Ralf Baechle <ralf@linux-mips.org>
CC: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
index 76961ca..26cc815 100644
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
+	return gpio < (BCM47XX_EXTIF_GPIO_LINES + BCM47XX_EXTIF_GPIO_LINES);
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
