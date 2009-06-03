Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 11:24:34 +0100 (WEST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:46057 "EHLO
	mail-bw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022592AbZFCKY0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 11:24:26 +0100
Received: by bwz25 with SMTP id 25so8907706bwz.0
        for <multiple recipients>; Wed, 03 Jun 2009 03:24:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4iW2pTT8EceXT7UmGOhuzxrgoiveGPq0MDrXV/6QIwM=;
        b=X1KwkQDI93FoV5voeZ9nCGgSsprhNVROOzMtEMKzC4kjreg6O4XdC98dvR9LC8Hfk6
         l9uwkHkbSW56d2ybQdFuq2ASbMMnT0sQMQPDqksGiyKTkm5ZZQvLeJ0TTT/0FctJ2KsQ
         EGkCfxVj2Yi68JzUQoRaotG2VoInb4RjAEeAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=BCrDdQKEglY71Q6ezChpdHS6edAsJrvHrDuTp6SGsZORKWh7RWVGHqKdCU8GWcgpYe
         FYBKVaRN8GV8igBMp3+N8OkBN+831JpWmK8+AHj1Oul6o4Gb6H04u2DNP3ZYKbx9Bhib
         pNCNztVcmhU9m62dMwRp85xKvlA6TAz+pheqA=
Received: by 10.204.59.14 with SMTP id j14mr750107bkh.39.1244024659930;
        Wed, 03 Jun 2009 03:24:19 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 35sm9800470fkt.50.2009.06.03.03.24.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 03:24:19 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Wed, 3 Jun 2009 12:24:16 +0200
Subject: [PATCH] bcm63xx: register gpiochip in prom
MIME-Version: 1.0
X-UID:	213
X-Length: 2676
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906031224.17368.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch moves the gpiochip registration
fro arch_initcall to prom. This allows GPIO-based
runtime board detection to be performed earlier.

Tested-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index b78d3fd..997fcaa 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -120,9 +120,8 @@ static struct gpio_chip bcm63xx_gpio_chip = {
 	.ngpio			= BCM63XX_GPIO_COUNT,
 };
 
-static int __init bcm63xx_gpio_init(void)
+int __init bcm63xx_gpio_init(void)
 {
 	printk(KERN_INFO "registering %d GPIOs\n", BCM63XX_GPIO_COUNT);
 	return gpiochip_add(&bcm63xx_gpio_chip);
 }
-arch_initcall(bcm63xx_gpio_init);
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index d97ceed..2cac966 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -13,6 +13,7 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
+#include <bcm63xx_gpio.h>
 
 void __init prom_init(void)
 {
@@ -40,6 +41,9 @@ void __init prom_init(void)
 
 	/* do low level board init */
 	board_prom_init();
+
+	/* register gpiochip */
+	bcm63xx_gpio_init();
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 72cee75..7f5d8e8 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -1,6 +1,10 @@
 #ifndef BCM63XX_GPIO_H
 #define BCM63XX_GPIO_H
 
+#include <linux/init.h>
+
+int __init bcm63xx_gpio_init(void);
+
 /* all helpers will BUG() if gpio count is >= 37. */
 #define BCM63XX_GPIO_COUNT	37
 
