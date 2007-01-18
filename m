Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 13:24:27 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:30216 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20044383AbXARNYW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 13:24:22 +0000
Received: by mo.po.2iij.net (mo30) id l0IDOFLa099021; Thu, 18 Jan 2007 22:24:15 +0900 (JST)
Received: from localhost.localdomain (69.25.30.125.dy.iij4u.or.jp [125.30.25.69])
	by mbox.po.2iij.net (mbox33) id l0IDO8QA024000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Jan 2007 22:24:09 +0900 (JST)
Date:	Thu, 18 Jan 2007 22:24:08 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix Cobalt UART resource
Message-Id: <20070118222408.198fb0c1.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed UART I/O type.
The cobalt UART device is connected to memory resource.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-12-09 19:03:28.738974000 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-12-09 19:32:33.329616250 +0900
@@ -130,7 +130,7 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
-	/* I/O port resource must include UART and LCD/buttons */
+	/* I/O port resource must include LCD/buttons */
 	ioport_resource.end = 0x0fffffff;
 
 	/* request I/O space for devices used on all i[345]86 PCs */
@@ -149,24 +149,24 @@ void __init plat_mem_setup(void)
 	register_pci_controller(&cobalt_pci_controller);
 #endif
 
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
