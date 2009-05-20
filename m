Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:07:36 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.182]:17242 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025192AbZETWHF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:07:05 +0100
Received: by wa-out-1112.google.com with SMTP id n4so120398wag.0
        for <multiple recipients>; Wed, 20 May 2009 15:07:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XsGJdvV9K0JQfGxGrhsnXXNhhv2nKGG0LEFY6J+71Kk=;
        b=v33UR1KqIytrwIBOmAUduCmshGycad4ravoCJb+yc9WvWdk2WzEwGWCEP6ybHm3+7x
         SrQl+Fr9uGCvEXEIJz8WRcYPDkuVGoedj28kHFaYblkPvvi797TD1X1B7BlVUF9d5mdQ
         fpfcBSebmoUIViP1ZDVhlNawlCE71AoplcePk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vj+l8OemeQ0h5lmV7fQxEkB9Al9KJYAvrHLYVDM0myqOFipRV8IU7YDzAWJwAOUVQN
         nC5zMe+M8ggTaMJQELs6eFPRdsXLw7thjtp5or6N5cOyibDoM9hn/B4mGcxcn+pY5Nfc
         2evo/YsXD+grM+2WchguXFlrAWrg4j0KNdyak=
Received: by 10.114.111.1 with SMTP id j1mr3585091wac.79.1242857222310;
        Wed, 20 May 2009 15:07:02 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id n9sm3897836wag.34.2009.05.20.15.06.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:07:01 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 14/27] enable serial port support of loongson-based machines
Date:	Thu, 21 May 2009 06:06:51 +0800
Message-Id: <e048c1385e4a11718beaed7b3180d8bfd07a7bd4.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

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
 arch/mips/loongson/common/serial.c            |   64 +++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/common/serial.c

diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index bb3dd37..73ff14d 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -18,6 +18,8 @@
 #define MACH_NAME			"lemote-fuloong(2e)"
 
 #define LOONGSON_UART_BASE		0x1fd003f8
+#define	LOONGSON_UART_BAUD		1843200
+#define	LOONGSON_UART_IOTYPE		UPIO_PORT
 
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)
 #define LOONGSON_UART_IRQ		(MIPS_CPU_IRQ_BASE + 4)
@@ -30,6 +32,8 @@
 #define MACH_NAME			"lemote-fuloong(2f)"
 
 #define LOONGSON_UART_BASE		0x1fd002f8
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
index 71a4ea7..06ae7f6 100644
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
index 0000000..335dbe3
--- /dev/null
+++ b/arch/mips/loongson/common/serial.c
@@ -0,0 +1,64 @@
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
+		uart8250_data[0].iobase = LOONGSON_UART_BASE & 0x3ff;
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
1.6.2.1
