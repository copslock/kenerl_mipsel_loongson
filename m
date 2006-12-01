Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 13:21:39 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:41794 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573729AbWLANVH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 13:21:07 +0000
Received: by mo.po.2iij.net (mo32) id kB1DL4YY000110; Fri, 1 Dec 2006 22:21:04 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox32) id kB1DL03P027729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Dec 2006 22:21:00 +0900 (JST)
Date:	Fri, 1 Dec 2006 22:12:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/5] MIPS: fix cobalt I/O resource range
Message-Id: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed cobalt I/O reource range.
The cobalt real I/O resource range from 0x0 to 0xffff.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-10-12 01:03:18.055569000 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-10-12 01:01:59.973744750 +0900
@@ -130,8 +130,7 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
-	/* I/O port resource must include UART and LCD/buttons */
-	ioport_resource.end = 0x0fffffff;
+	ioport_resource.end = 0xffff;
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < COBALT_IO_RESOURCES; i++)
@@ -149,24 +148,24 @@ void __init plat_mem_setup(void)
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
