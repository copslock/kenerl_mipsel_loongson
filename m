Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 15:37:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45311 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133466AbWBIPha (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 15:37:30 +0000
Received: from localhost (p5155-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C8EC184CD; Fri, 10 Feb 2006 00:43:19 +0900 (JST)
Date:	Fri, 10 Feb 2006 00:43:02 +0900 (JST)
Message-Id: <20060210.004302.96686142.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix build error by removal of obsoleted au1x00_uart driver.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index a08fa1a..7b23664 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -103,66 +103,6 @@
 #define IVR_SERIAL_PORT_DEFNS
 #endif
 
-#ifdef CONFIG_SOC_AU1500
-#define AU1000_SERIAL_PORT_DEFNS                       \
-    { .baud_base = 0, .port = UART0_ADDR,              \
-      .iomem_base = (unsigned char *)UART0_ADDR,       \
-      .irq = AU1500_UART0_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },                          \
-    { .baud_base = 0, .port = UART3_ADDR,              \
-      .iomem_base = (unsigned char *)UART3_ADDR,       \
-      .irq = AU1500_UART3_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },
-#endif
-
-#ifdef CONFIG_SOC_AU1100
-#define AU1000_SERIAL_PORT_DEFNS                       \
-    { .baud_base = 0, .port = UART0_ADDR,              \
-      .iomem_base = (unsigned char *)UART0_ADDR,       \
-      .irq = AU1100_UART0_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },                          \
-    { .baud_base = 0, .port = UART1_ADDR,              \
-      .iomem_base = (unsigned char *)UART1_ADDR,       \
-      .irq = AU1100_UART1_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },                          \
-    { .baud_base = 0, .port = UART3_ADDR,              \
-      .iomem_base = (unsigned char *)UART3_ADDR,       \
-      .irq = AU1100_UART3_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },
-#endif
-
-#ifdef CONFIG_SOC_AU1550
-#define AU1000_SERIAL_PORT_DEFNS                       \
-    { .baud_base = 0, .port = UART0_ADDR,              \
-      .iomem_base = (unsigned char *)UART0_ADDR,       \
-      .irq = AU1550_UART0_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },                          \
-    { .baud_base = 0, .port = UART1_ADDR,              \
-      .iomem_base = (unsigned char *)UART1_ADDR,       \
-      .irq = AU1550_UART1_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },                          \
-    { .baud_base = 0, .port = UART3_ADDR,              \
-      .iomem_base = (unsigned char *)UART3_ADDR,       \
-      .irq = AU1550_UART3_INT,  .flags = STD_COM_FLAGS,\
-      .iomem_reg_shift = 2 },
-#endif
-
-#ifdef CONFIG_SOC_AU1200
-#define AU1000_SERIAL_PORT_DEFNS                       \
-    { .baud_base = 0, .port = UART0_ADDR,              \
-      .iomem_base = (unsigned char *)UART0_ADDR,       \
-      .irq = AU1200_UART0_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },                          \
-    { .baud_base = 0, .port = UART1_ADDR,              \
-      .iomem_base = (unsigned char *)UART1_ADDR,       \
-      .irq = AU1200_UART1_INT, .flags = STD_COM_FLAGS, \
-      .iomem_reg_shift = 2 },
-#endif
-
-#else
-#define AU1000_SERIAL_PORT_DEFNS
-#endif
-
 #ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
@@ -309,7 +249,6 @@
 	MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
-	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
-	AU1000_SERIAL_PORT_DEFNS
+	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS
 
 #endif /* _ASM_SERIAL_H */
