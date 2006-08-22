Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:01:49 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:53537 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038741AbWHVN6v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:51 +0100
Received: by mo.po.2iij.net (mo31) id k7MDwnQp075950; Tue, 22 Aug 2006 22:58:49 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwlGk012227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:47 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:57:49 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 8/12] moved Cobalt serial I/O resource to memory resource
Message-Id: <20060822225749.26243eed.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has moved Cobalt serial I/O resource to memory resource.
The Cobalt serial port mapped memory resource area.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-21 22:46:30.651155000 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-21 22:31:39.043433000 +0900
@@ -21,7 +21,6 @@
 #include <asm/irq.h>
 #include <asm/processor.h>
 #include <asm/gt64120.h>
-#include <asm/serial.h>
 
 #include <cobalt.h>
 
@@ -92,8 +91,7 @@ void __init plat_mem_setup(void)
 
         set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
-	/* I/O port resource must include UART and LCD/buttons */
-	ioport_resource.end = 0x0fffffff;
+	ioport_resource.end = 0xffff;
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < COBALT_IO_RESOURCES; i++)
@@ -107,24 +105,24 @@ void __init plat_mem_setup(void)
 
 	printk("Cobalt board ID: %d\n", cobalt_board_id);
 
-#ifdef CONFIG_SERIAL_8250
 	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
-
 #ifdef CONFIG_EARLY_PRINTK
 		cobalt_early_console();
 #endif
 
+#ifdef CONFIG_SERIAL_8250
 		uart.line	= 0;
 		uart.type	= PORT_UNKNOWN;
 		uart.uartclk	= 18432000;
 		uart.irq	= COBALT_SERIAL_IRQ;
-		uart.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-		uart.iobase	= 0xc800000;
-		uart.iotype	= UPIO_PORT;
+		uart.flags	= UPF_IOREMAP | UPF_BOOT_AUTOCONF |
+				  UPF_SKIP_TEST;
+		uart.iotype	= UPIO_MEM;
+		uart.mapbase	= 0x1c800000;
 
 		early_serial_setup(&uart);
-	}
 #endif
+	}
 }
 
 /*
