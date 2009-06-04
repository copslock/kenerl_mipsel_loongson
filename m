Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:09:39 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:41294 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021635AbZFDNIZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:08:25 +0100
Received: by pzk40 with SMTP id 40so739949pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:08:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ryyzcq7u0TgTtUxxq2vWN+ZLgwrRJjKVJphIYqqBQQE=;
        b=sruyAG3QtI2foP4RYhrLElPsLZPfs8w0qoAQmjb8mqpp2aITxVctZX9pFiLRl8lqPc
         0RMmBa0Kzm3VavIJha8D9GFHP9X2i2V2QRZLtBaIO+5ByIPLxG67fwkIBSqLRNBlCQ+X
         JfuorVW4FyMyV92AROYgvf0aQu6OrTbtPDs6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c4qOCS6DILE1mrSB9Azugpv6Qd05pJTcBh0pbSu7+b2uo6lBbzWvpGGX92TacrJ1/2
         cCUtfVZHa7DekhPBjntOJYVjICb7s9yvmRCRM6x4+GLMkQu3n3iRsZi5BcIOvFE7mmc+
         U8Hb+cg2n7Aw6ppWTbR/iT1szI0tMGqb9kclE=
Received: by 10.114.152.17 with SMTP id z17mr3424677wad.91.1244120897543;
        Thu, 04 Jun 2009 06:08:17 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id n33sm3231667wag.32.2009.06.04.06.08.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:08:16 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [loongson-PATCH-v3 17/25] add a machtype kernel command line argument
Date:	Thu,  4 Jun 2009 21:08:03 +0800
Message-Id: <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

the difference between yeeloong-7inch and yeeloong-8.9inch is very
small, only including the screen size and shutdown logic. so, it's very
important to share the same kernel image file between them instead of
adding some new kernel config options. benefit from this, the
distribution developers only have a need to compile the kernel one time.

to share the same kernel image file between yeelooong-7inch and
yeeloong-8.9inch, there is a need to add a kernel command line, here I
name is machtype, it works like this:

	machtype=lemote-yeeloong-2f-7inch
	      company - product - cpu revision - size

so, we can choose a suitable vga mode for the screen of different size
by default via this kernel command line in prom_init, here exactly is
mach_prom_init_cmdline in arch/mips/loongson/yeeloong-2f/init.c.

the vga command line will be used later in the SMI video driver to
choose a suitable screen resolution ratio.

and also, we can get the true machine name via this kenrel command line
argument.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 Documentation/kernel-parameters.txt            |    4 ++
 arch/mips/include/asm/mach-loongson/machine.h  |   32 ++-----------
 arch/mips/include/asm/mach-loongson/machtype.h |   32 +++++++++++++
 arch/mips/loongson/Kconfig                     |   12 -----
 arch/mips/loongson/common/Makefile             |    2 +-
 arch/mips/loongson/common/init.c               |    4 --
 arch/mips/loongson/common/machtype.c           |   58 ++++++++++++++++++++++++
 arch/mips/loongson/common/misc.c               |   15 ------
 arch/mips/loongson/yeeloong-2f/init.c          |   13 +++++-
 arch/mips/loongson/yeeloong-2f/reset.c         |   40 +++++++++++++----
 10 files changed, 142 insertions(+), 70 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/machtype.h
 create mode 100644 arch/mips/loongson/common/machtype.c
 delete mode 100644 arch/mips/loongson/common/misc.c

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fd5cac0..a4b7104 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1220,6 +1220,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
 
+	machtype=	[Loongson] Share the same kernel image file between different
+			 yeeloong laptop.
+			Example: machtype=lemote-yeeloong-2f-7inch
+
 	max_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory greater
 			than or equal to this physical address is ignored.
 
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 15d8b93..9f8a607 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_LEMOTE_FULOONG2E
 
-#define MACH_NAME			"lemote-fuloong(2e)"
+#define MACH_NAME	MACHNAME(LEMOTE, FULOONG, LOONGSON_2E, UNKNOWN)
 
 #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x3f8)
 #define	LOONGSON_UART_BAUD		1843200
@@ -29,7 +29,7 @@
 
 #elif defined(CONFIG_LEMOTE_FULOONG2F)
 
-#define MACH_NAME			"lemote-fuloong(2f)"
+#define MACH_NAME	MACHNAME(LEMOTE, FULOONG, LOONGSON_2F, UNKNOWN)
 
 #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x2f8)
 #define LOONGSON_UART_BAUD		1843200
@@ -37,38 +37,14 @@
 
 #else /* CONFIG_CPU_YEELOONG2F */
 
-#define MACH_NAME			"lemote-yeeloong(2f)"
+/* by default, set it as 8.9INCH? or UNKNOWN? */
+#define MACH_NAME	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _89INCH)
 
 /* yeeloong use the CPU serial port of Loongson2F */
 #define LOONGSON_UART_BASE		(LOONGSON_LIO1_BASE + 0x3f8)
 #define	LOONGSON_UART_BAUD		3686400
 #define LOONGSON_UART_IOTYPE		UPIO_MEM
 
-/*
- * The following registers are determined by the EC index configuration.
- * 1, fill the PORT_HIGH as EC register high part.
- * 2, fill the PORT_LOW as EC register low part.
- * 3, fill the PORT_DATA as EC register write data or get the data from it.
- */
-#define	EC_RESET_IO_PORT_HIGH	0x0381
-#define	EC_RESET_IO_PORT_LOW	0x0382
-#define	EC_RESET_IO_PORT_DATA	0x0383
-#define	REG_RESET_HIGH	0xF4	/* reset the machine auto-clear : rd/wr */
-#define REG_RESET_LOW	0xEC
-#define	BIT_RESET_ON	(1 << 0)
-
-/* 7inch yeeloong have the different shutdown hardware logic from 8.9inch */
-#ifdef CONFIG_LEMOTE_YEELOONG2F_7INCH
-
-#define	EC_SHUTDOWN_IO_PORT_HIGH	0xff2d
-#define	EC_SHUTDOWN_IO_PORT_LOW		0xff2e
-#define	EC_SHUTDOWN_IO_PORT_DATA	0xff2f
-#define	REG_SHUTDOWN_HIGH	0xFC
-#define REG_SHUTDOWN_LOW	0x29
-#define	BIT_SHUTDOWN_ON	(1 << 1)
-
-#endif
-
 #endif	/* !CONFIG_LEMOTE_FULOONG2E */
 
 /* fuloong2f and yeeloong2f have the same IRQ control interface */
diff --git a/arch/mips/include/asm/mach-loongson/machtype.h b/arch/mips/include/asm/mach-loongson/machtype.h
new file mode 100644
index 0000000..9f96926
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/machtype.h
@@ -0,0 +1,32 @@
+/*
+ * machine type header file
+ */
+
+#ifndef _MACHTYPE_H
+#define _MACHTYPE_H
+
+#define UNKNOWN		"unknown"
+
+/* company */
+#define LEMOTE		"lemote"
+#define DEXOON		"dexoon"
+
+/* product */
+#define FULOONG		"fuloong"
+#define YEELOONG	"yeeloong"
+#define	GDIUM		"gdium"
+
+/* cpu revision */
+#define LOONGSON_2E			"2e"
+#define LOONGSON_2F 		"2f"
+
+/* size */
+#define _7INCH			"7"
+#define	_89INCH			"8.9"
+
+#define MACHNAME_LEN	50
+
+#define MACHNAME(company, product, cpu, size) \
+	(company "-" product "-" cpu "-" size "inch\0")
+
+#endif /* ! _MACHTYPE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 63d00c1..9cc817f 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -93,18 +93,6 @@ config LEMOTE_YEELOONG2F
 
 endchoice
 
-choice
-	prompt "YeeLoong Type"
-	depends on LEMOTE_YEELOONG2F
-
-config LEMOTE_YEELOONG2F_89INCH
-	bool "8.9 inch"
-
-config LEMOTE_YEELOONG2F_7INCH
-	bool "7 inch"
-
-endchoice
-
 config CS5536
 	bool
 
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 2d3fa3e..df782d6 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
-	pci.o bonito-irq.o mem.o misc.o
+	pci.o bonito-irq.o mem.o machtype.o
 
 #
 # Early printk support
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index cbb33de..6fcfba0 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -18,7 +18,6 @@
 #include <linux/bootmem.h>
 
 #include <asm/bootinfo.h>
-#include <asm/cpu.h>
 
 #include <loongson.h>
 
@@ -35,9 +34,6 @@ static inline void set_loongson_addrwincfg_base(unsigned long base)
 
 void __init prom_init(void)
 {
-	/* init mach type, does we need to init it?? */
-	mips_machtype = PRID_IMP_LOONGSON2;
-
 	/* init several base address */
 	set_io_port_base((unsigned long)
 			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
new file mode 100644
index 0000000..d469dc7
--- /dev/null
+++ b/arch/mips/loongson/common/machtype.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <asm/cpu.h>
+
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+#include <machtype.h>
+#include <machine.h>
+
+static char machname[][MACHNAME_LEN] = {
+	MACHNAME(LEMOTE, FULOONG, LOONGSON_2E, UNKNOWN),
+	MACHNAME(LEMOTE, FULOONG, LOONGSON_2F, UNKNOWN),
+	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _89INCH),
+	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _7INCH),
+};
+
+#define MACHTYPE_TOTAL	(sizeof(machname)/MACHNAME_LEN)
+#define MACHTYPE_DEFAULT	-1
+
+const char *get_system_type(void)
+{
+	if (mips_machtype == MACHTYPE_DEFAULT)
+		return MACH_NAME;
+	else
+		return machname[mips_machtype];
+}
+
+static __init int machname_setup(char *str)
+{
+	int index;
+
+	if (!str)
+			return -EINVAL;
+
+	mips_machtype = MACHTYPE_DEFAULT;
+
+	for (index = 0;
+	     index < MACHTYPE_TOTAL;
+	     index++) {
+		if (strstr(str, machname[index]) != NULL) {
+			mips_machtype = index;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+__setup("machtype=", machname_setup);
diff --git a/arch/mips/loongson/common/misc.c b/arch/mips/loongson/common/misc.c
deleted file mode 100644
index 1b8044c..0000000
--- a/arch/mips/loongson/common/misc.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/* Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <machine.h>
-
-const char *get_system_type(void)
-{
-	return MACH_NAME;
-}
diff --git a/arch/mips/loongson/yeeloong-2f/init.c b/arch/mips/loongson/yeeloong-2f/init.c
index 3bdc354..80f8c5e 100644
--- a/arch/mips/loongson/yeeloong-2f/init.c
+++ b/arch/mips/loongson/yeeloong-2f/init.c
@@ -18,6 +18,7 @@
 #include <asm/bootinfo.h>
 
 #include <cs5536/cs5536.h>
+#include <machtype.h>
 
 void __init mach_prom_init_cmdline(void)
 {
@@ -27,7 +28,7 @@ void __init mach_prom_init_cmdline(void)
 	/*Emulate post for usb */
 	_wrmsr(USB_MSR_REG(USB_CONFIG), 0x4, 0xBF000);
 
-	if ((strstr(arcs_cmdline, "no_auto_cmd")) == NULL) {
+	if (strstr(arcs_cmdline, "no_auto_cmd") == NULL) {
 		unsigned char default_root[50] = "/dev/hda1";
 		char *pmon_ver, *ec_ver, *p, version[60], ec_version[64];
 
@@ -68,4 +69,14 @@ void __init mach_prom_init_cmdline(void)
 		strcat(arcs_cmdline, " console=tty2");
 		strcat(arcs_cmdline, " quiet");
 	}
+
+	/*
+	 * automatically pass the vga argument via machtype argument if
+	 * vga is not passed: yeeloong-7inch's vga mode is 800x480x24
+	 */
+
+	if ((strstr(arcs_cmdline, "vga") == NULL)
+			&& (strstr(arcs_cmdline, "machtype") != NULL)
+				&& (strstr(arcs_cmdline, _7INCH) != NULL))
+		strcat(arcs_cmdline, " vga=800x480x24");
 }
diff --git a/arch/mips/loongson/yeeloong-2f/reset.c b/arch/mips/loongson/yeeloong-2f/reset.c
index 294592f..124cf99 100644
--- a/arch/mips/loongson/yeeloong-2f/reset.c
+++ b/arch/mips/loongson/yeeloong-2f/reset.c
@@ -11,9 +11,32 @@
  */
 
 #include <linux/types.h>
+#include <asm/bootinfo.h>
 
 #include <loongson.h>
 #include <machine.h>
+#include <machtype.h>
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from it.
+ */
+#define	EC_RESET_IO_PORT_HIGH	0x0381
+#define	EC_RESET_IO_PORT_LOW	0x0382
+#define	EC_RESET_IO_PORT_DATA	0x0383
+#define	REG_RESET_HIGH	0xF4	/* reset the machine auto-clear : rd/wr */
+#define REG_RESET_LOW	0xEC
+#define	BIT_RESET_ON	(1 << 0)
+
+/* 7inch yeeloong have the different shutdown hardware logic from 8.9inch */
+#define	EC_SHUTDOWN_IO_PORT_HIGH	0xff2d
+#define	EC_SHUTDOWN_IO_PORT_LOW		0xff2e
+#define	EC_SHUTDOWN_IO_PORT_DATA	0xff2f
+#define	REG_SHUTDOWN_HIGH	0xFC
+#define REG_SHUTDOWN_LOW	0x29
+#define	BIT_SHUTDOWN_ON	(1 << 1)
 
 void mach_prepare_reboot(void)
 {
@@ -36,8 +59,12 @@ void mach_prepare_reboot(void)
 
 void mach_prepare_shutdown(void)
 {
-#ifdef CONFIG_LEMOTE_YEELOONG2F_7INCH
-	{
+	if (strstr(get_system_type(), _89INCH)) {
+		/* cpu-gpio0 output low */
+		LOONGSON_GPIODATA &= ~0x00000001;
+		/* cpu-gpio0 as output */
+		LOONGSON_GPIOIE &= ~0x00000001;
+	} else if (strstr(get_system_type(), _7INCH)) {
 		u8 val;
 		u64 i;
 
@@ -58,11 +85,6 @@ void mach_prepare_shutdown(void)
 		writeb(val | BIT_SHUTDOWN_ON,
 		       (u8 *) (mips_io_port_base + EC_SHUTDOWN_IO_PORT_DATA));
 		mmiowb();
-	}
-#else
-	/* cpu-gpio0 output low */
-	LOONGSON_GPIODATA &= ~0x00000001;
-	/* cpu-gpio0 as output */
-	LOONGSON_GPIOIE &= ~0x00000001;
-#endif
+	} else
+		printk(KERN_INFO "you can shutdown the power safely now!\n");
 }
-- 
1.6.0.4
