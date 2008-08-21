Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 23:15:20 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:30115 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28586956AbYHUWO5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 23:14:57 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id D5DC7FE2E23;
	Fri, 22 Aug 2008 00:14:51 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id BACE13F008A;
	Fri, 22 Aug 2008 00:14:28 +0200 (CEST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 8CB4C90004;
	Fri, 22 Aug 2008 00:14:28 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 00:14:27 +0200
Subject: [PATCH 2/6] rb532: use physical addresses for gpio and device controller registers
MIME-Version: 1.0
X-UID:	1118
X-Length: 2606
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808220014.27497.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: BACE13F008A.E0055
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the misuse of virtual address which would lead to
serious problems while accessing ioremap'd registers in the GPIO
code.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 00a1c78..3d1632c 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -47,8 +47,8 @@ struct mpmc_device dev3;
 static struct resource rb532_gpio_reg0_res[] = {
 	{
 		.name 	= "gpio_reg0",
-		.start 	= (u32)(IDT434_REG_BASE + GPIOBASE),
-		.end 	= (u32)(IDT434_REG_BASE + GPIOBASE + sizeof(struct rb532_gpio_reg)),
+		.start 	= (REG_BASE + GPIOBASE),
+		.end 	= (REG_BASE + GPIOBASE + sizeof(struct rb532_gpio_reg)),
 		.flags 	= IORESOURCE_MEM,
 	}
 };
@@ -56,8 +56,8 @@ static struct resource rb532_gpio_reg0_res[] = {
 static struct resource rb532_dev3_ctl_res[] = {
 	{
 		.name	= "dev3_ctl",
-		.start	= (u32)(IDT434_REG_BASE + DEV3BASE),
-		.end	= (u32)(IDT434_REG_BASE + DEV3BASE + sizeof(struct dev_reg)),
+		.start	= (REG_BASE + DEV3BASE),
+		.end	= (REG_BASE + DEV3BASE + sizeof(struct dev_reg)),
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/include/asm-mips/mach-rc32434/rb.h b/include/asm-mips/mach-rc32434/rb.h
index e0a76e3..f229da4 100644
--- a/include/asm-mips/mach-rc32434/rb.h
+++ b/include/asm-mips/mach-rc32434/rb.h
@@ -18,6 +18,7 @@
 #include <linux/genhd.h>
 
 #define IDT434_REG_BASE	((volatile void *) KSEG1ADDR(0x18000000))
+#define REG_BASE	0x18000000
 #define DEV0BASE	0x010000
 #define DEV0MASK	0x010004
 #define DEV0C		0x010008
@@ -43,6 +44,7 @@
 #define GPIOISTAT	0x050010
 #define GPIONMIEN	0x050014
 #define IMASK6		0x038038
+
 #define LO_WPX		(1 << 0)
 #define LO_ALE		(1 << 1)
 #define LO_CLE		(1 << 2)
