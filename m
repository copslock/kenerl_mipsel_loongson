Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:08:15 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:61924 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025192AbZETWII (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:08:08 +0100
Received: by pzk40 with SMTP id 40so630792pzk.22
        for <multiple recipients>; Wed, 20 May 2009 15:08:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/55x6ud780Kn9k/hV/3GeLnw6KRMkz8WZ/LnEZdJQDI=;
        b=PNVMvNYbKLvZj/hniTrcWlQ7QzZsdSKab9MdttJmX3ZZ7Rq3Bbk01BIfLWrnkPew+1
         72xEF+p086+BSm88QBk/AZVQIjI7Abts34Nhcfxycr6xIxUOm5gLt+dIb6D3gx0PPAxZ
         9ldtp5bqVolqEW8mP8wJFW7AyKnueZRZun1PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MgBLL5HW5EffoiS91klHRRQZkGlL8+gRAo6Zpc4al8Fd2FPX/Ri9QJzBsIE1Oe+p5R
         o9Ccy6be2QX+ZZzYGWeMeqZD/Y7kAa7AKqecy+C6FhQbqkqjhsV7oJivxzGKHrJHnwyq
         xB9+0Nuyi1ZwQEbw9Lt5gkx3g/+am+eobCbIQ=
Received: by 10.114.159.5 with SMTP id h5mr3596532wae.36.1242857280962;
        Wed, 20 May 2009 15:08:00 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id v9sm4032490wah.36.2009.05.20.15.07.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:08:00 -0700 (PDT)
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
Subject: [loongson-PATCH-v1 15/27] add basic yeeloong(2f) laptop support
Date:	Thu, 21 May 2009 06:07:49 +0800
Message-Id: <3926e01e650c35c7f1dc283e488be44c625cb808.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

yeeloong(2f) laptop is also a Loongson2F-based machine maded by
lemote.com.

the board of yeeloong(2f) is similiar to fuloong(2f) mini PC, it has an
AMD cs5536 south bridge and has an extra Embedded Controller(EC) for
power management, keyboard controlling and some other relative jobs.

so, the difference of the source code of yeeloong(2f) and fuloong(2f) is
very small except:

1. the reboot/halt operation is controlled by an Embedded Controller in
yeeloong(2f), but in fuloong(2f), by cs5536 directly.

2. there is no serial port device can be used directly in yeeloong(2f),
but you can joint one for there is an cpu serial port provided by
loongson2f.  the address is 0x1ff003f8, you can enable it in kernel via
CONFIG_SERIAL_8250.

3. yeeloong(2f) use a SMI video card, the driver source code will be added
later.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile                            |    1 +
 arch/mips/include/asm/mach-loongson/cmdline.h |    9 ++
 arch/mips/include/asm/mach-loongson/machine.h |   29 ++++-
 arch/mips/loongson/Kconfig                    |   46 +++++++-
 arch/mips/loongson/Makefile                   |    6 +
 arch/mips/loongson/common/cmdline.c           |    5 +
 arch/mips/loongson/yeeloong-2f/Makefile       |    5 +
 arch/mips/loongson/yeeloong-2f/init.c         |   71 ++++++++++
 arch/mips/loongson/yeeloong-2f/irq.c          |   53 ++++++++
 arch/mips/loongson/yeeloong-2f/reset.c        |   40 ++++++
 arch/mips/pci/Makefile                        |    3 +-
 arch/mips/pci/fixup-fuloong2f.c               |  171 -------------------------
 arch/mips/pci/fixup-lemote2f.c                |  171 +++++++++++++++++++++++++
 13 files changed, 435 insertions(+), 175 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/cmdline.h
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
@@ -311,6 +311,7 @@ cflags-$(CONFIG_LOONGSON_SYSTEMS) += -I$(srctree)/arch/mips/include/asm/mach-loo
 					-mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
 load-$(CONFIG_LEMOTE_FULOONG2F) +=0xffffffff80200000
+load-$(CONFIG_LEMOTE_YEELOONG2F) +=0xffffffff80200000
 
 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-loongson/cmdline.h b/arch/mips/include/asm/mach-loongson/cmdline.h
new file mode 100644
index 0000000..de954e0
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cmdline.h
@@ -0,0 +1,9 @@
+/* machine-specific command line initialization */
+#ifdef CONFIG_SYS_HAS_MACH_PROM_INIT_CMDLINE
+extern void __init mach_prom_init_cmdline(void);
+#else
+void __init mach_prom_init_cmdline(void)
+{
+}
+#endif
+
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 73ff14d..c8b83b4 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -27,7 +27,7 @@
 #define LOONGSON_TIMER_IRQ        	(MIPS_CPU_IRQ_BASE + 7)
 #define LOONGSON_DMATIMEOUT_IRQ		(LOONGSON_IRQ_BASE + 10)
 
-#else /* CONFIG_LEMOTE_FULOONG2F */
+#elif defined(CONFIG_LEMOTE_FULOONG2F)
 
 #define MACH_NAME			"lemote-fuloong(2f)"
 
@@ -35,6 +35,33 @@
 #define LOONGSON_UART_BAUD		1843200
 #define LOONGSON_UART_IOTYPE		UPIO_PORT
 
+#else /* CONFIG_CPU_YEELOONG2F */
+
+#define MACH_NAME			"lemote-yeeloong(2f)"
+
+/* yeeloong use the CPU serial port of Loongson2F */
+#define LOONGSON_UART_BASE		0x1ff003f8
+#define	LOONGSON_UART_BAUD		3686400
+#define LOONGSON_UART_IOTYPE		UPIO_MEM
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from it.
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
+/* fuloong2f and yeeloong2f have the same IRQ control interface */
+#if defined(CONFIG_LEMOTE_FULOONG2F) || defined(CONFIG_LEMOTE_YEELOONG2F)
+
 #define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
 #define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 0547907..9cc817f 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -24,9 +24,11 @@ config LEMOTE_FULOONG2E
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select CPU_HAS_WB
 	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
+	  Lemote Fuloong(2e) mini-PC board based on the Chinese Loongson-2E CPU and
 	  an FPGA northbridge
 
+	  Lemote Fuloong(2e) mini PC have a VIA686B south bridge.
+
 config LEMOTE_FULOONG2F
 	bool "Lemote Fuloong(2f) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
@@ -50,7 +52,44 @@ config LEMOTE_FULOONG2F
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
+	  Lemote Yeeloong(2f) laptop have an AMD CS5536 south bridge and an EC
+	  controller.
 
 endchoice
 
@@ -72,3 +111,6 @@ config CS5536_OTG
 config CS5536_UDC
 	bool
 	depends on CS5536
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
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 6f603ac..fe0851a 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -21,6 +21,8 @@
 #include <linux/bootmem.h>
 
 #include <asm/bootinfo.h>
+#include <loongson.h>
+#include <cmdline.h>
 
 unsigned long bus_clock, cpu_clock_freq;
 unsigned long memsize, highmemsize;
@@ -55,6 +57,9 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " ");
 	}
 
+	/* machine specific prom_init_cmdline */
+	mach_prom_init_cmdline();
+
 	/* handle console, root, busclock, cpuclock, memsize, highmemsize
 	arguments */
 
diff --git a/arch/mips/loongson/yeeloong-2f/Makefile b/arch/mips/loongson/yeeloong-2f/Makefile
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
diff --git a/arch/mips/loongson/yeeloong-2f/init.c b/arch/mips/loongson/yeeloong-2f/init.c
new file mode 100644
index 0000000..462d5d7
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/init.c
@@ -0,0 +1,71 @@
+/*
+ * board specific init routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
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
+			p = strstr(pmon_ver, " ");
+			if (p)
+				*p++ = '\0';
+			strncpy(version, pmon_ver, 60);
+		} else
+			strncpy(version, "PMON_VER=Unknown", 60);
+
+		ec_ver = strstr(p, "EC_VER");
+		if (ec_ver) {
+			p = strstr(ec_ver, " ");
+			if (p)
+				*p = '\0';
+			strncpy(ec_version, ec_ver, 64);
+		} else
+			strncpy(ec_version, "EC_VER=Unknown", 64);
+
+		p = strstr(arcs_cmdline, "root=");
+		if (p) {
+			strncpy(default_root, p, sizeof(default_root));
+			p = strstr(default_root, " ");
+			if (p)
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
diff --git a/arch/mips/loongson/yeeloong-2f/irq.c b/arch/mips/loongson/yeeloong-2f/irq.c
new file mode 100644
index 0000000..571aeb3
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/irq.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
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
+inline void mach_irq_dispatch(unsigned int pending)
+{
+	if (pending & CAUSEF_IP7)
+		do_IRQ(LOONGSON_TIMER_IRQ);
+	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
+		do_IRQ(LOONGSON_PERFCNT_IRQ);
+		bonito_irqdispatch();
+	} else if (pending & CAUSEF_IP3)	/* CPU UART */
+		do_IRQ(LOONGSON_UART_IRQ);
+	else if (pending & CAUSEF_IP2)	/* South Bridge */
+		i8259_irqdispatch();
+	else
+		spurious_interrupt();
+}
+
+void __init set_irq_trigger_mode(void)
+{
+	/* setup cs5536 as high level trigger */
+	LOONGSON_INTPOL = LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1;
+	LOONGSON_INTEDGE &= ~(LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1);
+}
diff --git a/arch/mips/loongson/yeeloong-2f/reset.c b/arch/mips/loongson/yeeloong-2f/reset.c
new file mode 100644
index 0000000..a3719a4
--- /dev/null
+++ b/arch/mips/loongson/yeeloong-2f/reset.c
@@ -0,0 +1,40 @@
+/* Board-specific reboot/shutdown routines
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+void mach_prepare_reboot(void)
+{
+	/*
+	 * reset cpu to full speed, this is needed when enabling cpu frequency
+	 * scalling
+	 */
+	LOONGSON_CHIPCFG0 |= 0x7;
+
+	/* sending an reset signal to EC(embedded controller) */
+	writeb(REG_RESET_HIGH, (u8 *) (mips_io_port_base + EC_IO_PORT_HIGH));
+	writeb(REG_RESET_LOW, (u8 *) (mips_io_port_base + EC_IO_PORT_LOW));
+	mmiowb();
+	writeb(BIT_RESET_ON, (u8 *) (mips_io_port_base + EC_IO_PORT_DATA));
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
index b96ed14..1a57532 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -27,7 +27,8 @@ obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
-obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fixup-fuloong2f.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fixup-lemote2f.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_YEELOONG2F)	+= fixup-lemote2f.o ops-loongson2.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fuloong2f.c b/arch/mips/pci/fixup-fuloong2f.c
deleted file mode 100644
index 99fd2c8..0000000
--- a/arch/mips/pci/fixup-fuloong2f.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
- * Copyright (C) 2008 Lemote Technology
- * Copyright (C) 2004 ICT CAS
- * Author: Li xiaoyu, lixy@ict.ac.cn
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <loongson.h>
-#include <cs5536/cs5536.h>
-#include <cs5536/cs5536_pci.h>
-
-/* PCI interrupt pins
- *
- * These should not be changed, or you should consider loongson2f interrupt
- * register and your pci card dispatch
- */
-
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
-	if ((PCI_SLOT(dev->devfn) != PCI_IDSEL_CS5536)
-	    && (PCI_SLOT(dev->devfn) < 32)) {
-		virq = irq_tab[slot][pin];
-		printk(KERN_INFO "slot: %d, pin: %d, irq: %d\n", slot, pin,
-		       virq + LOONGSON_IRQ_BASE);
-		if (virq != 0)
-			return LOONGSON_IRQ_BASE + virq;
-		else
-			return 0;
-	} else if (PCI_SLOT(dev->devfn) == PCI_IDSEL_CS5536) {	/*  cs5536 */
-		switch (PCI_FUNC(dev->devfn)) {
-		case 2:
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
-					      CS5536_IDE_INTR);
-			return 14;	/*  for IDE */
-		case 3:
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
-					      CS5536_ACC_INTR);
-			return 9;	/*  for AUDIO */
-		case 4:	/*  for OHCI */
-		case 5:	/*  for EHCI */
-		case 6:	/*  for UDC */
-		case 7:	/*  for OTG */
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
-					      CS5536_USB_INTR);
-			return 11;
-		}
-		return dev->irq;
-	} else {
-		printk(KERN_INFO " strange pci slot number.\n");
-		return 0;
-	}
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
-/* CS5536 SPEC. fixup */
-static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
-{
-	/* the uart1 and uart2 interrupt in PIC is enabled as default */
-	pci_write_config_dword(pdev, PCI_UART1_INT_REG, 1);
-	pci_write_config_dword(pdev, PCI_UART2_INT_REG, 1);
-	return;
-}
-
-static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
-{
-	/* setting the mutex pin as IDE function */
-	pci_write_config_dword(pdev, PCI_IDE_CFG_REG,
-			       CS5536_IDE_FLASH_SIGNATURE);
-	return;
-}
-
-static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
-{
-	u8 val;
-
-	/* enable the AUDIO interrupt in PIC  */
-	pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
-
-#if 1
-	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
-	printk(KERN_INFO "cs5536 acc latency 0x%x\n", val);
-	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
-#endif
-	return;
-}
-
-static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
-{
-	/* enable the OHCI interrupt in PIC */
-	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
-	pci_write_config_dword(pdev, PCI_OHCI_INT_REG, 1);
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
-	/* setting the USB2.0 micro frame length */
-	pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
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
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA,
-			 loongson_cs5536_isa_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_OHC,
-			 loongson_cs5536_ohci_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_EHC,
-			 loongson_cs5536_ehci_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
-			 loongson_cs5536_acc_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE,
-			 loongson_cs5536_ide_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
-			 loongson_nec_fixup);
diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
new file mode 100644
index 0000000..99fd2c8
--- /dev/null
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright (C) 2008 Lemote Technology
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <loongson.h>
+#include <cs5536/cs5536.h>
+#include <cs5536/cs5536_pci.h>
+
+/* PCI interrupt pins
+ *
+ * These should not be changed, or you should consider loongson2f interrupt
+ * register and your pci card dispatch
+ */
+
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
+	if ((PCI_SLOT(dev->devfn) != PCI_IDSEL_CS5536)
+	    && (PCI_SLOT(dev->devfn) < 32)) {
+		virq = irq_tab[slot][pin];
+		printk(KERN_INFO "slot: %d, pin: %d, irq: %d\n", slot, pin,
+		       virq + LOONGSON_IRQ_BASE);
+		if (virq != 0)
+			return LOONGSON_IRQ_BASE + virq;
+		else
+			return 0;
+	} else if (PCI_SLOT(dev->devfn) == PCI_IDSEL_CS5536) {	/*  cs5536 */
+		switch (PCI_FUNC(dev->devfn)) {
+		case 2:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      CS5536_IDE_INTR);
+			return 14;	/*  for IDE */
+		case 3:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      CS5536_ACC_INTR);
+			return 9;	/*  for AUDIO */
+		case 4:	/*  for OHCI */
+		case 5:	/*  for EHCI */
+		case 6:	/*  for UDC */
+		case 7:	/*  for OTG */
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      CS5536_USB_INTR);
+			return 11;
+		}
+		return dev->irq;
+	} else {
+		printk(KERN_INFO " strange pci slot number.\n");
+		return 0;
+	}
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/* CS5536 SPEC. fixup */
+static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
+{
+	/* the uart1 and uart2 interrupt in PIC is enabled as default */
+	pci_write_config_dword(pdev, PCI_UART1_INT_REG, 1);
+	pci_write_config_dword(pdev, PCI_UART2_INT_REG, 1);
+	return;
+}
+
+static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
+{
+	/* setting the mutex pin as IDE function */
+	pci_write_config_dword(pdev, PCI_IDE_CFG_REG,
+			       CS5536_IDE_FLASH_SIGNATURE);
+	return;
+}
+
+static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
+{
+	u8 val;
+
+	/* enable the AUDIO interrupt in PIC  */
+	pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
+
+#if 1
+	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
+	printk(KERN_INFO "cs5536 acc latency 0x%x\n", val);
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
+#endif
+	return;
+}
+
+static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
+{
+	/* enable the OHCI interrupt in PIC */
+	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
+	pci_write_config_dword(pdev, PCI_OHCI_INT_REG, 1);
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
+	/* setting the USB2.0 micro frame length */
+	pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
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
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA,
+			 loongson_cs5536_isa_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_OHC,
+			 loongson_cs5536_ohci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_EHC,
+			 loongson_cs5536_ehci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+			 loongson_cs5536_acc_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE,
+			 loongson_cs5536_ide_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+			 loongson_nec_fixup);
-- 
1.6.2.1
