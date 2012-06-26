Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:56:09 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55021 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903775Ab2FZEvK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:10 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbQ-0002zj-Oe; Mon, 25 Jun 2012 23:42:12 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 17/33] MIPS: Loongson: Cleanup firmware support for the Loongson platform.
Date:   Mon, 25 Jun 2012 23:41:32 -0500
Message-Id: <1340685708-14408-18-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    3 +-
 arch/mips/loongson/common/Makefile             |    2 +-
 arch/mips/loongson/common/cmdline.c            |   48 ------------------------
 arch/mips/loongson/common/env.c                |   31 ++++-----------
 arch/mips/loongson/common/init.c               |    6 ++-
 5 files changed, 13 insertions(+), 77 deletions(-)
 delete mode 100644 arch/mips/loongson/common/cmdline.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 1e29b9d..b19c5b4 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -28,9 +28,8 @@ extern unsigned long memsize, highmemsize;
 
 /* loongson-specific command line, env and memory initialization */
 extern void __init prom_init_memory(void);
-extern void __init prom_init_cmdline(void);
 extern void __init prom_init_machtype(void);
-extern void __init prom_init_env(void);
+extern void __init fw_init_env(void);
 #ifdef CONFIG_LOONGSON_UART_BASE
 extern unsigned long _loongson_uart_base, loongson_uart_base;
 extern void prom_init_loongson_uart_base(void);
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index e526488..5267e33 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -2,7 +2,7 @@
 # Makefile for loongson based machines.
 #
 
-obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
+obj-y += setup.o init.o env.o time.o reset.o irq.o \
     pci.o bonito-irq.o mem.o machtype.o platform.o
 obj-$(CONFIG_GENERIC_GPIO) += gpio.o
 
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
deleted file mode 100644
index 353e1d2..0000000
--- a/arch/mips/loongson/common/cmdline.c
+++ /dev/null
@@ -1,48 +0,0 @@
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
- * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzhangjin@gmail.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <asm/bootinfo.h>
-
-#include <loongson.h>
-
-void __init prom_init_cmdline(void)
-{
-	int prom_argc;
-	/* pmon passes arguments in 32bit pointers */
-	int *_prom_argv;
-	int i;
-	long l;
-
-	/* firmware arguments are initialized in head.S */
-	prom_argc = fw_arg0;
-	_prom_argv = (int *)fw_arg1;
-
-	/* arg[0] is "g", the rest is boot parameters */
-	arcs_cmdline[0] = '\0';
-	for (i = 1; i < prom_argc; i++) {
-		l = (long)_prom_argv[i];
-		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
-		    >= sizeof(arcs_cmdline))
-			break;
-		strcat(arcs_cmdline, ((char *)l));
-		strcat(arcs_cmdline, " ");
-	}
-
-	prom_init_machtype();
-}
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index d93830a..681690a 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -19,7 +19,7 @@
  */
 #include <linux/module.h>
 
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 
 #include <loongson.h>
 
@@ -27,34 +27,17 @@ unsigned long cpu_clock_freq;
 EXPORT_SYMBOL(cpu_clock_freq);
 unsigned long memsize, highmemsize;
 
-#define parse_even_earlier(res, option, p)				\
-do {									\
-	unsigned int tmp __maybe_unused;				\
-									\
-	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-		tmp = strict_strtol((char *)p + strlen(option"="), 10, &res); \
-} while (0)
-
-void __init prom_init_env(void)
+void __init fw_init_env(void)
 {
-	/* pmon passes arguments in 32bit pointers */
-	int *_prom_envp;
+	/* PMON passes arguments in 32bit pointers */
 	unsigned long bus_clock;
 	unsigned int processor_id;
-	long l;
 
-	/* firmware arguments are initialized in head.S */
-	_prom_envp = (int *)fw_arg2;
+	bus_clock = fw_getenvl("busclock");
+	cpu_clock_freq = fw_getenvl("cpuclock");
+	memsize = fw_getenvl("memsize");
+	highmemsize = fw_getenvl("highmemsize");
 
-	l = (long)*_prom_envp;
-	while (l != 0) {
-		parse_even_earlier(bus_clock, "busclock", l);
-		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
-		parse_even_earlier(memsize, "memsize", l);
-		parse_even_earlier(highmemsize, "highmemsize", l);
-		_prom_envp++;
-		l = (long)*_prom_envp;
-	}
 	if (memsize == 0)
 		memsize = 256;
 	if (bus_clock == 0)
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 19d3415..a40ab27 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -10,6 +10,8 @@
 
 #include <linux/bootmem.h>
 
+#include <asm/fw/fw.h>
+
 #include <loongson.h>
 
 /* Loongson CPU address windows config space base address */
@@ -26,8 +28,8 @@ void __init prom_init(void)
 		ioremap(LOONGSON_ADDRWINCFG_BASE, LOONGSON_ADDRWINCFG_SIZE);
 #endif
 
-	prom_init_cmdline();
-	prom_init_env();
+	fw_init_cmdline();
+	fw_init_env();
 	prom_init_memory();
 
 	/*init the uart base address */
-- 
1.7.10.3
