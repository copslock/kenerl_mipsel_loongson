Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:07:12 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:46485 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022605AbZFDNG1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:06:27 +0100
Received: by pzk40 with SMTP id 40so738925pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:06:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kpSrz5Jx632rPehNciYORq8bDiK7qKAQvOSUaqzR7s0=;
        b=AZuP9wMYTNGhq29GjGpRKBu3ZrLKVY0g4xKhjUdqPYxl4UhxeDw6iqMkPmJiglPAjl
         Q6AvYP5Eg0uGK+GkhGfLVtwUK4gEYfHRknKeQjH8RT2Z7DpCWN6woKwqOJr5kIdPLf5V
         /ObjMcfpJeMfLhNy1zYKLpfbZt86npUZeTZPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L49PkCNsJ2q9u1XtoIXgVPUxb67G03vzcNmSpej3MpKXbwSr96C9B/SLmwRI7GvJDB
         3NFdg4bKNllPclm8ePD1r01kAgbXRHYGglRuqofeIZ8Zadn8HPZkvxARYXEHXyv8e2aD
         V63rSYtTbzfm16nn8D+XXu4n6XBJPkte1KozM=
Received: by 10.115.74.1 with SMTP id b1mr2393014wal.168.1244120780727;
        Thu, 04 Jun 2009 06:06:20 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id n33sm3228701wag.32.2009.06.04.06.06.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:06:20 -0700 (PDT)
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
Subject: [loongson-PATCH-v3 11/25] split env out of cmdline.c
Date:	Thu,  4 Jun 2009 21:06:08 +0800
Message-Id: <c091f3a16f0af66b654473ee9ee5c897cd36a8ff.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

add a new init function: prom_init_env() to split environment arguments
initialization out of cmdline.c, the environment arguments are passed
from bootloader, currently is PMON.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    5 +-
 arch/mips/loongson/common/Makefile             |    2 +-
 arch/mips/loongson/common/cmdline.c            |   36 ++------------
 arch/mips/loongson/common/env.c                |   59 ++++++++++++++++++++++++
 arch/mips/loongson/common/init.c               |    1 +
 5 files changed, 69 insertions(+), 34 deletions(-)
 create mode 100644 arch/mips/loongson/common/env.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 656511e..ca591ed 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -20,16 +20,17 @@
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
 
-/* command line arguments */
+/* environment arguments from bootloader */
 extern unsigned long bus_clock, cpu_clock_freq;
 extern unsigned long memsize, highmemsize;
 
 /* loongson-based machines specific reboot setup */
 extern void loongson_reboot_setup(void);
 
-/* loongson-specific command line and memory initialization */
+/* loongson-specific command line, env and memory initialization */
 extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
+extern void __init prom_init_env(void);
 
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 79b2736..030a0a0 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -2,7 +2,7 @@
 # Makefile for loongson based machines.
 #
 
-obj-y += setup.o init.o cmdline.o time.o reset.o irq.o \
+obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
 	pci.o bonito-irq.o mem.o misc.o
 
 #
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 6f603ac..12bb606 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -18,31 +18,23 @@
  * option) any later version.
  */
 
-#include <linux/bootmem.h>
-
 #include <asm/bootinfo.h>
 
-unsigned long bus_clock, cpu_clock_freq;
-unsigned long memsize, highmemsize;
+#include <loongson.h>
+#include <cmdline.h>
 
 int prom_argc;
 /* pmon passes arguments in 32bit pointers */
-int *_prom_argv, *_prom_envp;
-
-#define parse_even_earlier(res, option, p)				\
-do {									\
-	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-			strict_strtol((char *)p + strlen(option"="),	\
-					10, &res);			\
-} while (0)
+int *_prom_argv;
 
 void __init prom_init_cmdline(void)
 {
 	int i;
 	long l;
+
+	/* firmware arguments are initialized in head.S */
 	prom_argc = fw_arg0;
 	_prom_argv = (int *)fw_arg1;
-	_prom_envp = (int *)fw_arg2;
 
 	/* arg[0] is "g", the rest is boot parameters */
 	arcs_cmdline[0] = '\0';
@@ -55,26 +47,8 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " ");
 	}
 
-	/* handle console, root, busclock, cpuclock, memsize, highmemsize
-	arguments */
-
 	if ((strstr(arcs_cmdline, "console=")) == NULL)
 		strcat(arcs_cmdline, " console=ttyS0,115200");
 	if ((strstr(arcs_cmdline, "root=")) == NULL)
 		strcat(arcs_cmdline, " root=/dev/hda1");
-
-	l = (long)*_prom_envp;
-	while (l != 0) {
-		parse_even_earlier(bus_clock, "busclock", l);
-		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
-		parse_even_earlier(memsize, "memsize", l);
-		parse_even_earlier(highmemsize, "highmemsize", l);
-		_prom_envp++;
-		l = (long)*_prom_envp;
-	}
-	if (memsize == 0)
-		memsize = 256;
-
-	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
-		bus_clock, cpu_clock_freq, memsize, highmemsize);
 }
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
new file mode 100644
index 0000000..1a02428
--- /dev/null
+++ b/arch/mips/loongson/common/env.c
@@ -0,0 +1,59 @@
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
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+unsigned long bus_clock, cpu_clock_freq;
+unsigned long memsize, highmemsize;
+
+/* pmon passes arguments in 32bit pointers */
+int *_prom_envp;
+
+#define parse_even_earlier(res, option, p)				\
+do {									\
+	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
+			strict_strtol((char *)p + strlen(option"="),	\
+					10, &res);			\
+} while (0)
+
+void __init prom_init_env(void)
+{
+	long l;
+
+	/* firmware arguments are initialized in head.S */
+	_prom_envp = (int *)fw_arg2;
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
+		bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 76e6fda..1c5a0e6 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -32,6 +32,7 @@ void __init prom_init(void)
 			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
 
 	prom_init_cmdline();
+	prom_init_env();
 	prom_init_memory();
 }
 
-- 
1.6.0.4
