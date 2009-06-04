Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:08:25 +0100 (WEST)
Received: from wa-out-1112.google.com ([209.85.146.181]:46783 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022619AbZFDNHU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:07:20 +0100
Received: by wa-out-1112.google.com with SMTP id n4so139322wag.0
        for <multiple recipients>; Thu, 04 Jun 2009 06:07:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FTEL2Az40Ry9Iw8aFC99SXT2jNvyWj1vdCTdg8CNCr0=;
        b=SVDGXxtibBb1D7mzebcMFpe5tI3K+vVokB6tzCyJJ3M6HBgDCNErm6mc47caXO+nFj
         fVMC6NhRopSPH3/AxUP9xbxJ23d9dbjLbTYOJchxsYcT5M9uTEjKuqpy0JShliB8lsOA
         RSVB1rRomN/5gr/MjpxiOa4SXoRQlw8HvclvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vb0+JEbk5FTfSVEdJb+g3wV+Iz56hRZ9i22zUC9uJooMNk6A3HspPtY6BhBYGvqIYj
         sPzLQ9AEgHob96mMuCzlhgcS+gNd0ZMf6Zv6NFyWFgBh+oGc5HyiSHf0VrWYZxQEKjCq
         Cpr0j5glM1pQSMSQVtJMfzXaeR4RX/PD76x6g=
Received: by 10.115.32.8 with SMTP id k8mr3515168waj.15.1244120837860;
        Thu, 04 Jun 2009 06:07:17 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id g25sm11108916wag.8.2009.06.04.06.07.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:07:17 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 14/25] enable serial port support of loongson-based machines
Date:	Thu,  4 Jun 2009 21:07:04 +0800
Message-Id: <259af42c6b8a6be2dc8c632c4089b5c9feb1dc6a.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

this serial port support is portable to loongson-based machines, the old
serial port support in fuloong(2e) via HAVE_STD_PC_SERIAL_PORT is
replaced by this implementation.

before, only fuloong(2e) used HAVE_STD_PC_SERIAL_PORT kernel option, so,
with this new support, we can remove arch/mips/kernel/8250-platform.c
directly. but in this patch, that file is reserved there for potential
use in the other machines.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/machine.h |    4 ++
 arch/mips/loongson/Kconfig                    |    1 -
 arch/mips/loongson/common/Makefile            |    5 ++
 arch/mips/loongson/common/serial.c            |   66 +++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/common/serial.c

diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index da6b6d6..ac88192 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -18,6 +18,8 @@
 #define MACH_NAME			"lemote-fuloong(2e)"
 
 #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x3f8)
+#define	LOONGSON_UART_BAUD		1843200
+#define	LOONGSON_UART_IOTYPE		UPIO_PORT
 
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)
 #define LOONGSON_UART_IRQ		(MIPS_CPU_IRQ_BASE + 4)
@@ -30,6 +32,8 @@
 #define MACH_NAME			"lemote-fuloong(2f)"
 
 #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x2f8)
+#define LOONGSON_UART_BAUD		1843200
+#define LOONGSON_UART_IOTYPE		UPIO_PORT
 
 #define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
 #define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 2bfda6e..0547907 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -11,7 +11,6 @@ config LEMOTE_FULOONG2E
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
 	select BOARD_SCACHE
-	select HAVE_STD_PC_SERIAL_PORT
 	select HW_HAS_PCI
 	select I8259
 	select ISA
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index d55499e..2d3fa3e 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -23,4 +23,9 @@ obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
 #
 obj-$(CONFIG_CS5536) += cs5536/
 
+#
+# Enable serial port
+#
+obj-$(CONFIG_SERIAL_8250) += serial.o
+
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
new file mode 100644
index 0000000..7042a6c
--- /dev/null
+++ b/arch/mips/loongson/common/serial.c
@@ -0,0 +1,66 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: yanhua (yanhua@lemote.com)
+ * Author: Wu Zhangjin (wuzj@lemote.com)
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+#define PORT(int, base_baud, io_type)				\
+{								\
+	.irq		= int,					\
+	.uartclk	= base_baud,				\
+	.iotype		= io_type,				\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
+	.regshift	= 0,					\
+}
+
+static struct plat_serial8250_port uart8250_data[] = {
+	PORT(LOONGSON_UART_IRQ, LOONGSON_UART_BAUD, LOONGSON_UART_IOTYPE),
+	{},
+};
+
+static struct platform_device uart8250_device = {
+	.name = "serial8250",
+	.id = PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = uart8250_data,
+		},
+};
+
+static inline void uart8250_init(void)
+{
+#if (LOONGSON_UART_IOTYPE == UPIO_MEM)
+		uart8250_data[0].membase =
+		    ioremap_nocache(LOONGSON_UART_BASE, 8);
+#elif (LOONGSON_UART_IOTYPE == UPIO_PORT)
+		uart8250_data[0].iobase =
+				LOONGSON_UART_BASE - LOONGSON_PCIIO_BASE;
+		uart8250_data[0].irq -= MIPS_CPU_IRQ_BASE;
+#else
+#warning currently, no such iotype of uart used in loongson-based machines
+
+#endif
+}
+
+static int __init serial_init(void)
+{
+	uart8250_init();
+
+	platform_device_register(&uart8250_device);
+
+	return 0;
+}
+
+device_initcall(serial_init);
-- 
1.6.0.4
