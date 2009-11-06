Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 11:36:50 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:33306 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492505AbZKFKgB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 11:36:01 +0100
Received: by pzk32 with SMTP id 32so659676pzk.21
        for <multiple recipients>; Fri, 06 Nov 2009 02:35:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=X0EGewEwPMN5TAxw7vHSJokO/yM+AoSrwltqkskO95E=;
        b=xgbbvFYYgaQXnyYFxE6AWT4ATqa9zA8kSfTbrlpK6GC2EjVYy0yhVnxM7ha2S8tgFZ
         tGtAAjCIEuHPhIcwViCotsIziqZE0IlZHl22O0xVz7mnKnArg17kozRAq4YlKnDqtVIl
         xdUq6gMmB/rBRasQvgxDcXrtt7z/JmuDoSu4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oUdBm0ZO5PaJPWa7DiEhnXR6OsUBl/zaoDKPHvZdfds8Em7Ecw6yj99FpgZdTG6eNy
         6JjnQxbkb/r8xPJxjYq/wycn6e0W4BDqRXHhaUkCL1yqORrERHySujGoc20jN2s3I/jB
         phMfNPwZYx5THfDhAxFVuH0pmTyg/wQdtUUuY=
Received: by 10.114.242.2 with SMTP id p2mr6508546wah.153.1257503753947;
        Fri, 06 Nov 2009 02:35:53 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1679219pzk.10.2009.11.06.02.35.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:35:53 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/2] [loongson] Cleanup the serial port support
Date:	Fri,  6 Nov 2009 18:35:34 +0800
Message-Id: <e87bb620cae987f747311920dffd99daf75b1f1f.1257503696.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <905f2e99289a26852bf8d413f0e56ef2235cac99.1257503696.git.wuzhangjin@gmail.com>
References: <cover.1257503025.git.wuzhangjin@gmail.com>
 <905f2e99289a26852bf8d413f0e56ef2235cac99.1257503696.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257503696.git.wuzhangjin@gmail.com>
References: <cover.1257503696.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

To share the same kernel image amon different machines, we have added
the machtype command line support.

but in the old serial port implementation, we have hardcoded the uart
base address as a macro in machine.h, which will break the intention of
machtype. this patch fixes it, and also move the initialization of uart
base address to uart_base.c to avoid remapping twice for early_printk.c
and serial.c.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    3 ++
 arch/mips/include/asm/mach-loongson/machine.h  |    2 -
 arch/mips/loongson/common/Makefile             |    2 +-
 arch/mips/loongson/common/early_printk.c       |   11 +++++---
 arch/mips/loongson/common/init.c               |   11 +++++---
 arch/mips/loongson/common/serial.c             |   17 +++++------
 arch/mips/loongson/common/uart_base.c          |   34 ++++++++++++++++++++++++
 7 files changed, 60 insertions(+), 20 deletions(-)
 create mode 100644 arch/mips/loongson/common/uart_base.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index efb2344..e4818b6 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -31,6 +31,9 @@ extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
 extern void __init prom_init_machtype(void);
 extern void __init prom_init_env(void);
+extern unsigned long _loongson_uart_base;
+extern unsigned long uart8250_base[];
+extern inline void __maybe_unused prom_init_uart_base(void);
 
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index ea5954c..d2f5861 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -13,8 +13,6 @@
 
 #ifdef CONFIG_LEMOTE_FULOONG2E
 
-#define LOONGSON_UART_BASE (LOONGSON_PCIIO_BASE + 0x3f8)
-
 #define LOONGSON_MACHTYPE MACH_LEMOTE_FL2E
 
 #endif
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index d21d116..be6adf7 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
-    pci.o bonito-irq.o mem.o machtype.o
+    pci.o bonito-irq.o mem.o machtype.o uart_base.o
 
 #
 # Early printk support
diff --git a/arch/mips/loongson/common/early_printk.c b/arch/mips/loongson/common/early_printk.c
index 8ec4fb2..23e7a8f 100644
--- a/arch/mips/loongson/common/early_printk.c
+++ b/arch/mips/loongson/common/early_printk.c
@@ -12,7 +12,6 @@
 #include <linux/serial_reg.h>
 
 #include <loongson.h>
-#include <machine.h>
 
 #define PORT(base, offset) (u8 *)(base + offset)
 
@@ -28,10 +27,14 @@ static inline void serial_out(unsigned char *base, int offset, int value)
 
 void prom_putchar(char c)
 {
-	unsigned char *uart_base =
-		(unsigned char *) ioremap_nocache(LOONGSON_UART_BASE, 8);
+	int timeout;
+	unsigned char *uart_base;
 
-	while ((serial_in(uart_base, UART_LSR) & UART_LSR_THRE) == 0)
+	uart_base = (unsigned char *)_loongson_uart_base;
+	timeout = 1024;
+
+	while (((serial_in(uart_base, UART_LSR) & UART_LSR_THRE) == 0) &&
+			(timeout-- > 0))
 		;
 
 	serial_out(uart_base, UART_TX, c);
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index b7e4913..3b1dbc1 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzj@lemote.com
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -10,19 +10,22 @@
 
 #include <linux/bootmem.h>
 
-#include <asm/bootinfo.h>
-
 #include <loongson.h>
 
 void __init prom_init(void)
 {
-    /* init base address of io space */
+	/* init base address of io space */
 	set_io_port_base((unsigned long)
 		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
 
 	prom_init_cmdline();
 	prom_init_env();
 	prom_init_memory();
+
+	/*init the uart base address */
+#if defined(CONFIG_EARLY_PRINTK) || defined(CONFIG_SERIAL_8250)
+	prom_init_uart_base();
+#endif
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 6d341e4..dc6488c 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -23,7 +23,6 @@
 {								\
 	.irq		= int,					\
 	.uartclk	= 1843200,				\
-	.iobase		= (LOONGSON_UART_BASE - LOONGSON_PCIIO_BASE),\
 	.iotype		= UPIO_PORT,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
 	.regshift	= 0,					\
@@ -52,20 +51,20 @@ static struct plat_serial8250_port uart8250_data[][2] = {
 static struct platform_device uart8250_device = {
 	.name = "serial8250",
 	.id = PLAT8250_DEV_PLATFORM,
-	.dev = {
-		.platform_data = uart8250_data[LOONGSON_MACHTYPE],
-		},
 };
 
 static int __init serial_init(void)
 {
-	if (uart8250_data[LOONGSON_MACHTYPE][0].iotype == UPIO_MEM)
-		uart8250_data[LOONGSON_MACHTYPE][0].membase =
-			ioremap_nocache(LOONGSON_UART_BASE, 8);
+	if (uart8250_data[mips_machtype][0].iotype == UPIO_MEM)
+		uart8250_data[mips_machtype][0].membase =
+			(void __iomem *)_loongson_uart_base;
+	else if (uart8250_data[mips_machtype][0].iotype == UPIO_PORT)
+		uart8250_data[mips_machtype][0].iobase =
+		    uart8250_base[mips_machtype] - LOONGSON_PCIIO_BASE;
 
-	platform_device_register(&uart8250_device);
+	uart8250_device.dev.platform_data = uart8250_data[mips_machtype];
 
-	return 0;
+	return platform_device_register(&uart8250_device);
 }
 
 device_initcall(serial_init);
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
new file mode 100644
index 0000000..c3db78a
--- /dev/null
+++ b/arch/mips/loongson/common/uart_base.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+unsigned long __maybe_unused _loongson_uart_base;
+EXPORT_SYMBOL(_loongson_uart_base);
+
+unsigned long __maybe_unused uart8250_base[] = {
+	[MACH_LOONGSON_UNKNOWN]	0,
+	[MACH_LEMOTE_FL2E]	(LOONGSON_PCIIO_BASE + 0x3f8),
+	[MACH_LEMOTE_FL2F]	(LOONGSON_PCIIO_BASE + 0x2f8),
+	[MACH_LEMOTE_ML2F7]	(LOONGSON_LIO1_BASE + 0x3f8),
+	[MACH_LEMOTE_YL2F89]	(LOONGSON_LIO1_BASE + 0x3f8),
+	[MACH_DEXXON_GDIUM2F10]	(LOONGSON_LIO1_BASE + 0x3f8),
+	[MACH_LOONGSON_END]	0,
+};
+EXPORT_SYMBOL(uart8250_base);
+
+inline void __maybe_unused prom_init_uart_base(void)
+{
+	_loongson_uart_base =
+		(unsigned long)ioremap_nocache(uart8250_base[mips_machtype], 8);
+}
-- 
1.6.2.1
