Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:03:37 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:42290 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023275AbZEOWDa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:03:30 +0100
Received: by pxi17 with SMTP id 17so1364990pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:03:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=x2jSB1oDy76bgxdZpYGAqTNPReyqpuSLFFBbHb9ndVM=;
        b=DgFhzFT/Xx1E5N8XZSsdJKZdFfSVz8AJi8gRrppbkzfUXxaSIIaz31a2UyZsmWp2d8
         wod3xiy0ev8QWLKcDjpLymjVoALiNbCJKfyb2Q/5/sJzaCkG0qO5JcaWUGXUjYW1a2kM
         S04oTS0EBDfD3iEmwULtkKAxllTWb2EWCYUac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kE7ozkMgrL4oraSj3t4bR1esnfh7BEBx39EejwMM9PN7JBExvmR1thkM4vH3roBtQE
         ekff4bwx5uiTQPBcBiRaGupFwSVHgjMrmX7RjNdgNnqp01JiZKsHuF/rD9TUldeH2Xod
         AKJgQFrPdil/VwRRMslXpuYrY0+Oyga1jfWks=
Received: by 10.142.155.8 with SMTP id c8mr1392968wfe.1.1242425003269;
        Fri, 15 May 2009 15:03:23 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1659651wfg.7.2009.05.15.15.03.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:03:22 -0700 (PDT)
Subject: [PATCH 06/30] loongson: divide the files to the smallest logic unit
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:03:15 +0800
Message-Id: <1242424995.10164.146.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From d3e6691261253c3654574e0a7c66eb96bee8c4ae Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Fri, 15 May 2009 23:05:26 +0800
Subject: [PATCH 06/30] loongson: divide the files to the smallest logic
unit

to enhance the maintainability and scalability of the source code, there
is a need to divide the files to the smallest logic function unit.

at the same time, the header files references are cleaned up, and some
loongson2e* names are changed to loongson* for future source code
sharing between loongson-2e and loongson-2f, and some naming of
loongson2e* in fixup-fuloong2e.c is changed to fuloong2e*, for they are
board-specific, not loongson-specific.
---
 arch/mips/include/asm/mach-loongson/pci.h  |    8 +-
 arch/mips/loongson/fuloong-2e/Makefile     |    3 +-
 arch/mips/loongson/fuloong-2e/bonito-irq.c |    6 +-
 arch/mips/loongson/fuloong-2e/cmdline.c    |   79 ++++++++++++++++++++
 arch/mips/loongson/fuloong-2e/dbg_io.c     |    5 +
 arch/mips/loongson/fuloong-2e/init.c       |   42 +++++++++++
 arch/mips/loongson/fuloong-2e/irq.c        |    5 +-
 arch/mips/loongson/fuloong-2e/mem.c        |   18 ++++-
 arch/mips/loongson/fuloong-2e/misc.c       |   13 +++
 arch/mips/loongson/fuloong-2e/pci.c        |   34 ++++-----
 arch/mips/loongson/fuloong-2e/prom.c       |   97
------------------------
 arch/mips/loongson/fuloong-2e/reset.c      |   18 ++---
 arch/mips/loongson/fuloong-2e/setup.c      |  111
+++++++++-------------------
 arch/mips/loongson/fuloong-2e/time.c       |   27 +++++++
 arch/mips/pci/fixup-fuloong2e.c            |   24 +++---
 15 files changed, 262 insertions(+), 228 deletions(-)
 create mode 100644 arch/mips/loongson/fuloong-2e/cmdline.c
 create mode 100644 arch/mips/loongson/fuloong-2e/init.c
 create mode 100644 arch/mips/loongson/fuloong-2e/misc.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/prom.c
 create mode 100644 arch/mips/loongson/fuloong-2e/time.c

diff --git a/arch/mips/include/asm/mach-loongson/pci.h
b/arch/mips/include/asm/mach-loongson/pci.h
index 97eb4d8..4d3b647 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -22,9 +22,9 @@
 #ifndef _LOONGSON_PCI_H_
 #define _LOONGSON_PCI_H_
 
-#define LOONGSON2E_PCI_MEM_START	0x14000000UL
-#define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
-#define LOONGSON2E_PCI_IO_START		0x00004000UL
-#define LOONGSON2E_IO_PORT_BASE		0x1fd00000UL
+#define LOONGSON_PCI_MEM_START		0x14000000UL
+#define LOONGSON_PCI_MEM_END		0x1fffffffUL
+#define LOONGSON_PCI_IO_START		0x00004000UL
+#define LOONGSON_IO_PORT_BASE		0x1fd00000UL
 
 #endif /* !_LOONGSON_PCI_H_ */
diff --git a/arch/mips/loongson/fuloong-2e/Makefile
b/arch/mips/loongson/fuloong-2e/Makefile
index d34671d..796e729 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -2,6 +2,7 @@
 # Makefile for Lemote Fulong mini-PC board.
 #
 
-obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
+obj-y += setup.o init.o cmdline.o time.o reset.o irq.o \
+	pci.o bonito-irq.o dbg_io.o mem.o misc.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c
b/arch/mips/loongson/fuloong-2e/bonito-irq.c
index d86c687..cd7d3d1 100644
--- a/arch/mips/loongson/fuloong-2e/bonito-irq.c
+++ b/arch/mips/loongson/fuloong-2e/bonito-irq.c
@@ -27,12 +27,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/types.h>
+
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 
 #include <loongson.h>
 
diff --git a/arch/mips/loongson/fuloong-2e/cmdline.c
b/arch/mips/loongson/fuloong-2e/cmdline.c
new file mode 100644
index 0000000..28bcf6f
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/cmdline.c
@@ -0,0 +1,79 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
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
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+
+unsigned long bus_clock;
+unsigned long cpu_clock_freq;
+unsigned int memsize, highmemsize;
+
+int prom_argc;
+/* pmon passes arguments in 32bit pointers */
+int *_prom_argv, *_prom_envp;
+
+#define parse_even_earlier(res, option, p)				\
+do {									\
+	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
+		res = simple_strtol((char *)p + strlen(option"="),	\
+				    NULL, 10);				\
+} while (0)
+
+void __init prom_init_cmdline(void)
+{
+	int i;
+	long l;
+	prom_argc = fw_arg0;
+	_prom_argv = (int *)fw_arg1;
+	_prom_envp = (int *)fw_arg2;
+	
+	/* arg[0] is "g", the rest is boot parameters */
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < prom_argc; i++) {
+		l = (long)_prom_argv[i];
+		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, ((char *)l));
+		strcat(arcs_cmdline, " ");
+	}
+
+	/* handle console, root, busclock, cpuclock, memsize, highmemsize
arguments */
+	if ((strstr(arcs_cmdline, "console=")) == NULL)
+		strcat(arcs_cmdline, " console=ttyS0,115200");
+	if ((strstr(arcs_cmdline, "root=")) == NULL)
+		strcat(arcs_cmdline, " root=/dev/hda1");
+
+	l = (long)*_prom_envp;
+	while (l != 0) {
+		parse_even_earlier(bus_clock, "busclock", l);
+		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
+		parse_even_earlier(memsize, "memsize", l);
+		parse_even_earlier(highmemsize, "highmemsize", l);
+		_prom_envp++;
+		l = (long)*_prom_envp;
+	}
+	if (memsize == 0)
+		memsize = 256;
+
+	pr_info("busclock=%ld, cpuclock=%ld, memsize=%d, highmemsize=%d\n",
+		bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
diff --git a/arch/mips/loongson/fuloong-2e/dbg_io.c
b/arch/mips/loongson/fuloong-2e/dbg_io.c
index 6c95da3..3ad3a49 100644
--- a/arch/mips/loongson/fuloong-2e/dbg_io.c
+++ b/arch/mips/loongson/fuloong-2e/dbg_io.c
@@ -144,3 +144,8 @@ int putDebugChar(u8 byte)
 	UART16550_WRITE(OFS_SEND_BUFFER, byte);
 	return 1;
 }
+
+void prom_putchar(char c)
+{
+	putDebugChar(c);
+}
diff --git a/arch/mips/loongson/fuloong-2e/init.c
b/arch/mips/loongson/fuloong-2e/init.c
new file mode 100644
index 0000000..2c8bd8a
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/init.c
@@ -0,0 +1,42 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
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
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+
+#include <loongson.h>
+
+extern void __init prom_init_memory(void);
+extern void __init prom_init_cmdline(void);
+
+void __init prom_init(void)
+{
+	/* init mach type, does we need to init it?? */
+	mips_machtype = PRID_IMP_LOONGSON2;
+
+	/* init several base address */
+	set_io_port_base((unsigned long)
+			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
+	prom_init_cmdline();
+	prom_init_memory();
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/loongson/fuloong-2e/irq.c
b/arch/mips/loongson/fuloong-2e/irq.c
index 8cd3d9a..e764a4e 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -23,15 +23,12 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
+
 #include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/i8259.h>
-#include <asm/mipsregs.h>
 
 #include <loongson.h>
 
diff --git a/arch/mips/loongson/fuloong-2e/mem.c
b/arch/mips/loongson/fuloong-2e/mem.c
index 16cd215..f5d7372 100644
--- a/arch/mips/loongson/fuloong-2e/mem.c
+++ b/arch/mips/loongson/fuloong-2e/mem.c
@@ -4,9 +4,25 @@
  * Free Software Foundation;  either version 2 of the  License, or (at
your
  * option) any later version.
  */
+
 #include <linux/fs.h>
-#include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/bootinfo.h>
+
+extern unsigned int memsize, highmemsize;
+
+void __init prom_init_memory(void)
+{
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+#ifdef CONFIG_64BIT
+	if (highmemsize > 0) {
+		add_memory_region(0x20000000,
+				  highmemsize << 20, BOOT_MEM_RAM);
+	}
+#endif				/* CONFIG_64BIT */
+}
 
 /* override of arch/mips/mm/cache.c: __uncached_access */
 int __uncached_access(struct file *file, unsigned long addr)
diff --git a/arch/mips/loongson/fuloong-2e/misc.c
b/arch/mips/loongson/fuloong-2e/misc.c
new file mode 100644
index 0000000..d9532ca
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/misc.c
@@ -0,0 +1,13 @@
+/* Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
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
+const char *get_system_type(void)
+{
+	return "fuloong-2e";
+}
diff --git a/arch/mips/loongson/fuloong-2e/pci.c
b/arch/mips/loongson/fuloong-2e/pci.c
index e1080c9..1a7b4e9 100644
--- a/arch/mips/loongson/fuloong-2e/pci.c
+++ b/arch/mips/loongson/fuloong-2e/pci.c
@@ -25,34 +25,32 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
-#include <linux/types.h>
+
 #include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 
 #include <loongson.h>
 #include <pci.h>
 
 extern struct pci_ops loongson_pci_ops;
 
-static struct resource loongson2e_pci_mem_resource = {
-	.name   = "LOONGSON2E PCI MEM",
-	.start  = LOONGSON2E_PCI_MEM_START,
-	.end    = LOONGSON2E_PCI_MEM_END,
+static struct resource loongson_pci_mem_resource = {
+	.name   = "LOONGSON PCI MEM",
+	.start  = LOONGSON_PCI_MEM_START,
+	.end    = LOONGSON_PCI_MEM_END,
 	.flags  = IORESOURCE_MEM,
 };
 
-static struct resource loongson2e_pci_io_resource = {
-	.name   = "LOONGSON2E PCI IO MEM",
-	.start  = LOONGSON2E_PCI_IO_START,
+static struct resource loongson_pci_io_resource = {
+	.name   = "LOONGSON PCI IO MEM",
+	.start  = LOONGSON_PCI_IO_START,
 	.end    = IO_SPACE_LIMIT,
 	.flags  = IORESOURCE_IO,
 };
 
-static struct pci_controller  loongson2e_pci_controller = {
+static struct pci_controller  loongson_pci_controller = {
 	.pci_ops        = &loongson_pci_ops,
-	.io_resource    = &loongson2e_pci_io_resource,
-	.mem_resource   = &loongson2e_pci_mem_resource,
+	.io_resource    = &loongson_pci_io_resource,
+	.mem_resource   = &loongson_pci_mem_resource,
 	.mem_offset     = 0x00000000UL,
 	.io_offset      = 0x00000000UL,
 };
@@ -85,12 +83,12 @@ static int __init pcibios_init(void)
 {
 	ict_pcimap();
 
-	loongson2e_pci_controller.io_map_base =
-	    (unsigned long) ioremap(LOONGSON2E_IO_PORT_BASE,
-				    loongson2e_pci_io_resource.end -
-				    loongson2e_pci_io_resource.start + 1);
+	loongson_pci_controller.io_map_base =
+	    (unsigned long) ioremap(LOONGSON_IO_PORT_BASE,
+				    loongson_pci_io_resource.end -
+				    loongson_pci_io_resource.start + 1);
 
-	register_pci_controller(&loongson2e_pci_controller);
+	register_pci_controller(&loongson_pci_controller);
 
 	return 0;
 }
diff --git a/arch/mips/loongson/fuloong-2e/prom.c
b/arch/mips/loongson/fuloong-2e/prom.c
deleted file mode 100644
index 7edc15d..0000000
--- a/arch/mips/loongson/fuloong-2e/prom.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * Based on Ocelot Linux port, which is
- * Copyright 2001 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * Copyright 2003 ICT CAS
- * Author: Michael Guo <guoyi@ict.ac.cn>
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- * This program is free software; you can redistribute  it and/or
modify it
- * under  the terms of  the GNU General  Public License as published by
the
- * Free Software Foundation;  either version 2 of the  License, or (at
your
- * option) any later version.
- */
-#include <linux/init.h>
-#include <linux/bootmem.h>
-#include <asm/bootinfo.h>
-
-extern unsigned long bus_clock;
-extern unsigned long cpu_clock_freq;
-extern unsigned int memsize, highmemsize;
-extern int putDebugChar(unsigned char byte);
-
-static int argc;
-/* pmon passes arguments in 32bit pointers */
-static int *arg;
-static int *env;
-
-const char *get_system_type(void)
-{
-	return "lemote-fulong";
-}
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-	long l;
-
-	/* arg[0] is "g", the rest is boot parameters */
-	arcs_cmdline[0] = '\0';
-	for (i = 1; i < argc; i++) {
-		l = (long)arg[i];
-		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
-		    >= sizeof(arcs_cmdline))
-			break;
-		strcat(arcs_cmdline, ((char *)l));
-		strcat(arcs_cmdline, " ");
-	}
-}
-
-void __init prom_init(void)
-{
-	long l;
-	argc = fw_arg0;
-	arg = (int *)fw_arg1;
-	env = (int *)fw_arg2;
-
-	prom_init_cmdline();
-
-	if ((strstr(arcs_cmdline, "console=")) == NULL)
-		strcat(arcs_cmdline, " console=ttyS0,115200");
-	if ((strstr(arcs_cmdline, "root=")) == NULL)
-		strcat(arcs_cmdline, " root=/dev/hda1");
-
-#define parse_even_earlier(res, option, p)				\
-do {									\
-	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-		res = simple_strtol((char *)p + strlen(option"="),	\
-				    NULL, 10);				\
-} while (0)
-
-	l = (long)*env;
-	while (l != 0) {
-		parse_even_earlier(bus_clock, "busclock", l);
-		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
-		parse_even_earlier(memsize, "memsize", l);
-		parse_even_earlier(highmemsize, "highmemsize", l);
-		env++;
-		l = (long)*env;
-	}
-	if (memsize == 0)
-		memsize = 256;
-
-	pr_info("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
-	       bus_clock, cpu_clock_freq, memsize, highmemsize);
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-void prom_putchar(char c)
-{
-	putDebugChar(c);
-}
diff --git a/arch/mips/loongson/fuloong-2e/reset.c
b/arch/mips/loongson/fuloong-2e/reset.c
index 099387a..664ba77 100644
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -7,11 +7,12 @@
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  */
+
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
 
-static void loongson2e_restart(char *command)
+static void loongson_restart(char *command)
 {
 #ifdef CONFIG_32BIT
 	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
@@ -23,19 +24,14 @@ static void loongson2e_restart(char *command)
 	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
 }
 
-static void loongson2e_halt(void)
+static void loongson_halt(void)
 {
 	while (1) ;
 }
 
-static void loongson2e_power_off(void)
-{
-	loongson2e_halt();
-}
-
-void mips_reboot_setup(void)
+void loongson_reboot_setup(void)
 {
-	_machine_restart = loongson2e_restart;
-	_machine_halt = loongson2e_halt;
-	pm_power_off = loongson2e_power_off;
+	_machine_restart = loongson_restart;
+	_machine_halt = loongson_halt;
+	pm_power_off = loongson_halt;
 }
diff --git a/arch/mips/loongson/fuloong-2e/setup.c
b/arch/mips/loongson/fuloong-2e/setup.c
index 38a680a..36791d9 100644
--- a/arch/mips/loongson/fuloong-2e/setup.c
+++ b/arch/mips/loongson/fuloong-2e/setup.c
@@ -1,111 +1,72 @@
 /*
- * BRIEF MODULE DESCRIPTION
- * setup.c - board dependent boot routines
+ * board dependent setup routines
  *
  * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
  *  This program is free software; you can redistribute  it and/or
modify it
  *  under  the terms of  the GNU General  Public License as published
by the
  *  Free Software Foundation;  either version 2 of the  License, or (at
your
  *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR
IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED
WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,
INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES;
LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED
AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR
TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License
along
- *  with this program; if not, write  to the Free Software Foundation,
Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
-#include <linux/bootmem.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-
-#include <asm/bootinfo.h>
-#include <asm/mc146818-time.h>
-#include <asm/time.h>
-#include <asm/wbflush.h>
-#include <pci.h>
-
-#ifdef CONFIG_VT
-#include <linux/console.h>
-#include <linux/screen_info.h>
-#endif
-
-extern void mips_reboot_setup(void);
 
-unsigned long cpu_clock_freq;
-unsigned long bus_clock;
-unsigned int memsize;
-unsigned int highmemsize = 0;
-
-void __init plat_time_init(void)
-{
-	/* setup mips r4k timer */
-	mips_hpt_frequency = cpu_clock_freq / 2;
-}
+#include <linux/module.h>
 
-unsigned long read_persistent_clock(void)
-{
-	return mc146818_get_cmos_time();
-}
+#include <asm/wbflush.h>
 
-void (*__wbflush)(void);
+void (*__wbflush) (void);
 EXPORT_SYMBOL(__wbflush);
 
-static void wbflush_loongson2e(void)
+static void loongson_wbflush(void)
 {
 	asm(".set\tpush\n\t"
 	    ".set\tnoreorder\n\t"
 	    ".set mips3\n\t"
-	    "sync\n\t"
-	    "nop\n\t"
-	    ".set\tpop\n\t"
-	    ".set mips0\n\t");
+	    "sync\n\t" "nop\n\t" ".set\tpop\n\t" ".set mips0\n\t");
 }
 
-void __init plat_mem_setup(void)
+void __init loongson_wbflush_setup(void)
 {
-	set_io_port_base((unsigned long)ioremap(LOONGSON2E_IO_PORT_BASE,
-				IO_SPACE_LIMIT - LOONGSON2E_PCI_IO_START + 1));
-	mips_reboot_setup();
-
-	__wbflush = wbflush_loongson2e;
-
-	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
-#ifdef CONFIG_64BIT
-	if (highmemsize > 0) {
-		add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
-	}
-#endif
+	__wbflush = loongson_wbflush;
+}
 
-#ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
+#if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
+#include <linux/screen_info.h>
 
+void __init loongson_screeninfo_setup(void)
+{
 	screen_info = (struct screen_info) {
-		0, 25,		/* orig-x, orig-y */
+		    0,		/* orig-x */
+		    25,		/* orig-y */
 		    0,		/* unused */
 		    0,		/* orig-video-page */
 		    0,		/* orig-video-mode */
 		    80,		/* orig-video-cols */
-		    0, 0, 0,	/* ega_ax, ega_bx, ega_cx */
+		    0,		/* ega_ax */
+		    0,		/* ega_bx */
+		    0,		/* ega_cx */
 		    25,		/* orig-video-lines */
 		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
 		    16		/* orig-video-points */
 	};
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
+}
+#else
+void __init loongson_screeninfo_setup(void)
+{
+}
 #endif
 
+/* board-specific reboot function */
+extern void loongson_reboot_setup(void);
+
+void __init plat_mem_setup(void)
+{
+	loongson_reboot_setup();
+
+	loongson_wbflush_setup();
+
+	loongson_screeninfo_setup();
 }
diff --git a/arch/mips/loongson/fuloong-2e/time.c
b/arch/mips/loongson/fuloong-2e/time.c
new file mode 100644
index 0000000..8c916ff
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/time.c
@@ -0,0 +1,27 @@
+/*
+ * board dependent boot routines
+ *
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
+#include <asm/mc146818-time.h>
+#include <asm/time.h>
+
+unsigned long read_persistent_clock(void)
+{
+	return mc146818_get_cmos_time();
+}
+
+extern unsigned long cpu_clock_freq;
+
+void __init plat_time_init(void)
+{
+	/* setup mips r4k timer */
+	mips_hpt_frequency = cpu_clock_freq / 2;
+}
diff --git a/arch/mips/pci/fixup-fuloong2e.c
b/arch/mips/pci/fixup-fuloong2e.c
index 8b61f15..f77707b 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -64,7 +64,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
+static void __init fuloong2e_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
@@ -76,7 +76,7 @@ static void __init loongson2e_nec_fixup(struct pci_dev
*pdev)
 	pci_write_config_dword(pdev, 0xe4, 1 << 5);
 }
 
-static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
+static void __init fuloong2e_686b_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char c;
 
@@ -151,7 +151,7 @@ static void __init
loongson2e_686b_func0_fixup(struct pci_dev *pdev)
 	printk(KERN_INFO"via686b fix: ISA bridge done\n");
 }
 
-static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
+static void __init fuloong2e_686b_func1_fixup(struct pci_dev *pdev)
 {
 	printk(KERN_INFO"via686b fix: IDE\n");
 
@@ -184,19 +184,19 @@ static void __init
loongson2e_686b_func1_fixup(struct pci_dev *pdev)
 	printk(KERN_INFO"via686b fix: IDE done\n");
 }
 
-static void __init loongson2e_686b_func2_fixup(struct pci_dev *pdev)
+static void __init fuloong2e_686b_func2_fixup(struct pci_dev *pdev)
 {
 	/* irq routing */
 	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
 }
 
-static void __init loongson2e_686b_func3_fixup(struct pci_dev *pdev)
+static void __init fuloong2e_686b_func3_fixup(struct pci_dev *pdev)
 {
 	/* irq routing */
 	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
 }
 
-static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
+static void __init fuloong2e_686b_func5_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 	unsigned char c;
@@ -228,14 +228,14 @@ static void __init
loongson2e_686b_func5_fixup(struct pci_dev *pdev)
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
-			 loongson2e_686b_func0_fixup);
+			 fuloong2e_686b_func0_fixup);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
-			 loongson2e_686b_func1_fixup);
+			 fuloong2e_686b_func1_fixup);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2,
-			 loongson2e_686b_func2_fixup);
+			 fuloong2e_686b_func2_fixup);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3,
-			 loongson2e_686b_func3_fixup);
+			 fuloong2e_686b_func3_fixup);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
-			 loongson2e_686b_func5_fixup);
+			 fuloong2e_686b_func5_fixup);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
-			 loongson2e_nec_fixup);
+			 fuloong2e_nec_fixup);
-- 
1.6.2.1
