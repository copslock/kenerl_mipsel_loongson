Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:15:43 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.175]:19864 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023389AbZEOWPg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:15:36 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1226652wfa.21
        for <multiple recipients>; Fri, 15 May 2009 15:15:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=5IrUQySshLidzFHQP9/WLrslJaq93hNYj05UIIZwk94=;
        b=QpBDGbw2PTbt71LWkD2/bvf6IKlbkNb+xkB/wFnpopp75eXBEPZQqDHqSd+BydECyN
         yz1MUWsrGsaA5RSB9NNGKfuPItuR8VrTTdkV0O7oG41OKcv5WOofa0rxlmDir7MZhpxI
         N81IQv4GbEYsa9qHiQCmPOAbFZ+RIbeiyra+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=EQhw/1jodcVvROkenKwETru/cEvrcyDtuf2V2KhR3OLI9jkEg6KMRIpnyVqZrS+3uT
         H1y+xNUf5Ouj1kBTuCZ2rl0ts0X7oTVzd+UiJ+IZEXw8aH6D8tswgReHIFzD/2viKYyr
         XnJZFd6BocKRT1+CiPb8egAgzWou2tdK7vuJk=
Received: by 10.142.211.7 with SMTP id j7mr732245wfg.247.1242425734290;
        Fri, 15 May 2009 15:15:34 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 30sm409155wfd.21.2009.05.15.15.15.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:15:33 -0700 (PDT)
Subject: [PATCH 17/30] loongson: add basic yeeloong(2f) laptop support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:15:26 +0800
Message-Id: <1242425726.10164.158.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 3bb8e10be8d78925bfd6c903a4795b1382211616 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:14:41 +0800
Subject: [PATCH 17/30] loongson: add basic yeeloong(2f) laptop support

yeeloong(2f) laptop is also a Loongson2F base machine and made by
lemote.com.

the board of yeeloong(2f) is similiar to fuloong(2f) mini PC, it has an
AMD
cs5536 south bridge and have an extra Embedded Controller(EC).

so, the difference of the source code of yeeloong(2f) and fuloong(2f) is
very
small except:

1. the reboot/halt operation is controlled by and Embedded Controller in
yeeloong(2f), but in fuloong(2f), by cs5536 directly.

2. there is no serial port device can be used directly in yeeloong(2f),
but you
can joint one for there is an cpu serial port provided by loongson2f.
the
address is 0x1ff003f8,you can enable it in kernel via
CONFIG_SERIAL_8250.

3. yeeloong(2f) use a SMI video card, the driver source code will be
added
later.
---
 arch/mips/Makefile                            |    1 +
 arch/mips/include/asm/mach-loongson/machine.h |   66 ++++++---
 arch/mips/loongson/Kconfig                    |   47 ++++++-
 arch/mips/loongson/Makefile                   |    6 +
 arch/mips/loongson/common/cmdline.c           |   12 ++
 arch/mips/loongson/yeeloong-2f/Makefile       |    5 +
 arch/mips/loongson/yeeloong-2f/init.c         |   69 +++++++++
 arch/mips/loongson/yeeloong-2f/irq.c          |   57 ++++++++
 arch/mips/loongson/yeeloong-2f/reset.c        |   42 ++++++
 arch/mips/pci/Makefile                        |    3 +-
 arch/mips/pci/fixup-fuloong2f.c               |  189
-------------------------
 arch/mips/pci/fixup-lemote2f.c                |  189
+++++++++++++++++++++++++
 12 files changed, 475 insertions(+), 211 deletions(-)
 create mode 100644 arch/mips/loongson/yeeloong-2f/Makefile
 create mode 100644 arch/mips/loongson/yeeloong-2f/init.c
 create mode 100644 arch/mips/loongson/yeeloong-2f/irq.c
 create mode 100644 arch/mips/loongson/yeeloong-2f/reset.c
 delete mode 100644 arch/mips/pci/fixup-fuloong2f.c
 create mode 100644 arch/mips/pci/fixup-lemote2f.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index abf16c1..d73f084 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -311,6 +311,7 @@ cflags-$(CONFIG_LOONGSON_SYSTEMS) += -I
$(srctree)/arch/mips/include/asm/mach-loo
 					-mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
 load-$(CONFIG_LEMOTE_FULOONG2F) +=0xffffffff80200000
+load-$(CONFIG_LEMOTE_YEELOONG2F) +=0xffffffff80200000
 
 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-loongson/machine.h
b/arch/mips/include/asm/mach-loongson/machine.h
index cb48d9b..b844d1e 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -27,7 +27,7 @@
 #define LOONGSON_TIMER_IRQ        	(MIPS_CPU_IRQ_BASE + 7)
 #define LOONGSON_DMATIMEOUT_IRQ   	(LOONGSON_IRQ_BASE + 10) 
 
-#else /* CONFIG_LEMOTE_FULOONG2F */
+#elif defined(CONFIG_LEMOTE_FULOONG2F)
 
 #define MACH_NAME			"lemote-fuloong(2f)"
 
@@ -35,27 +35,55 @@
 #define LOONGSON_UART_BAUD		1843200
 #define LOONGSON_UART_IOTYPE		UPIO_PORT
 
-#define LOONGSON_TIMER_IRQ		(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
+#else /* CONFIG_CPU_YEELOONG2F */
+
+#define MACH_NAME			"lemote-yeeloong(2f)"
+
+/* yeeloong use the CPU serial port of Loongson2F */
+#define LOONGSON_UART_BASE		0x1ff003f8
+#define LOONGSON_UART_BAUD		3686400	
+#define LOONGSON_UART_IOTYPE		UPIO_MEM
+
+/* 
+ * The following registers are determined by the EC index
configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from
it.
+ */
+#define	EC_IO_PORT_HIGH	0x0381
+#define	EC_IO_PORT_LOW	0x0382
+#define	EC_IO_PORT_DATA	0x0383
+#define	REG_RESET_HIGH	0xF4	/* reset the machine auto-clear : rd/wr */
+#define REG_RESET_LOW	0xEC
+#define	BIT_RESET_ON	(1 << 0)
+
+#endif	/* !CONFIG_LEMOTE_FULOONG2E */
+
+
+/* fuloong2f and yeeloong2f have the basic IRQ control interface */
+#if defined(CONFIG_LEMOTE_FULOONG2F) ||
defined(CONFIG_LEMOTE_YEELOONG2F)
+
+#define	LOONGSON_TIMER_IRQ		(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
 #define LOONGSON_PERFCNT_IRQ		(MIPS_CPU_IRQ_BASE + 6)	/* cpu perf
counter */
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
-#define LOONGSON_UART_IRQ		(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port
*/
+#define	LOONGSON_UART_IRQ		(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port
*/
 #define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
 
-#define LOONGSON_INT_BIT_GPIO1		(1 << 1)
-#define LOONGSON_INT_BIT_GPIO2		(1 << 2)
-#define LOONGSON_INT_BIT_GPIO3		(1 << 3)
-#define LOONGSON_INT_BIT_PCI_INTA	(1 << 4)
-#define LOONGSON_INT_BIT_PCI_INTB	(1 << 5)
-#define LOONGSON_INT_BIT_PCI_INTC	(1 << 6)
-#define LOONGSON_INT_BIT_PCI_INTD	(1 << 7)
-#define LOONGSON_INT_BIT_PCI_PERR	(1 << 8)
-#define LOONGSON_INT_BIT_PCI_SERR	(1 << 9)
-#define LOONGSON_INT_BIT_DDR		(1 << 10)
-#define LOONGSON_INT_BIT_INT0		(1 << 11)
-#define LOONGSON_INT_BIT_INT1		(1 << 12)
-#define LOONGSON_INT_BIT_INT2		(1 << 13)
-#define LOONGSON_INT_BIT_INT3		(1 << 14)
-
-#endif
+#define	LOONGSON_INT_BIT_GPIO1		(1 << 1)
+#define	LOONGSON_INT_BIT_GPIO2		(1 << 2)
+#define	LOONGSON_INT_BIT_GPIO3		(1 << 3)
+#define	LOONGSON_INT_BIT_PCI_INTA	(1 << 4)
+#define	LOONGSON_INT_BIT_PCI_INTB	(1 << 5)
+#define	LOONGSON_INT_BIT_PCI_INTC	(1 << 6)
+#define	LOONGSON_INT_BIT_PCI_INTD	(1 << 7)
+#define	LOONGSON_INT_BIT_PCI_PERR	(1 << 8)
+#define	LOONGSON_INT_BIT_PCI_SERR	(1 << 9)
+#define	LOONGSON_INT_BIT_DDR		(1 << 10)
+#define	LOONGSON_INT_BIT_INT0		(1 << 11)
+#define	LOONGSON_INT_BIT_INT1		(1 << 12)
+#define	LOONGSON_INT_BIT_INT2		(1 << 13)
+#define	LOONGSON_INT_BIT_INT3		(1 << 14)
+
+#endif	/* ! defined(CONFIG_LEMOTE_FULOONG2F) ||
defined(CONFIG_LEMOTE_YEELOONG2F) */
 
 #endif				/* ! __MACHINE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 42a5309..2622017 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -24,9 +24,11 @@ config LEMOTE_FULOONG2E
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select CPU_HAS_WB
 	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
+	  Lemote Fuloong(2e) mini-PC board based on the Chinese Loongson-2E
CPU and
 	  an FPGA northbridge
 
+	  Lemote Fuloong(2e) mini PC have a VIA686B south bridge.
+
 config LEMOTE_FULOONG2F
 	bool "Lemote Fuloong(2f) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
@@ -50,9 +52,50 @@ config LEMOTE_FULOONG2F
 	select CPU_HAS_WB
 	select CS5536
 	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2F CPU
+	  Lemote Fuloong(2f) mini-PC board based on the Chinese Loongson-2F
+	  CPU, which has an internal DDR and PCIX controller. the PCIX
+	  controller have the similiar programming interface of the FPGA north
+	  bridge of LOONGSON2E. 
+
+	  Lemote Fuloong(2f) mini PC have an AMD CS5536 south bridge.
+
+config LEMOTE_YEELOONG2F
+	bool "Lemote Yeeloong(2f) mini Notebook"
+	select ARCH_SPARSEMEM_ENABLE
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON2F
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HW_HAS_PCI
+	select I8259
+	select ISA 
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_HAS_MACH_PROM_INIT_CMDLINE
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select CPU_HAS_WB
+	select CS5536
+	help
+	  Lemote Laptop based on the Chinese Loongson-2F CPU, which has an
+	  internal DDR and PCIX controller. the PCIX controller have the
+	  similiar programming interface of the FPGA north bridge of
+	  LOONGSON2E. 
+
+
+	  Lemote Yeeloong(2f) laptop have an AMD CS5536 south bridge and an EC
+	  controller.
 
 endchoice
 
 config CS5536
 	bool
+
+config SYS_HAS_MACH_PROM_INIT_CMDLINE
+	bool
diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
index e9b8a81..7178edb 100644
--- a/arch/mips/loongson/Makefile
+++ b/arch/mips/loongson/Makefile
@@ -15,3 +15,9 @@ obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fuloong-2e/
 #
 
 obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fuloong-2f/
+
+#
+# Lemote Yeeloong mini-PC (Loongson 2F-based)
+#
+
+obj-$(CONFIG_LEMOTE_YEELOONG2F)	+= yeeloong-2f/
diff --git a/arch/mips/loongson/common/cmdline.c
b/arch/mips/loongson/common/cmdline.c
index 28bcf6f..9945fd8 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -30,6 +30,15 @@ int prom_argc;
 /* pmon passes arguments in 32bit pointers */
 int *_prom_argv, *_prom_envp;
 
+/* machine-specific command line initialization */
+#ifdef CONFIG_SYS_HAS_MACH_PROM_INIT_CMDLINE
+extern void __init mach_prom_init_cmdline(void);
+#else
+void __init mach_prom_init_cmdline(void)
+{
+}
+#endif
+
 #define parse_even_earlier(res, option, p)				\
 do {									\
 	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
@@ -56,6 +65,9 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " ");
 	}
 
+	/* machine specific prom_init_cmdline */
+	mach_prom_init_cmdline();
+
 	/* handle console, root, busclock, cpuclock, memsize, highmemsize
arguments */
 	if ((strstr(arcs_cmdline, "console=")) == NULL)
 		strcat(arcs_cmdline, " console=ttyS0,115200");
diff --git a/arch/mips/loongson/yeeloong-2f/Makefile
b/arch/mips/loongson/yeeloong-2f/Makefile
new file mode 100644
index 0000000..624affd
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for fuloong-2f
+#
+
+obj-y += init.o irq.o reset.o
diff --git a/arch/mips/loongson/yeeloong-2f/init.c
b/arch/mips/loongson/yeeloong-2f/init.c
new file mode 100644
index 0000000..fa4998a
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/init.c
@@ -0,0 +1,69 @@
+/*
+ * board specific init routines 
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com 
+ *
+ *  This program is free software; you can redistribute  it and/or
modify it
+ *  under  the terms of  the GNU General  Public License as published
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+
+#include <cs5536/cs5536.h>
+
+void __init mach_prom_init_cmdline(void)
+{
+	/* set lpc irq to quiet mode */
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LEG_IO), 0x00, 0x16000003);
+
+	/*Emulate post for usb */
+	_wrmsr(USB_MSR_REG(USB_CONFIG), 0x4, 0xBF000);
+
+	if (!strstr(arcs_cmdline, "no_auto_cmd")) {
+		unsigned char default_root[50] = "/dev/hda1";
+		char *pmon_ver, *ec_ver, *p, version[60], ec_version[64];
+
+		p = arcs_cmdline;
+
+		pmon_ver = strstr(arcs_cmdline, "PMON_VER");
+		if (pmon_ver) {
+			if ((p = strstr(pmon_ver, " ")))
+				*p++ = '\0';
+			strncpy(version, pmon_ver, 60);
+		} else
+			strncpy(version, "PMON_VER=Unknown", 60);
+
+		ec_ver = strstr(p, "EC_VER");
+		if (ec_ver) {
+			if ((p = strstr(ec_ver, " ")))
+				*p = '\0';
+			strncpy(ec_version, ec_ver, 64);
+		} else
+			strncpy(ec_version, "EC_VER=Unknown", 64);
+
+		p = strstr(arcs_cmdline, "root=");
+		if (p) {
+			strncpy(default_root, p, sizeof(default_root));
+			if ((p = strstr(default_root, " ")))
+				*p = '\0';
+		}
+
+		memset(arcs_cmdline, 0, sizeof(arcs_cmdline));
+		strcat(arcs_cmdline, version);
+		strcat(arcs_cmdline, " ");
+		strcat(arcs_cmdline, ec_version);
+		strcat(arcs_cmdline, " ");
+		strcat(arcs_cmdline, default_root);
+		strcat(arcs_cmdline, " console=tty2");
+		strcat(arcs_cmdline, " quiet");
+	}
+}
diff --git a/arch/mips/loongson/yeeloong-2f/irq.c
b/arch/mips/loongson/yeeloong-2f/irq.c
new file mode 100644
index 0000000..94a4def
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/irq.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or
modify it
+ *  under  the terms of  the GNU General  Public License as published
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+
+#include <linux/interrupt.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+inline int mach_i8259_irq(void)
+{
+	int irq, isr, imr;
+
+	irq = -1;
+
+	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
+		imr = inb(0x21) | (inb(0xa1) << 8);
+		isr = inb(0x20) | (inb(0xa0) << 8);
+		isr &= ~0x4;	/* irq2 for cascade */
+		isr &= ~imr;
+		irq = ffs(isr) - 1;
+	}
+
+	return irq;
+}
+
+extern void bonito_irqdispatch(void);
+extern void i8259_irqdispatch(void);
+
+inline void mach_irq_dispatch(unsigned int pending)
+{
+	if (pending & CAUSEF_IP7) {
+		do_IRQ( LOONGSON_TIMER_IRQ );
+	} else if (pending & CAUSEF_IP6) {	/* North Bridge, Performance
counter */
+		do_IRQ( LOONGSON_PERFCNT_IRQ );
+		bonito_irqdispatch();
+	} else if (pending & CAUSEF_IP3) {	/* CPU UART */
+		do_IRQ( LOONGSON_UART_IRQ );
+	} else if (pending & CAUSEF_IP2) {	/* South Bridge */
+		i8259_irqdispatch();
+	} else {
+		spurious_interrupt();
+	}
+}
+
+void __init set_irq_trigger_mode(void)
+{
+	/* setup cs5536 as high level trigger */
+	LOONGSON_INTPOL = LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1;
+	LOONGSON_INTEDGE &= ~(LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1);
+}
diff --git a/arch/mips/loongson/yeeloong-2f/reset.c
b/arch/mips/loongson/yeeloong-2f/reset.c
new file mode 100644
index 0000000..92ee57d
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/reset.c
@@ -0,0 +1,42 @@
+/* Board-specific reboot/shutdown routines 
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
+ * option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+void mach_prepare_reboot(void)
+{
+	/* 
+	 * reset cpu to full speed, this is needed when enabling cpu
frequency 
+	 * scalling
+	 */
+	LOONGSON_CHIPCFG0 |= 0x7;
+	
+	/* sending an reset signal to EC(embedded controller) */
+	writeb(REG_RESET_HIGH, (volatile u8 *)(mips_io_port_base +
EC_IO_PORT_HIGH));
+	writeb(REG_RESET_LOW, (volatile u8 *)(mips_io_port_base +
EC_IO_PORT_LOW));
+	mmiowb();
+	writeb(BIT_RESET_ON, (volatile u8 *)(mips_io_port_base +
EC_IO_PORT_DATA));
+	mmiowb();
+}
+
+void mach_prepare_shutdown(void)
+{
+	/* cpu-gpio0 output low */
+	LOONGSON_GPIODATA &= ~0x00000001;
+	/* cpu-gpio0 as output */
+	LOONGSON_GPIOIE &= ~0x00000001;
+}
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index b96ed14..3b95ba9 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -27,7 +27,8 @@ obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o
ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
-obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fixup-fuloong2f.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fixup-lemote2f.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_YEELOONG2F)+= fixup-lemote2f.o ops-loongson2.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fuloong2f.c
b/arch/mips/pci/fixup-fuloong2f.c
deleted file mode 100644
index 8118e91..0000000
--- a/arch/mips/pci/fixup-fuloong2f.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- * Copyright (C) 2008 Lemote Technology
- * Copyright (C) 2004 ICT CAS
- * Author: Li xiaoyu, lixy@ict.ac.cn
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or
modify it
- *  under  the terms of  the GNU General  Public License as published
by the
- *  Free Software Foundation;  either version 2 of the  License, or (at
your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <loongson.h>
-#include <cs5536/cs5536.h>
-
-/* 
- * PCI interrupt pins 
- *
- * These should not be changed, or you should consider loongson2f
interrupt register and
- * your pci card dispatch
- */
-#define PCIA		4
-#define PCIB		5
-#define PCIC		6
-#define PCID		7
-
-/* all the pci device has the PCIA pin, check the datasheet. */
-static char irq_tab[][5] __initdata = {
-	/*      INTA    INTB    INTC    INTD */
-	{0, 0, 0, 0, 0},	/*  11: Unused */
-	{0, 0, 0, 0, 0},	/*  12: Unused */
-	{0, 0, 0, 0, 0},	/*  13: Unused */
-	{0, 0, 0, 0, 0},	/*  14: Unused */
-	{0, 0, 0, 0, 0},	/*  15: Unused */
-	{0, 0, 0, 0, 0},	/*  16: Unused */
-	{0, PCIA, 0, 0, 0},	/*  17: RTL8110-0 */
-	{0, PCIB, 0, 0, 0},	/*  18: RTL8110-1 */
-	{0, PCIC, 0, 0, 0},	/*  19: SiI3114 */
-	{0, PCID, 0, 0, 0},	/*  20: 3-ports nec usb */
-	{0, PCIA, PCIB, PCIC, PCID},	/*  21: PCI-SLOT */
-	{0, 0, 0, 0, 0},	/*  22: Unused */
-	{0, 0, 0, 0, 0},	/*  23: Unused */
-	{0, 0, 0, 0, 0},	/*  24: Unused */
-	{0, 0, 0, 0, 0},	/*  25: Unused */
-	{0, 0, 0, 0, 0},	/*  26: Unused */
-	{0, 0, 0, 0, 0},	/*  27: Unused */
-};
-
-int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int virq;
-
-	if ((PCI_SLOT(dev->devfn) != (14)) && (PCI_SLOT(dev->devfn) < 32)) {
-		virq = irq_tab[slot][pin];
-		printk("slot: %d, pin: %d, irq: %d\n", slot, pin,
-		       virq + LOONGSON_IRQ_BASE);
-		if (virq != 0)
-			return (LOONGSON_IRQ_BASE + virq);
-		else
-			return 0;
-	} else if (PCI_SLOT(dev->devfn) == 14) {	/*  cs5536 */
-		switch (PCI_FUNC(dev->devfn)) {
-		case 2:
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
-			return 14;	/*  for IDE */
-		case 3:
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
-			return 9;	/*  for AUDIO */
-		case 4:	/*  for OHCI */
-		case 5:	/*  for EHCI */
-		case 6:	/*  for UDC */
-		case 7:	/*  for OTG */
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
-			return 11;
-		}
-		return dev->irq;
-	} else {
-		printk(" strange pci slot number.\n");
-		return 0;
-	}
-}
-
-/* Do platform specific device initialization at pci_enable_device()
time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
-/* CS5536 SPEC. fixup */
-static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
-{
-	/* the uart1 and uart2 interrupt in PIC is enabled as default */
-	pci_write_config_dword(pdev, 0x50, 1);
-	pci_write_config_dword(pdev, 0x54, 1);
-	/* enable the pci MASTER ABORT/ TARGET ABORT etc. */
-	/* pci_write_config_dword(pdev, 0x58, 1); */
-	return;
-}
-
-static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
-{
-	/* setting the mutex pin as IDE function */
-	/* the IDE interrupt in PIC is enabled as default */
-	pci_write_config_dword(pdev, 0x40, 0xDEADBEEF);
-	return;
-}
-
-static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
-{
-	u8 val;
-
-	/* enable the AUDIO interrupt in PIC  */
-	pci_write_config_dword(pdev, 0x50, 1);
-
-#if 1
-	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
-	printk("cs5536 acc latency %x\n", val);
-	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
-#endif
-	return;
-}
-
-static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
-{
-	/* enable the OHCI interrupt in PIC */
-	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
-	pci_write_config_dword(pdev, 0x50, 1);
-	return;
-}
-
-static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
-{
-	u32 hi, lo;
-
-	/* Serial short detect enable */
-	_rdmsr(USB_MSR_REG(USB_CONFIG), &hi, &lo);
-	_wrmsr(USB_MSR_REG(USB_CONFIG), (1 << 1) | (1 << 2) | (1 << 3), lo);
-
-#if 0
-	{
-		u32 bar;
-		void __iomem *base;
-
-		/* Write to clear diag register */
-		_rdmsr(USB_MSR_REG(USB_DIAG), &hi, &lo);
-		_wrmsr(USB_MSR_REG(USB_DIAG), hi, lo);
-
-		pci_read_config_dword(pdev, 0x10, &bar);
-		base = ioremap_nocache(bar, 0x100);
-
-		/* Make HCCAPARMS writable */
-		writel(readl(base + 0xA0) | (1 << 1), (base + 0xA0));
-
-		/* EECP=50h, IST=01h, ASPC=1h */
-		writel(0x00000012, base + 0x08);
-		iounmap(base);
-	}
-#endif
-
-	/* setting the USB2.0 micro frame length */
-	pci_write_config_dword(pdev, 0x60, 0x2000);
-	return;
-}
-
-static void __init loongson_nec_fixup(struct pci_dev *pdev)
-{
-	unsigned int val;
-
-	pci_read_config_dword(pdev, 0xe0, &val);
-	/* Only 2 port be used */
-	pci_write_config_dword(pdev, 0xe0, (val & ~3) | 0x2);
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_ISA,
-			 loongson_cs5536_isa_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_OHC,
-			 loongson_cs5536_ohci_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_EHC,
-			 loongson_cs5536_ehci_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_AUDIO,
-			 loongson_cs5536_acc_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_IDE,
-			 loongson_cs5536_ide_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
-			 loongson_nec_fixup);
diff --git a/arch/mips/pci/fixup-lemote2f.c
b/arch/mips/pci/fixup-lemote2f.c
new file mode 100644
index 0000000..8118e91
--- /dev/null
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -0,0 +1,189 @@
+/*
+ * Copyright (C) 2008 Lemote Technology
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or
modify it
+ *  under  the terms of  the GNU General  Public License as published
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <loongson.h>
+#include <cs5536/cs5536.h>
+
+/* 
+ * PCI interrupt pins 
+ *
+ * These should not be changed, or you should consider loongson2f
interrupt register and
+ * your pci card dispatch
+ */
+#define PCIA		4
+#define PCIB		5
+#define PCIC		6
+#define PCID		7
+
+/* all the pci device has the PCIA pin, check the datasheet. */
+static char irq_tab[][5] __initdata = {
+	/*      INTA    INTB    INTC    INTD */
+	{0, 0, 0, 0, 0},	/*  11: Unused */
+	{0, 0, 0, 0, 0},	/*  12: Unused */
+	{0, 0, 0, 0, 0},	/*  13: Unused */
+	{0, 0, 0, 0, 0},	/*  14: Unused */
+	{0, 0, 0, 0, 0},	/*  15: Unused */
+	{0, 0, 0, 0, 0},	/*  16: Unused */
+	{0, PCIA, 0, 0, 0},	/*  17: RTL8110-0 */
+	{0, PCIB, 0, 0, 0},	/*  18: RTL8110-1 */
+	{0, PCIC, 0, 0, 0},	/*  19: SiI3114 */
+	{0, PCID, 0, 0, 0},	/*  20: 3-ports nec usb */
+	{0, PCIA, PCIB, PCIC, PCID},	/*  21: PCI-SLOT */
+	{0, 0, 0, 0, 0},	/*  22: Unused */
+	{0, 0, 0, 0, 0},	/*  23: Unused */
+	{0, 0, 0, 0, 0},	/*  24: Unused */
+	{0, 0, 0, 0, 0},	/*  25: Unused */
+	{0, 0, 0, 0, 0},	/*  26: Unused */
+	{0, 0, 0, 0, 0},	/*  27: Unused */
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int virq;
+
+	if ((PCI_SLOT(dev->devfn) != (14)) && (PCI_SLOT(dev->devfn) < 32)) {
+		virq = irq_tab[slot][pin];
+		printk("slot: %d, pin: %d, irq: %d\n", slot, pin,
+		       virq + LOONGSON_IRQ_BASE);
+		if (virq != 0)
+			return (LOONGSON_IRQ_BASE + virq);
+		else
+			return 0;
+	} else if (PCI_SLOT(dev->devfn) == 14) {	/*  cs5536 */
+		switch (PCI_FUNC(dev->devfn)) {
+		case 2:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
+			return 14;	/*  for IDE */
+		case 3:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
+			return 9;	/*  for AUDIO */
+		case 4:	/*  for OHCI */
+		case 5:	/*  for EHCI */
+		case 6:	/*  for UDC */
+		case 7:	/*  for OTG */
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+			return 11;
+		}
+		return dev->irq;
+	} else {
+		printk(" strange pci slot number.\n");
+		return 0;
+	}
+}
+
+/* Do platform specific device initialization at pci_enable_device()
time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/* CS5536 SPEC. fixup */
+static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
+{
+	/* the uart1 and uart2 interrupt in PIC is enabled as default */
+	pci_write_config_dword(pdev, 0x50, 1);
+	pci_write_config_dword(pdev, 0x54, 1);
+	/* enable the pci MASTER ABORT/ TARGET ABORT etc. */
+	/* pci_write_config_dword(pdev, 0x58, 1); */
+	return;
+}
+
+static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
+{
+	/* setting the mutex pin as IDE function */
+	/* the IDE interrupt in PIC is enabled as default */
+	pci_write_config_dword(pdev, 0x40, 0xDEADBEEF);
+	return;
+}
+
+static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
+{
+	u8 val;
+
+	/* enable the AUDIO interrupt in PIC  */
+	pci_write_config_dword(pdev, 0x50, 1);
+
+#if 1
+	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
+	printk("cs5536 acc latency %x\n", val);
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
+#endif
+	return;
+}
+
+static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
+{
+	/* enable the OHCI interrupt in PIC */
+	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
+	pci_write_config_dword(pdev, 0x50, 1);
+	return;
+}
+
+static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
+{
+	u32 hi, lo;
+
+	/* Serial short detect enable */
+	_rdmsr(USB_MSR_REG(USB_CONFIG), &hi, &lo);
+	_wrmsr(USB_MSR_REG(USB_CONFIG), (1 << 1) | (1 << 2) | (1 << 3), lo);
+
+#if 0
+	{
+		u32 bar;
+		void __iomem *base;
+
+		/* Write to clear diag register */
+		_rdmsr(USB_MSR_REG(USB_DIAG), &hi, &lo);
+		_wrmsr(USB_MSR_REG(USB_DIAG), hi, lo);
+
+		pci_read_config_dword(pdev, 0x10, &bar);
+		base = ioremap_nocache(bar, 0x100);
+
+		/* Make HCCAPARMS writable */
+		writel(readl(base + 0xA0) | (1 << 1), (base + 0xA0));
+
+		/* EECP=50h, IST=01h, ASPC=1h */
+		writel(0x00000012, base + 0x08);
+		iounmap(base);
+	}
+#endif
+
+	/* setting the USB2.0 micro frame length */
+	pci_write_config_dword(pdev, 0x60, 0x2000);
+	return;
+}
+
+static void __init loongson_nec_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	pci_read_config_dword(pdev, 0xe0, &val);
+	/* Only 2 port be used */
+	pci_write_config_dword(pdev, 0xe0, (val & ~3) | 0x2);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_ISA,
+			 loongson_cs5536_isa_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_OHC,
+			 loongson_cs5536_ohci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_EHC,
+			 loongson_cs5536_ehci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+			 loongson_cs5536_acc_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_IDE,
+			 loongson_cs5536_ide_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+			 loongson_nec_fixup);
-- 
1.6.2.1
