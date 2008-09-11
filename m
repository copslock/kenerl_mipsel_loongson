Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 16:48:55 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:27524 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20190773AbYIKPst (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 16:48:49 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id AA990FE2059;
	Thu, 11 Sep 2008 17:48:43 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 52D193F0534;
	Thu, 11 Sep 2008 17:48:14 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 422E5900EC;
	Thu, 11 Sep 2008 17:48:14 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 11 Sep 2008 17:48:00 +0200
Subject: [PATCH] rb532: provide GPIO_BUILTIN_NR and irq_to_gpio/gpio_to_irq
MIME-Version: 1.0
X-UID:	1204
X-Length: 1874
To:	ralf@linux-mips.org
Cc:	Linux MIPS Org <linux-mips@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809111748.00822.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 52D193F0534.3F226
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patchs defines the number of built-in the GPIOs present
on the SoC as Documentation/gpio.txt recommends to do.
Define irq_to_gpio/gpio_to_irq to return the right values so that
it fixes a compilation error on drivers/gpio/gpiolib.c
when enabling debugfs.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
index 77ac353..ff40eab 100644
--- a/include/asm-mips/mach-rc32434/gpio.h
+++ b/include/asm-mips/mach-rc32434/gpio.h
@@ -14,16 +14,16 @@
 #define _RC32434_GPIO_H_
 
 #include <linux/types.h>
+#include <asm-generic/gpio.h>
 
-#define gpio_get_value __gpio_get_value
-#define gpio_set_value __gpio_set_value
-
-#define gpio_cansleep __gpio_cansleep
+#define NR_BUILTIN_GPIO		32
 
-#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
-#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
 
-#include <asm-generic/gpio.h>
+#define gpio_to_irq(gpio)	(8 + 4 * 32 + gpio)
+#define irq_to_gpio(irq)	(irq - (8 + 4 * 32))
 
 struct rb532_gpio_reg {
 	u32   gpiofunc;   /* GPIO Function Register
