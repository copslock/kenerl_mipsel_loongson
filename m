Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 06:58:26 +0100 (BST)
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:20867 "EHLO
	stout.engsoc.carleton.ca") by ftp.linux-mips.org with ESMTP
	id S20024657AbZDVF6T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 06:58:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 3F6615840B0;
	Wed, 22 Apr 2009 01:58:11 -0400 (EDT)
Received: from stout.engsoc.carleton.ca ([127.0.0.1])
	by localhost (stout.engsoc.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3PHS7UQYac5; Wed, 22 Apr 2009 01:58:11 -0400 (EDT)
Received: from mobius.cowpig.ca (cowpig.ca [134.117.69.79])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 0B03A5840AF;
	Wed, 22 Apr 2009 01:58:11 -0400 (EDT)
Received: by mobius.cowpig.ca (Postfix, from userid 1000)
	id B46F916018B; Wed, 22 Apr 2009 01:58:09 -0400 (EDT)
Date:	Wed, 22 Apr 2009 01:58:09 -0400
From:	Philippe Vachon <philippe@cowpig.ca>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Clean up Lemote Loongson 2E Support
Message-ID: <20090422055809.GA1821@cowpig.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Return-Path: <philippe@cowpig.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe@cowpig.ca
Precedence: bulk
X-list: linux-mips

This patch eliminates magic numbers and accessors for memory-mapped
registers. As well, it removes some inline assembly and restructures how
the early printk code behaves.

Signed-off-by: Philippe Vachon <philippe@cowpig.ca>
---
 arch/mips/include/asm/mach-lemote/loongson2e.h |   58 +++++++++++
 arch/mips/lemote/lm2e/dbg_io.c                 |  125 ++---------------------
 arch/mips/lemote/lm2e/prom.c                   |   10 +--
 arch/mips/lemote/lm2e/reset.c                  |   18 ++--
 4 files changed, 80 insertions(+), 131 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lemote/loongson2e.h

diff --git a/arch/mips/include/asm/mach-lemote/loongson2e.h b/arch/mips/include/asm/mach-lemote/loongson2e.h
new file mode 100644
index 0000000..558eaca
--- /dev/null
+++ b/arch/mips/include/asm/mach-lemote/loongson2e.h
@@ -0,0 +1,58 @@
+/* Accessor functions for the Loongson 2E MMIO registers
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __ASM_MACH_LEMOTE_LOONGSON2E
+#define __ASM_MACH_LEMOTE_LOONGSON2E
+
+#include <linux/types.h>
+
+/* Loongson 2E Control Registers */
+#define LS2E_REG_BASE		0x1fe00100 /* start of config registers */
+#define LS2E_GENCFG_REG		(LS2E_REG_BASE + 0x04)
+
+#define LS2E_RESET_VECTOR	0x1fc00000 /* this should be obvious! */
+
+/* UART address (16550 -- on the Fulong) */
+#define LS2E_UART_BASE		0x1fd003f8
+
+/* Various system parameters passed from PMON */
+extern unsigned long bus_clock;
+extern unsigned long cpu_clock_freq;
+extern unsigned int memsize, highmemsize;
+
+static inline void ls2e_writeb(uint8_t value, phys_addr_t addr)
+{
+	*(volatile uint8_t *)addr = value;
+}
+
+static inline void ls2e_writew(uint16_t value, phys_addr_t addr)
+{
+	*(volatile uint16_t *)addr = value;
+}
+
+static inline void ls2e_writel(uint32_t value, phys_addr_t addr)
+{
+	*(volatile uint32_t *)addr = value;
+}
+
+static inline uint8_t ls2e_readb(phys_addr_t addr)
+{
+	return *(volatile uint8_t *)addr;
+}
+
+static inline uint16_t ls2e_readw(phys_addr_t addr)
+{
+	return *(volatile uint16_t *)addr;
+}
+
+static inline uint32_t ls2e_readl(phys_addr_t addr)
+{
+	return *(volatile uint32_t *)addr;
+}
+
+#endif /* __ASM_MACH_LEMOTE_LOONGSON2E */
diff --git a/arch/mips/lemote/lm2e/dbg_io.c b/arch/mips/lemote/lm2e/dbg_io.c
index 6c95da3..988491f 100644
--- a/arch/mips/lemote/lm2e/dbg_io.c
+++ b/arch/mips/lemote/lm2e/dbg_io.c
@@ -1,10 +1,6 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+/*  Support for the 16550 on the Lemote Fulong.
  *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
+ *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -29,118 +25,19 @@
  */
 
 #include <linux/io.h>
-#include <linux/init.h>
 #include <linux/types.h>
+#include <linux/serial_reg.h>
 
-#include <asm/serial.h>
+#include <loongson2e.h>
 
-#define         UART16550_BAUD_2400             2400
-#define         UART16550_BAUD_4800             4800
-#define         UART16550_BAUD_9600             9600
-#define         UART16550_BAUD_19200            19200
-#define         UART16550_BAUD_38400            38400
-#define         UART16550_BAUD_57600            57600
-#define         UART16550_BAUD_115200           115200
-
-#define         UART16550_PARITY_NONE           0
-#define         UART16550_PARITY_ODD            0x08
-#define         UART16550_PARITY_EVEN           0x18
-#define         UART16550_PARITY_MARK           0x28
-#define         UART16550_PARITY_SPACE          0x38
-
-#define         UART16550_DATA_5BIT             0x0
-#define         UART16550_DATA_6BIT             0x1
-#define         UART16550_DATA_7BIT             0x2
-#define         UART16550_DATA_8BIT             0x3
-
-#define         UART16550_STOP_1BIT             0x0
-#define         UART16550_STOP_2BIT             0x4
-
-/* ----------------------------------------------------- */
-
-/* === CONFIG === */
-#ifdef CONFIG_64BIT
-#define         BASE                    (0xffffffffbfd003f8)
-#else
-#define         BASE                    (0xbfd003f8)
-#endif
-
-#define         MAX_BAUD                BASE_BAUD
-/* === END OF CONFIG === */
-
-#define         REG_OFFSET              1
-
-/* register offset */
-#define         OFS_RCV_BUFFER          0
-#define         OFS_TRANS_HOLD          0
-#define         OFS_SEND_BUFFER         0
-#define         OFS_INTR_ENABLE         (1*REG_OFFSET)
-#define         OFS_INTR_ID             (2*REG_OFFSET)
-#define         OFS_DATA_FORMAT         (3*REG_OFFSET)
-#define         OFS_LINE_CONTROL        (3*REG_OFFSET)
-#define         OFS_MODEM_CONTROL       (4*REG_OFFSET)
-#define         OFS_RS232_OUTPUT        (4*REG_OFFSET)
-#define         OFS_LINE_STATUS         (5*REG_OFFSET)
-#define         OFS_MODEM_STATUS        (6*REG_OFFSET)
-#define         OFS_RS232_INPUT         (6*REG_OFFSET)
-#define         OFS_SCRATCH_PAD         (7*REG_OFFSET)
-
-#define         OFS_DIVISOR_LSB         (0*REG_OFFSET)
-#define         OFS_DIVISOR_MSB         (1*REG_OFFSET)
-
-/* memory-mapped read/write of the port */
-#define         UART16550_READ(y)	readb((char *)BASE + (y))
-#define         UART16550_WRITE(y, z)	writeb(z, (char *)BASE + (y))
-
-void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
+void prom_putchar(char c)
 {
-	u32 divisor;
-
-	/* disable interrupts */
-	UART16550_WRITE(OFS_INTR_ENABLE, 0);
+	int timeout;
+	phys_addr_t uart_base = (phys_addr_t)ioremap_nocache(LS2E_UART_BASE, 8);
+	char reg = ls2e_readb(uart_base + UART_LSR) & UART_LSR_THRE;
 
-	/* set up buad rate */
-	/* set DIAB bit */
-	UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
-
-	/* set divisor */
-	divisor = MAX_BAUD / baud;
-	UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
-	UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
-
-	/* clear DIAB bit */
-	UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
-
-	/* set data format */
-	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
-}
-
-static int remoteDebugInitialized;
-
-u8 getDebugChar(void)
-{
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		debugInit(UART16550_BAUD_115200,
-			  UART16550_DATA_8BIT,
-			  UART16550_PARITY_NONE, UART16550_STOP_1BIT);
-	}
-
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0) ;
-	return UART16550_READ(OFS_RCV_BUFFER);
-}
-
-int putDebugChar(u8 byte)
-{
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		/*
-		   debugInit(UART16550_BAUD_115200,
-		   UART16550_DATA_8BIT,
-		   UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
-	}
+	for (timeout = 1024; reg == 0 && timeout > 0; timeout--)
+		reg = ls2e_readb(uart_base + UART_LSR) & UART_LSR_THRE;
 
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0) ;
-	UART16550_WRITE(OFS_SEND_BUFFER, byte);
-	return 1;
+	ls2e_writeb(c, uart_base + UART_TX);
 }
diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
index 7edc15d..83777bd 100644
--- a/arch/mips/lemote/lm2e/prom.c
+++ b/arch/mips/lemote/lm2e/prom.c
@@ -18,10 +18,7 @@
 #include <linux/bootmem.h>
 #include <asm/bootinfo.h>
 
-extern unsigned long bus_clock;
-extern unsigned long cpu_clock_freq;
-extern unsigned int memsize, highmemsize;
-extern int putDebugChar(unsigned char byte);
+#include <loongson2e.h>
 
 static int argc;
 /* pmon passes arguments in 32bit pointers */
@@ -90,8 +87,3 @@ do {									\
 void __init prom_free_prom_memory(void)
 {
 }
-
-void prom_putchar(char c)
-{
-	putDebugChar(c);
-}
diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
index 099387a..0989d28 100644
--- a/arch/mips/lemote/lm2e/reset.c
+++ b/arch/mips/lemote/lm2e/reset.c
@@ -7,20 +7,22 @@
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  */
+
 #include <linux/pm.h>
+#include <linux/io.h>
+#include <loongson2e.h>
 
 #include <asm/reboot.h>
 
 static void loongson2e_restart(char *command)
 {
-#ifdef CONFIG_32BIT
-	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xbfe00104 |= (1 << 2);
-#else
-	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
-#endif
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+	uint32_t ctl =
+		(ls2e_readl((phys_addr_t)ioremap_nocache(LS2E_GENCFG_REG, 4))
+		& ~(1 << 2)) | 1 << 2;
+
+	ls2e_writel(ctl, (phys_addr_t)ioremap_nocache(LS2E_GENCFG_REG, 4));
+
+	((void (*)(void))ioremap_nocache(LS2E_RESET_VECTOR, 4))();
 }
 
 static void loongson2e_halt(void)
-- 
1.6.1
