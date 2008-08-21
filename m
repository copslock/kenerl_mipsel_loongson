Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 12:04:54 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:39400 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20031613AbYHULEs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 12:04:48 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 3466AFE2D71;
	Thu, 21 Aug 2008 13:04:48 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 742793EF9BC;
	Thu, 21 Aug 2008 13:03:47 +0200 (CEST)
Received: from [192.168.10.137] (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 89B4890004;
	Thu, 21 Aug 2008 13:03:47 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 21 Aug 2008 13:03:44 +0200
Subject: [PATCH] cobalt: group UART definition into header
MIME-Version: 1.0
X-UID:	1113
X-Length: 2513
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808211303.44865.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 742793EF9BC.3644B
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch groups the UART base address definition into
the cobalt.h header file making it easier to reuse
this code.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/cobalt/console.c b/arch/mips/cobalt/console.c
index d1ba701..48e2094 100644
--- a/arch/mips/cobalt/console.c
+++ b/arch/mips/cobalt/console.c
@@ -6,7 +6,7 @@
 
 #include <cobalt.h>
 
-#define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
+#define UART_BASE	((void __iomem *)CKSEG1ADDR(COBALT_UART_ADDR))
 
 void prom_putchar(char c)
 {
diff --git a/arch/mips/cobalt/serial.c b/arch/mips/cobalt/serial.c
index 53b8d0d..d12202e 100644
--- a/arch/mips/cobalt/serial.c
+++ b/arch/mips/cobalt/serial.c
@@ -28,8 +28,8 @@
 
 static struct resource cobalt_uart_resource[] __initdata = {
 	{
-		.start	= 0x1c800000,
-		.end	= 0x1c800007,
+		.start	= COBALT_UART_ADDR,
+		.end	= COBALT_UART_ADDR + 0x7,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
@@ -45,7 +45,7 @@ static struct plat_serial8250_port cobalt_serial8250_port[] = {
 		.uartclk	= 18432000,
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-		.mapbase	= 0x1c800000,
+		.mapbase	= COBALT_UART_ADDR,
 	},
 	{},
 };
diff --git a/include/asm-mips/mach-cobalt/cobalt.h b/include/asm-mips/mach-cobalt/cobalt.h
index 5b9fce7..9bf9e94 100644
--- a/include/asm-mips/mach-cobalt/cobalt.h
+++ b/include/asm-mips/mach-cobalt/cobalt.h
@@ -19,4 +19,6 @@ extern int cobalt_board_id;
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
+#define COBALT_UART_ADDR	0x1c800000
+
 #endif /* __ASM_COBALT_H */
