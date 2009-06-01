Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:18:30 +0100 (WEST)
Received: from ey-out-1920.google.com ([74.125.78.147]:1830 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024974AbZFASSX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:18:23 +0100
Received: by ey-out-1920.google.com with SMTP id 4so447731eyg.54
        for <multiple recipients>; Mon, 01 Jun 2009 11:18:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m56wAg5f+dgcT5ijhh4gbrRbAEvtw19GKvR07MrEU4k=;
        b=kkhR1CTGCmcCpPbS7QkwHDsPqeXdmUl9LDaM4t/apgSJFk7BT772IKx9BAGj60Qmdw
         vBdZBtX84ZV+izHXqjCzo9x8tuPuwUW+Kzyhv0q3Rw9QfbdYvBaLx0y2T6ZJ7HjLPgVc
         r4NhyFFTcahHqDfsc5egozjw8WiQ4Dt9YE9bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=MIXIhn/MdxFKfD0LH+bC76te8iNa3YT0ELaW6cBkFUHhE30uAINt7CQl45htUNhWUc
         IdAC8Sn+Uic79se+L7yNlcuv67hc6khfkFaNfPNoWuHMFDXX7ZRuZOYmaIvqLWof4iUL
         0kxFlhnHtyolmT4pm2nv8i1T1GCwRjv53en7g=
Received: by 10.210.39.2 with SMTP id m2mr1474225ebm.82.1243880302954;
        Mon, 01 Jun 2009 11:18:22 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm62967eyg.44.2009.06.01.11.18.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:18:22 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 20:18:20 +0200
Subject: [PATCH 3/3] bcm63xx: early registering of gpiochip
MIME-Version: 1.0
X-UID:	195
X-Length: 2651
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906012018.20972.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the gpiochip be registered
earlier in the prom code. This allows GPIO-based
board detection to be made earlier.

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
index d97ceed..1e5bb15 100644
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
+	/* early register gpio */
+	bcm63xx_gpio_init();
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 72cee75..8bc812f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -1,6 +1,8 @@
 #ifndef BCM63XX_GPIO_H
 #define BCM63XX_GPIO_H
 
+int __init bcm63xx_gpio_init(void);
+
 /* all helpers will BUG() if gpio count is >= 37. */
 #define BCM63XX_GPIO_COUNT	37
 
