Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:16:10 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:53320 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021575AbXINIPi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 09:15:38 +0100
Received: by mo.po.2iij.net (mo32) id l8E8FYlw037346; Fri, 14 Sep 2007 17:15:34 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l8E8FWfD030485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:32 +0900
Message-Id: <200709140815.l8E8FWfD030485@po-mbox303.hop.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][5/9][MIPS] move Cobalt UART base address definition.
In-Reply-To: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
References: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Move Cobalt UART base address definition to arch/mips/cobalt/console.c.
It's only used in arch/mips/cobalt/console.c.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
--- mips-orig/arch/mips/cobalt/console.c	2007-08-24 11:14:29.808868500 +0900
+++ mips/arch/mips/cobalt/console.c	2007-08-24 11:18:24.867558750 +0900
@@ -4,13 +4,14 @@
 #include <linux/serial_reg.h>
 
 #include <asm/addrspace.h>
+#include <asm/io.h>
 
-#include <cobalt.h>
+#define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
 
 void prom_putchar(char c)
 {
-	while(!(COBALT_UART[UART_LSR] & UART_LSR_THRE))
+	while(!(readb(UART_BASE + UART_LSR) & UART_LSR_THRE))
 		;
 
-	COBALT_UART[UART_TX] = c;
+	writeb(c, UART_BASE + UART_TX);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-08-24 11:19:03.585978500 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-08-24 11:18:24.891560250 +0900
@@ -29,6 +29,4 @@ extern int cobalt_board_id;
 # define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
 # define COBALT_LED_RESET	0x0f
 
-#define COBALT_UART		((volatile unsigned char *) CKSEG1ADDR(0x1c800000))
-
 #endif /* __ASM_COBALT_H */
