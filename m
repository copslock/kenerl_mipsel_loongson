Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 15:25:01 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:5162 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024285AbXJBOXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 15:23:55 +0100
Received: by mo.po.2iij.net (mo32) id l92EMbbE094930; Tue, 2 Oct 2007 23:22:37 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox301) id l92EMYxl000527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 23:22:35 +0900
Date:	Tue, 2 Oct 2007 23:13:17 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/4] move Cobalt UART base definition to
 arch/mips/cobalt/console.c
Message-Id: <20071002231317.0fbaf7bb.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071002225441.63d935eb.yoichi_yuasa@tripeaks.co.jp>
References: <20071002225441.63d935eb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Move Cobalt UART base definition to arch/mips/cobalt/console.c.
It's only used in arch/mips/cobalt/console.c.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
--- mips-orig/arch/mips/cobalt/console.c	2007-09-30 21:21:39.610319250 +0900
+++ mips/arch/mips/cobalt/console.c	2007-09-30 21:26:10.135226000 +0900
@@ -1,16 +1,15 @@
 /*
  * (C) P. Horton 2006
  */
+#include <linux/io.h>
 #include <linux/serial_reg.h>
 
-#include <asm/addrspace.h>
-
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
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-09-30 21:25:01.586942000 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-09-30 21:21:46.170729250 +0900
@@ -39,6 +39,4 @@ extern int cobalt_board_id;
 # define COBALT_KEY_SELECT	(1 << 7)
 # define COBALT_KEY_MASK	0xfe
 
-#define COBALT_UART		((volatile unsigned char *) CKSEG1ADDR(0x1c800000))
-
 #endif /* __ASM_COBALT_H */
