Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 09:18:17 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:46864 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490950Ab1IOHSM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Sep 2011 09:18:12 +0200
Received: from aba by alius.turmzimmer.net with local (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1R46D5-0000tw-PP; Thu, 15 Sep 2011 07:18:11 +0000
Message-Id: <E1R46D5-0000tw-PP@alius.turmzimmer.net>
From:   Andreas Barth <aba@not.so.argh.org>
Date:   Sun, 28 Aug 2011 11:19:22 +0000
Subject: [PATCH] mips/loongson: unify machtype-code into common/machtype.c, get rid of include/asm/mach-loongson/machine.h
To:     linux-mips@linux-mips.org, debian-mips@lists.debian.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
X-archive-position: 31091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3

Use prid to find out whether the kernel runs on an Loongson 2E or 2F machine
instead of compiling in defaults while building the kernel. On 2F, continue
to use the current mechanismn to find out which exact kind of hardware it
is running on.

Relative to the previous version, uses read_c0_prid() instead of assembler
to read cprid.

Signed-off-by: Andreas Barth <aba@not.so.argh.org>
---
 arch/mips/include/asm/mach-loongson/machine.h |   27 --------------
 arch/mips/loongson/common/machtype.c          |   48 ++++++++++++++++++++++--
 arch/mips/loongson/common/serial.c            |    1 -
 arch/mips/loongson/lemote-2f/Makefile         |    2 +-
 arch/mips/loongson/lemote-2f/irq.c            |    1 -
 arch/mips/loongson/lemote-2f/machtype.c       |   45 -----------------------
 6 files changed, 45 insertions(+), 79 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson/machine.h
 delete mode 100644 arch/mips/loongson/lemote-2f/machtype.c

diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
deleted file mode 100644
index 4321338..0000000
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin <wuzhangjin@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef __ASM_MACH_LOONGSON_MACHINE_H
-#define __ASM_MACH_LOONGSON_MACHINE_H
-
-#ifdef CONFIG_LEMOTE_FULOONG2E
-
-#define LOONGSON_MACHTYPE MACH_LEMOTE_FL2E
-
-#endif
-
-/* use fuloong2f as the default machine of LEMOTE_MACH2F */
-#ifdef CONFIG_LEMOTE_MACH2F
-
-#define LOONGSON_MACHTYPE MACH_LEMOTE_FL2F
-
-#endif
-
-#endif /* __ASM_MACH_LOONGSON_MACHINE_H */
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 2efd5d9..6658ff8 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
  *
+ * Copyright (c) 2011 Andreas Barth <aba@not.so.argh.org>
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -13,7 +15,6 @@
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
-#include <machine.h>
 
 /* please ensure the length of the machtype string is less than 50 */
 #define MACHTYPE_LEN 50
@@ -35,8 +36,38 @@ const char *get_system_type(void)
 	return system_types[mips_machtype];
 }
 
-void __weak __init mach_prom_init_machtype(void)
+void __init mach_prom_init_machtype(void)
 {
+	/* We share the same kernel image file among Lemote 2F family
+	 * of machines, and provide the machtype= kernel command line
+	 * to users to indicate their machine, this command line will
+	 * be passed by the latest PMON automatically. and fortunately,
+	 * up to now, we can get the machine type from the PMON_VER=
+	 * commandline directly except the NAS machine, In the old
+	 * machines, this will help the users a lot.
+	 *
+	 * If no "machtype=" passed, get machine type from "PMON_VER=".
+	 * 	PMON_VER=LM8089		Lemote 8.9'' netbook
+	 * 	         LM8101		Lemote 10.1'' netbook
+	 * 	(The above two netbooks have the same kernel support)
+	 *	         LM6XXX		Lemote FuLoong(2F) box series
+	 *	         LM9XXX		Lemote LynLoong PC series
+	 */
+
+	if (strstr(arcs_cmdline, "PMON_VER=LM")) {
+		if (strstr(arcs_cmdline, "PMON_VER=LM8"))
+			mips_machtype = MACH_LEMOTE_YL2F89;
+		else if (strstr(arcs_cmdline, "PMON_VER=LM6"))
+			mips_machtype = MACH_LEMOTE_FL2F;
+		else if (strstr(arcs_cmdline, "PMON_VER=LM9"))
+			mips_machtype = MACH_LEMOTE_LL2F;
+		else
+			mips_machtype = MACH_LEMOTE_NAS;
+
+		strcat(arcs_cmdline, " machtype=");
+		strcat(arcs_cmdline, get_system_type());
+		strcat(arcs_cmdline, " ");
+	}
 }
 
 void __init prom_init_machtype(void)
@@ -44,11 +75,20 @@ void __init prom_init_machtype(void)
 	char *p, str[MACHTYPE_LEN + 1];
 	int machtype = MACH_LEMOTE_FL2E;
 
-	mips_machtype = LOONGSON_MACHTYPE;
+	/* Set default machtype via prid. If there is no machtype on command
+	 * line, guess from PMON_VER on 2F and add machtype to cmdline
+	 * If there is machtype on command line, use this.
+	 */
+
+	if (read_c0_prid() == 0x6302)
+		mips_machtype = MACH_LEMOTE_FL2E;
+	else
+		mips_machtype = MACH_LEMOTE_FL2F;
 
 	p = strstr(arcs_cmdline, "machtype=");
 	if (!p) {
-		mach_prom_init_machtype();
+	        if (mips_machtype == MACH_LEMOTE_FL2F) 
+	                mach_prom_init_machtype();
 		return;
 	}
 	p += strlen("machtype=");
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 7580873..faaf63d 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -17,7 +17,6 @@
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
-#include <machine.h>
 
 #define PORT(int)			\
 {								\
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 8699a53..4d84b27 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += machtype.o irq.o reset.o ec_kb3310b.o
+obj-y += irq.o reset.o ec_kb3310b.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 14b0818..9c31a92 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -16,7 +16,6 @@
 #include <asm/mipsregs.h>
 
 #include <loongson.h>
-#include <machine.h>
 
 #define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
diff --git a/arch/mips/loongson/lemote-2f/machtype.c b/arch/mips/loongson/lemote-2f/machtype.c
deleted file mode 100644
index e860a27..0000000
--- a/arch/mips/loongson/lemote-2f/machtype.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
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
-void __init mach_prom_init_machtype(void)
-{
-	/* We share the same kernel image file among Lemote 2F family
-	 * of machines, and provide the machtype= kernel command line
-	 * to users to indicate their machine, this command line will
-	 * be passed by the latest PMON automatically. and fortunately,
-	 * up to now, we can get the machine type from the PMON_VER=
-	 * commandline directly except the NAS machine, In the old
-	 * machines, this will help the users a lot.
-	 *
-	 * If no "machtype=" passed, get machine type from "PMON_VER=".
-	 * 	PMON_VER=LM8089		Lemote 8.9'' netbook
-	 * 	         LM8101		Lemote 10.1'' netbook
-	 * 	(The above two netbooks have the same kernel support)
-	 *	         LM6XXX		Lemote FuLoong(2F) box series
-	 *	         LM9XXX		Lemote LynLoong PC series
-	 */
-	if (strstr(arcs_cmdline, "PMON_VER=LM")) {
-		if (strstr(arcs_cmdline, "PMON_VER=LM8"))
-			mips_machtype = MACH_LEMOTE_YL2F89;
-		else if (strstr(arcs_cmdline, "PMON_VER=LM6"))
-			mips_machtype = MACH_LEMOTE_FL2F;
-		else if (strstr(arcs_cmdline, "PMON_VER=LM9"))
-			mips_machtype = MACH_LEMOTE_LL2F;
-		else
-			mips_machtype = MACH_LEMOTE_NAS;
-
-		strcat(arcs_cmdline, " machtype=");
-		strcat(arcs_cmdline, get_system_type());
-		strcat(arcs_cmdline, " ");
-	}
-}
-- 
1.5.6.5
