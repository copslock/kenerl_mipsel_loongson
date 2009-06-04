Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:05:03 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:64292 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022595AbZFDNEv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:04:51 +0100
Received: by pxi16 with SMTP id 16so748644pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:04:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NUmfv/P1yo5mjj19fqD5cPPDQYQH9YHJ3YgbOdiBcRE=;
        b=mi91SXjzlf7rH4OX7mKExwFtG66BjIqORi8Smfi3QaZrZM+Mt8fKcpZL/2E7FH1aiQ
         nbKwvYaALG6fYkSttaH3VGMoyHii8tNgyFmSuNYTyeZnGom1mdVNMi1KdETMGJ0g0kxG
         YRzgq8mlgqK7/Itp6OAFuccTSaLVbixs5yRfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ggy82HbmJanvCsmAhiI/RPjXSF7ViIuw526w2yIQB3AU4ni/1y936gwFmB779+QTFK
         NTBdH51X4IBpGKsbEmyPrVHiYwxCFYue4NoQYOGCt3/6ndeUkpuWxGpwKvuCA0+eu+75
         5f38VzmR+IQO2p5xwbHVx51SpRtjlzubnoSLY=
Received: by 10.115.94.1 with SMTP id w1mr3491147wal.177.1244120683581;
        Thu, 04 Jun 2009 06:04:43 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id j34sm10975219waf.29.2009.06.04.06.04.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:04:42 -0700 (PDT)
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
Subject: [loongson-PATCH-v3 06/25] divide the files to the smallest logic unit
Date:	Thu,  4 Jun 2009 21:04:29 +0800
Message-Id: <8a17b160bdf7ebf7a959cabbde59530b068190f4.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

to enhance the maintainability and scalability of the source code, there
is a need to divide the files to the smallest logic function unit.

at the same time, the header files references are cleaned up, and some
loongson2e* names are changed to loongson* for future source code
sharing between loongson-2e and loongson-2f

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    4 +
 arch/mips/include/asm/mach-loongson/pci.h      |    7 +-
 arch/mips/loongson/fuloong-2e/Makefile         |    3 +-
 arch/mips/loongson/fuloong-2e/bonito-irq.c     |    7 +--
 arch/mips/loongson/fuloong-2e/cmdline.c        |   77 ++++++++++++++++++
 arch/mips/loongson/fuloong-2e/init.c           |   40 +++++++++
 arch/mips/loongson/fuloong-2e/irq.c            |    5 +-
 arch/mips/loongson/fuloong-2e/mem.c            |   18 ++++-
 arch/mips/loongson/fuloong-2e/misc.c           |   13 +++
 arch/mips/loongson/fuloong-2e/pci.c            |   30 +++----
 arch/mips/loongson/fuloong-2e/prom.c           |   90 ---------------------
 arch/mips/loongson/fuloong-2e/setup.c          |  103 ++++++++----------------
 arch/mips/loongson/fuloong-2e/time.c           |   27 ++++++
 13 files changed, 230 insertions(+), 194 deletions(-)
 create mode 100644 arch/mips/loongson/fuloong-2e/cmdline.c
 create mode 100644 arch/mips/loongson/fuloong-2e/init.c
 create mode 100644 arch/mips/loongson/fuloong-2e/misc.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/prom.c
 create mode 100644 arch/mips/loongson/fuloong-2e/time.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 26308b5..bce85a8 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -24,6 +24,10 @@ extern unsigned long memsize, highmemsize;
 /* loongson-based machines specific reboot setup */
 extern void loongson_reboot_setup(void);
 
+/* loongson-specific command line and memory initialization */
+extern void __init prom_init_memory(void);
+extern void __init prom_init_cmdline(void);
+
 #define LOONGSON_REG(x) \
 	(*(u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
 #define LOONGSON_IRQ_BASE	32
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
index 9a351be..8f02486 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -24,9 +24,8 @@
 
 extern struct pci_ops loongson_pci_ops;
 
-#define LOONGSON2E_PCI_MEM_START	0x14000000UL
-#define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
-#define LOONGSON2E_PCI_IO_START		0x00004000UL
-#define LOONGSON2E_IO_PORT_BASE		0x1fd00000UL
+#define LOONGSON_PCI_MEM_START	0x14000000UL
+#define LOONGSON_PCI_MEM_END	0x1fffffffUL
+#define LOONGSON_PCI_IO_START	0x00004000UL
 
 #endif /* !_LOONGSON_PCI_H_ */
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
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
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c b/arch/mips/loongson/fuloong-2e/bonito-irq.c
index 91b9c08..8a32651 100644
--- a/arch/mips/loongson/fuloong-2e/bonito-irq.c
+++ b/arch/mips/loongson/fuloong-2e/bonito-irq.c
@@ -27,16 +27,11 @@
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
 
-
 static inline void bonito_irq_enable(unsigned int irq)
 {
 	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
diff --git a/arch/mips/loongson/fuloong-2e/cmdline.c b/arch/mips/loongson/fuloong-2e/cmdline.c
new file mode 100644
index 0000000..01e30db
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/cmdline.c
@@ -0,0 +1,77 @@
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
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+
+unsigned long bus_clock, cpu_clock_freq;
+unsigned long memsize, highmemsize;
+
+int prom_argc;
+/* pmon passes arguments in 32bit pointers */
+int *_prom_argv, *_prom_envp;
+
+#define parse_even_earlier(res, option, p)				\
+do {									\
+	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
+			strict_strtol((char *)p + strlen(option"="),	\
+				    10, &res);				\
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
+	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
+	       bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
diff --git a/arch/mips/loongson/fuloong-2e/init.c b/arch/mips/loongson/fuloong-2e/init.c
new file mode 100644
index 0000000..76e6fda
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/init.c
@@ -0,0 +1,40 @@
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
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
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
+void __init prom_init(void)
+{
+	/* init mach type, does we need to init it?? */
+	mips_machtype = PRID_IMP_LOONGSON2;
+
+	/* init several base address */
+	set_io_port_base((unsigned long)
+			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
+
+	prom_init_cmdline();
+	prom_init_memory();
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index 20030c0..d4db5e1 100644
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
 
diff --git a/arch/mips/loongson/fuloong-2e/mem.c b/arch/mips/loongson/fuloong-2e/mem.c
index 16cd215..2a0f4e6 100644
--- a/arch/mips/loongson/fuloong-2e/mem.c
+++ b/arch/mips/loongson/fuloong-2e/mem.c
@@ -4,9 +4,25 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
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
+#include <loongson.h>
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
diff --git a/arch/mips/loongson/fuloong-2e/misc.c b/arch/mips/loongson/fuloong-2e/misc.c
new file mode 100644
index 0000000..d9532ca
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/misc.c
@@ -0,0 +1,13 @@
+/* Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+const char *get_system_type(void)
+{
+	return "fuloong-2e";
+}
diff --git a/arch/mips/loongson/fuloong-2e/pci.c b/arch/mips/loongson/fuloong-2e/pci.c
index 1d81110..cfc09a1 100644
--- a/arch/mips/loongson/fuloong-2e/pci.c
+++ b/arch/mips/loongson/fuloong-2e/pci.c
@@ -25,32 +25,29 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
-#include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 
 #include <loongson.h>
 #include <pci.h>
 
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
@@ -83,12 +80,9 @@ static int __init pcibios_init(void)
 {
 	ict_pcimap();
 
-	loongson2e_pci_controller.io_map_base =
-	    (unsigned long) ioremap(LOONGSON2E_IO_PORT_BASE,
-				    loongson2e_pci_io_resource.end -
-				    loongson2e_pci_io_resource.start + 1);
+	loongson_pci_controller.io_map_base = mips_io_port_base;
 
-	register_pci_controller(&loongson2e_pci_controller);
+	register_pci_controller(&loongson_pci_controller);
 
 	return 0;
 }
diff --git a/arch/mips/loongson/fuloong-2e/prom.c b/arch/mips/loongson/fuloong-2e/prom.c
deleted file mode 100644
index 95081f4..0000000
--- a/arch/mips/loongson/fuloong-2e/prom.c
+++ /dev/null
@@ -1,90 +0,0 @@
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
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/init.h>
-#include <linux/bootmem.h>
-#include <asm/bootinfo.h>
-
-#include <loongson.h>
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
-#define parse_even_earlier(res, option, p)				\
-do {									\
-	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-			strict_strtol((char *)p + strlen(option"="),	\
-				    10, &res);				\
-} while (0)
-
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
-	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
-	       bus_clock, cpu_clock_freq, memsize, highmemsize);
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
diff --git a/arch/mips/loongson/fuloong-2e/setup.c b/arch/mips/loongson/fuloong-2e/setup.c
index ae226a4..770d7b5 100644
--- a/arch/mips/loongson/fuloong-2e/setup.c
+++ b/arch/mips/loongson/fuloong-2e/setup.c
@@ -1,108 +1,71 @@
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
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
-#include <linux/bootmem.h>
-#include <linux/init.h>
-#include <linux/irq.h>
 
-#include <asm/bootinfo.h>
-#include <asm/mc146818-time.h>
+#include <linux/module.h>
+
 #include <asm/wbflush.h>
-#include <asm/time.h>
 
 #include <loongson.h>
-#include <pci.h>
-
-#ifdef CONFIG_VT
-#include <linux/console.h>
-#include <linux/screen_info.h>
-#endif
 
-unsigned long cpu_clock_freq, bus_clock;
-unsigned long memsize, highmemsize;
-
-void __init plat_time_init(void)
-{
-	/* setup mips r4k timer */
-	mips_hpt_frequency = cpu_clock_freq / 2;
-}
-
-unsigned long read_persistent_clock(void)
-{
-	return mc146818_get_cmos_time();
-}
-
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
-	loongson_reboot_setup();
-
-	__wbflush = wbflush_loongson2e;
-
-	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
-#ifdef CONFIG_64BIT
-	if (highmemsize > 0)
-		add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
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
 
+void __init plat_mem_setup(void)
+{
+	loongson_reboot_setup();
+
+	loongson_wbflush_setup();
+
+	loongson_screeninfo_setup();
 }
diff --git a/arch/mips/loongson/fuloong-2e/time.c b/arch/mips/loongson/fuloong-2e/time.c
new file mode 100644
index 0000000..231f0c2
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/time.c
@@ -0,0 +1,27 @@
+/*
+ * board dependent boot routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <asm/mc146818-time.h>
+#include <asm/time.h>
+
+#include <loongson.h>
+
+unsigned long read_persistent_clock(void)
+{
+	return mc146818_get_cmos_time();
+}
+
+void __init plat_time_init(void)
+{
+	/* setup mips r4k timer */
+	mips_hpt_frequency = cpu_clock_freq / 2;
+}
-- 
1.6.0.4
