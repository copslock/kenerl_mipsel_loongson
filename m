Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:19:32 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:60124 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493050AbZJPGR7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:17:59 +0200
Received: by mail-px0-f187.google.com with SMTP id 17so681981pxi.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:17:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Gl702Hj8KL4XAZlK4n2aPgmxz1eg4jWpfir6mL6A2dI=;
        b=iAc6m+atGXS1aVDLdwBb9Ox6kQmUZDwVO3r2u3HeI0UA51167e5aeBQCjrmLVHsNZg
         fRcc9Wb+ebfkHumcAS6RACXPZQzvuS5SkrEWVxWsK+DIJ62bweqpy0QNEwfPs8lo/Uhn
         KhuWfr9qyterzqhOpVr//q6TzCJ/8FXLcds4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DM/BbCeJQxLXeU8ipFDBCynGIMj0/Swr6jZkVX/rbJX22+3y29GXYAHNHg/3qcCTsq
         qhwjV8sR+PPmtaQL7OcjZK93z75fdaVXbRsT1Ca1auD7fpkLvAtdOWFdtDZXDwGCwoiA
         +20iAtCTHQFIVV6bYsYbTQl6h9qtor17fWYw0=
Received: by 10.114.248.7 with SMTP id v7mr1231068wah.92.1255673878818;
        Thu, 15 Oct 2009 23:17:58 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:17:58 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 5/7] [loongson] add serial port support
Date:	Fri, 16 Oct 2009 14:17:18 +0800
Message-Id: <35c04cb5cd3aa4c2d2fc3cbb471304a7f3434ebb.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
 <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
 <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
 <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
 <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add serial port support for all of the existing loongson
family machines. most of the board specific part are put in serial.c,
and the base address of the serial ports are defined as macros in
machine.h for sharing it between serial.c and early_printk.c

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/Makefile |    5 +++
 arch/mips/loongson/common/serial.c |   71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/serial.c

diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index adbe85c..b61502a 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -9,3 +9,8 @@ obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
 # Early printk support
 #
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o dbg.o
+
+#
+# Enable serial port
+#
+obj-$(CONFIG_SERIAL_8250) += serial.o
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
new file mode 100644
index 0000000..6d341e4
--- /dev/null
+++ b/arch/mips/loongson/common/serial.c
@@ -0,0 +1,71 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
+ *
+ * Copyright (C) 2009 Lemote, Inc.
+ * Author: Yan hua (yanhua@lemote.com)
+ * Author: Wu Zhangjin (wuzj@lemote.com)
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+#define PORT(int)			\
+{								\
+	.irq		= int,					\
+	.uartclk	= 1843200,				\
+	.iobase		= (LOONGSON_UART_BASE - LOONGSON_PCIIO_BASE),\
+	.iotype		= UPIO_PORT,				\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
+	.regshift	= 0,					\
+}
+
+#define PORT_M(int)				\
+{								\
+	.irq		= MIPS_CPU_IRQ_BASE + (int),		\
+	.uartclk	= 3686400,				\
+	.iotype		= UPIO_MEM,				\
+	.membase	= (void __iomem *)NULL,			\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
+	.regshift	= 0,					\
+}
+
+static struct plat_serial8250_port uart8250_data[][2] = {
+	[MACH_LOONGSON_UNKNOWN]         {},
+	[MACH_LEMOTE_FL2E]              {PORT(4), {} },
+	[MACH_LEMOTE_FL2F]              {PORT(3), {} },
+	[MACH_LEMOTE_ML2F7]             {PORT_M(3), {} },
+	[MACH_LEMOTE_YL2F89]            {PORT_M(3), {} },
+	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
+	[MACH_LOONGSON_END]             {},
+};
+
+static struct platform_device uart8250_device = {
+	.name = "serial8250",
+	.id = PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = uart8250_data[LOONGSON_MACHTYPE],
+		},
+};
+
+static int __init serial_init(void)
+{
+	if (uart8250_data[LOONGSON_MACHTYPE][0].iotype == UPIO_MEM)
+		uart8250_data[LOONGSON_MACHTYPE][0].membase =
+			ioremap_nocache(LOONGSON_UART_BASE, 8);
+
+	platform_device_register(&uart8250_device);
+
+	return 0;
+}
+
+device_initcall(serial_init);
-- 
1.6.2.1
