Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 16:00:57 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:30089 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20034631AbYHVPAt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Aug 2008 16:00:49 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id E277AFE2EE0;
	Fri, 22 Aug 2008 17:00:43 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id BF72A3ED468;
	Fri, 22 Aug 2008 17:00:25 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id B14DE90004;
	Fri, 22 Aug 2008 17:00:25 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 17:00:22 +0200
Subject: [PATCH 1/5] rb532: cleanup and group definitions to their right places
MIME-Version: 1.0
X-UID:	1138
X-Length: 3576
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808221700.22440.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: BF72A3ED468.4397A
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch moves GPIO related definitions to gpio.h and IRQ
related to irq.h

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 82ab395..7090dc9 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -34,21 +34,11 @@
 #include <asm/mach-rc32434/rb.h>
 #include <asm/mach-rc32434/integ.h>
 #include <asm/mach-rc32434/gpio.h>
-
-#define ETH0_DMA_RX_IRQ   	(GROUP1_IRQ_BASE + 0)
-#define ETH0_DMA_TX_IRQ   	(GROUP1_IRQ_BASE + 1)
-#define ETH0_RX_OVR_IRQ   	(GROUP3_IRQ_BASE + 9)
-#define ETH0_TX_UND_IRQ   	(GROUP3_IRQ_BASE + 10)
+#include <asm/mach-rc32434/irq.h>
 
 #define ETH0_RX_DMA_ADDR  (DMA0_BASE_ADDR + 0 * DMA_CHAN_OFFSET)
 #define ETH0_TX_DMA_ADDR  (DMA0_BASE_ADDR + 1 * DMA_CHAN_OFFSET)
 
-/* NAND definitions */
-#define GPIO_RDY (1 << 0x08)
-#define GPIO_WPX (1 << 0x09)
-#define GPIO_ALE (1 << 0x0a)
-#define GPIO_CLE (1 << 0x0b)
-
 static struct resource korina_dev0_res[] = {
 	{
 		.name = "korina_regs",
@@ -101,8 +91,6 @@ static struct platform_device korina_dev0 = {
 	.num_resources = ARRAY_SIZE(korina_dev0_res),
 };
 
-#define CF_GPIO_NUM 13
-
 static struct resource cf_slot0_res[] = {
 	{
 		.name = "cf_membase",
@@ -116,7 +104,7 @@ static struct resource cf_slot0_res[] = {
 };
 
 static struct cf_device cf_slot0_data = {
-	.gpio_pin = 13
+	.gpio_pin = CF_GPIO_NUM
 };
 
 static struct platform_device cf_slot0 = {
diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
index f946f5f..4fe18db 100644
--- a/include/asm-mips/mach-rc32434/gpio.h
+++ b/include/asm-mips/mach-rc32434/gpio.h
@@ -61,6 +61,15 @@ struct rb532_gpio_reg {
 /* PCI messaging unit */
 #define RC32434_PCI_MSU_GPIO	(1 << 13)
 
+/* NAND GPIO signals */
+#define GPIO_RDY		(1 << 0x08)
+#define GPIO_WPX		(1 << 0x09)
+#define GPIO_ALE		(1 << 0x0a)
+#define GPIO_CLE		(1 << 0x0b)
+
+/* Compact Flash GPIO pin */
+#define CF_GPIO_NUM		13
+
 
 extern void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val);
 extern unsigned get_434_reg(unsigned reg_offs);
diff --git a/include/asm-mips/mach-rc32434/irq.h b/include/asm-mips/mach-rc32434/irq.h
index cb9e472..d68318b 100644
--- a/include/asm-mips/mach-rc32434/irq.h
+++ b/include/asm-mips/mach-rc32434/irq.h
@@ -5,4 +5,9 @@
 
 #include <asm/mach-generic/irq.h>
 
+#define ETH0_DMA_RX_IRQ   	(GROUP1_IRQ_BASE + 0)
+#define ETH0_DMA_TX_IRQ   	(GROUP1_IRQ_BASE + 1)
+#define ETH0_RX_OVR_IRQ   	(GROUP3_IRQ_BASE + 9)
+#define ETH0_TX_UND_IRQ   	(GROUP3_IRQ_BASE + 10)
+
 #endif  /* __ASM_RC32434_IRQ_H */
