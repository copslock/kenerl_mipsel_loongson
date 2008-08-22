Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 16:01:27 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:13526 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20034650AbYHVPBV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Aug 2008 16:01:21 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id C0652FE2EE0;
	Fri, 22 Aug 2008 17:01:20 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id AB9FE3ED426;
	Fri, 22 Aug 2008 17:01:06 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id AF26C90004;
	Fri, 22 Aug 2008 17:01:06 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 17:01:03 +0200
Subject: [PATCH 2/5] rb532: use physical addresses for gpio and device controller registers
MIME-Version: 1.0
X-UID:	1139
X-Length: 2499
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808221701.03810.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: AB9FE3ED426.B36A9
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the misuse of virtual addresses for the GPIO and third
device controller which would lead to problems while accessing ioremap'd
registers.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 00a1c78..0628d8d 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -47,8 +47,8 @@ struct mpmc_device dev3;
 static struct resource rb532_gpio_reg0_res[] = {
 	{
 		.name 	= "gpio_reg0",
-		.start 	= (u32)(IDT434_REG_BASE + GPIOBASE),
-		.end 	= (u32)(IDT434_REG_BASE + GPIOBASE + sizeof(struct rb532_gpio_reg)),
+		.start 	= REGBASE + GPIOBASE,
+		.end 	= REGBASE + GPIOBASE + sizeof(struct rb532_gpio_reg) -1,
 		.flags 	= IORESOURCE_MEM,
 	}
 };
@@ -56,8 +56,8 @@ static struct resource rb532_gpio_reg0_res[] = {
 static struct resource rb532_dev3_ctl_res[] = {
 	{
 		.name	= "dev3_ctl",
-		.start	= (u32)(IDT434_REG_BASE + DEV3BASE),
-		.end	= (u32)(IDT434_REG_BASE + DEV3BASE + sizeof(struct dev_reg)),
+		.start	= REGBASE + DEV3BASE,
+		.end	= REGBASE + DEV3BASE + sizeof(struct dev_reg) -1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/include/asm-mips/mach-rc32434/rb.h b/include/asm-mips/mach-rc32434/rb.h
index e0a76e3..62ac73c 100644
--- a/include/asm-mips/mach-rc32434/rb.h
+++ b/include/asm-mips/mach-rc32434/rb.h
@@ -17,7 +17,8 @@
 
 #include <linux/genhd.h>
 
-#define IDT434_REG_BASE	((volatile void *) KSEG1ADDR(0x18000000))
+#define REGBASE		0x18000000
+#define IDT434_REG_BASE	((volatile void *) KSEG1ADDR(REGBASE))
 #define DEV0BASE	0x010000
 #define DEV0MASK	0x010004
 #define DEV0C		0x010008
