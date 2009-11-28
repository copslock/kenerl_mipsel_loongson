Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 07:22:17 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:39122 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492007AbZK1GWO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 07:22:14 +0100
Received: by pzk35 with SMTP id 35so1512963pzk.22
        for <multiple recipients>; Fri, 27 Nov 2009 22:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hthCTvgi3kkeOb62VVsbKqB0EH8E6+sTuFdzZZhUFFs=;
        b=u/SMgmkQqyVIDzhMMP+AqILkDlixGVRDIfzT9JQ7jSr/CV777dstPEmqbcuUp8Fify
         CDB6OlnEAJmdeeejAJCcEYa0JRTDgYvI2wbLapsbtoiejsXNTWytbYJSNJ6FHwaHNy+Z
         x3Cwm+RitkXz4igfjHdx6Z63l2IRjqS1Mt2xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QMwP2HRx+y3innd/18Ilb7eiYnVUnWOGXv4aFooRnKCxV01qXn33VKuOT5TS58Izre
         oRI9lfwXHVGhaWugl3Cw2YDSBhl1wHqKSAINSSGrU5Xzje81IVsccjEX8BWpjt1TzCF0
         b4C8EAS/Pbr8UUxs7ou9dygVu/JYx4vk3GmZo=
Received: by 10.114.165.20 with SMTP id n20mr3240674wae.6.1259389325782;
        Fri, 27 Nov 2009 22:22:05 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1717467pxi.13.2009.11.27.22.22.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 22:22:05 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1] MIPS: Loongson: Cleanups of serial port support
Date:   Sat, 28 Nov 2009 14:21:50 +0800
Message-Id: <4eb67c3e4c7df40a71832bbda3b265606b6096be.1259389212.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(This revision is rebased on the latest linux-queue.)

This patchs uses a loongson_uart_base variable instead of the
uart_base[] array and adds a new kernel option to avoid to compile
uart_base.c all the time, which will save a little bit of memory for us.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |   14 ++++++--
 arch/mips/loongson/Kconfig                     |    5 +++
 arch/mips/loongson/common/Makefile             |    5 ++-
 arch/mips/loongson/common/init.c               |    2 -
 arch/mips/loongson/common/serial.c             |   10 ++++--
 arch/mips/loongson/common/uart_base.c          |   41 ++++++++++++++---------
 6 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 06c28f3..ee8bc83 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -31,9 +31,17 @@ extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
 extern void __init prom_init_machtype(void);
 extern void __init prom_init_env(void);
-extern unsigned long _loongson_uart_base;
-extern unsigned long uart8250_base[];
-extern void prom_init_uart_base(void);
+#ifdef CONFIG_LOONGSON_UART_BASE
+extern unsigned long _loongson_uart_base, loongson_uart_base;
+extern void prom_init_loongson_uart_base(void);
+#endif
+
+static inline void prom_init_uart_base(void)
+{
+#ifdef CONFIG_LOONGSON_UART_BASE
+	prom_init_loongson_uart_base();
+#endif
+}
 
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 7a86987..3df1967 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -78,3 +78,8 @@ config LOONGSON_SUSPEND
 	bool
 	default y
 	depends on CPU_SUPPORTS_CPUFREQ && SUSPEND
+
+config LOONGSON_UART_BASE
+	bool
+	default y
+	depends on EARLY_PRINTK || SERIAL_8250
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index a21724d..01fc2f3 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -3,13 +3,14 @@
 #
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
-    pci.o bonito-irq.o mem.o machtype.o uart_base.o
+    pci.o bonito-irq.o mem.o machtype.o
 
 #
-# Early printk support
+# Serial port support
 #
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_SERIAL_8250) += serial.o
+obj-$(CONFIG_LOONGSON_UART_BASE) += uart_base.o
 
 #
 # Enable CS5536 Virtual Support Module(VSM) to virtulize the PCI configure
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 2b92a23..a2abd93 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -31,9 +31,7 @@ void __init prom_init(void)
 	prom_init_memory();
 
 	/*init the uart base address */
-#if defined(CONFIG_EARLY_PRINTK) || defined(CONFIG_SERIAL_8250)
 	prom_init_uart_base();
-#endif
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index ea29db0..23b66a5 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -57,12 +57,16 @@ static struct platform_device uart8250_device = {
 
 static int __init serial_init(void)
 {
-	if (uart8250_data[mips_machtype][0].iotype == UPIO_MEM)
+	unsigned char iotype;
+
+	iotype = uart8250_data[mips_machtype][0].iotype;
+
+	if (UPIO_MEM == iotype)
 		uart8250_data[mips_machtype][0].membase =
 			(void __iomem *)_loongson_uart_base;
-	else if (uart8250_data[mips_machtype][0].iotype == UPIO_PORT)
+	else if (UPIO_PORT == iotype)
 		uart8250_data[mips_machtype][0].iobase =
-		    uart8250_base[mips_machtype] - LOONGSON_PCIIO_BASE;
+		    loongson_uart_base - LOONGSON_PCIIO_BASE;
 
 	uart8250_device.dev.platform_data = uart8250_data[mips_machtype];
 
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index 1d636f4..78ff66a 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -13,24 +13,33 @@
 
 #include <loongson.h>
 
-unsigned long __maybe_unused _loongson_uart_base;
+/* ioremapped */
+unsigned long _loongson_uart_base;
 EXPORT_SYMBOL(_loongson_uart_base);
+/* raw */
+unsigned long loongson_uart_base;
+EXPORT_SYMBOL(loongson_uart_base);
 
-unsigned long __maybe_unused uart8250_base[] = {
-	[MACH_LOONGSON_UNKNOWN]	0,
-	[MACH_LEMOTE_FL2E]	(LOONGSON_PCIIO_BASE + 0x3f8),
-	[MACH_LEMOTE_FL2F]	(LOONGSON_PCIIO_BASE + 0x2f8),
-	[MACH_LEMOTE_ML2F7]	(LOONGSON_LIO1_BASE + 0x3f8),
-	[MACH_LEMOTE_YL2F89]	(LOONGSON_LIO1_BASE + 0x3f8),
-	[MACH_DEXXON_GDIUM2F10]	(LOONGSON_LIO1_BASE + 0x3f8),
-	[MACH_LEMOTE_NAS]	(LOONGSON_LIO1_BASE + 0x3f8),
-	[MACH_LEMOTE_LL2F]	(LOONGSON_PCIIO_BASE + 0x2f8),
-	[MACH_LOONGSON_END]	0,
-};
-EXPORT_SYMBOL(uart8250_base);
-
-void __maybe_unused prom_init_uart_base(void)
+void prom_init_loongson_uart_base(void)
 {
+	switch (mips_machtype) {
+	case MACH_LEMOTE_FL2E:
+		loongson_uart_base = LOONGSON_PCIIO_BASE + 0x3f8;
+		break;
+	case MACH_LEMOTE_FL2F:
+	case MACH_LEMOTE_LL2F:
+		loongson_uart_base = LOONGSON_PCIIO_BASE + 0x2f8;
+		break;
+	case MACH_LEMOTE_ML2F7:
+	case MACH_LEMOTE_YL2F89:
+	case MACH_DEXXON_GDIUM2F10:
+	case MACH_LEMOTE_NAS:
+	default:
+		/* The CPU provided serial port */
+		loongson_uart_base = LOONGSON_LIO1_BASE + 0x3f8;
+		break;
+	}
+
 	_loongson_uart_base =
-		(unsigned long)ioremap_nocache(uart8250_base[mips_machtype], 8);
+		(unsigned long)ioremap_nocache(loongson_uart_base, 8);
 }
-- 
1.6.2.1
