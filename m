Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 11:49:00 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:61709 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037591AbWJAKs6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Oct 2006 11:48:58 +0100
Received: by mo.po.2iij.net (mo32) id k91AmsUY014903; Sun, 1 Oct 2006 19:48:54 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox30) id k91Amq4c090868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Oct 2006 19:48:52 +0900 (JST)
Date:	Sun, 1 Oct 2006 19:43:27 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/3] rename SERIAL_PORT_DEFNS for EV64120
Message-Id: <20061001194327.02fceb06.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061001193528.003d01d8.yoichi_yuasa@tripeaks.co.jp>
References: <20061001193528.003d01d8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has renamed serial ports definition for EV64120.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/serial.h mips/include/asm-mips/serial.h
--- mips-orig/include/asm-mips/serial.h	2006-10-01 16:12:38.497543500 +0900
+++ mips/include/asm-mips/serial.h	2006-10-01 16:30:18.963818500 +0900
@@ -55,19 +55,18 @@
  * Galileo EV64120 evaluation board
  */
 #ifdef CONFIG_MIPS_EV64120
-#include <asm/galileo-boards/ev96100.h>
-#include <asm/galileo-boards/ev96100int.h>
-#define EV96100_SERIAL_PORT_DEFNS                                  \
-    { .baud_base = EV96100_BASE_BAUD, .irq = EV96100INT_UART_0, \
+#include <mach-gt64120.h>
+#define EV64120_SERIAL_PORT_DEFNS                                  \
+    { .baud_base = EV64120_BASE_BAUD, .irq = EV64120_UART_IRQ, \
       .flags = STD_COM_FLAGS,  \
-      .iomem_base = EV96100_UART0_REGS_BASE, .iomem_reg_shift = 2, \
+      .iomem_base = EV64120_UART0_REGS_BASE, .iomem_reg_shift = 2, \
       .io_type = SERIAL_IO_MEM }, \
-    { .baud_base = EV96100_BASE_BAUD, .irq = EV96100INT_UART_0, \
+    { .baud_base = EV64120_BASE_BAUD, .irq = EV64120_UART_IRQ, \
       .flags = STD_COM_FLAGS, \
-      .iomem_base = EV96100_UART1_REGS_BASE, .iomem_reg_shift = 2, \
+      .iomem_base = EV64120_UART1_REGS_BASE, .iomem_reg_shift = 2, \
       .io_type = SERIAL_IO_MEM },
 #else
-#define EV96100_SERIAL_PORT_DEFNS
+#define EV64120_SERIAL_PORT_DEFNS
 #endif
 
 #ifdef CONFIG_MIPS_ITE8172
@@ -239,7 +238,7 @@
 
 #define SERIAL_PORT_DFNS				\
 	DDB5477_SERIAL_PORT_DEFNS			\
-	EV96100_SERIAL_PORT_DEFNS			\
+	EV64120_SERIAL_PORT_DEFNS			\
 	IP32_SERIAL_PORT_DEFNS                          \
 	ITE_SERIAL_PORT_DEFNS           		\
 	IVR_SERIAL_PORT_DEFNS           		\
