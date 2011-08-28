Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2011 13:24:53 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:46434 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491091Ab1H1LYs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Aug 2011 13:24:48 +0200
Received: from aba by alius.turmzimmer.net with local (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1QxdTl-00005d-Ej; Sun, 28 Aug 2011 11:24:41 +0000
Message-Id: <E1QxdTl-00005d-Ej@alius.turmzimmer.net>
From:   Andreas Barth <aba@not.so.argh.org>
Date:   Sun, 28 Aug 2011 11:19:22 +0000
Subject: [PATCH] mips/loongson: unify machtype-code into common/machtype.c, get rid of include/asm/mach-loongson/machine.h
To:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
X-archive-position: 31006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20787

Use prid to find out whether the kernel runs on an Loongson 2E or 2F machine
instead of compiling in defaults while building the kernel. On 2F, continue
to use the current mechanismn to find out which exact kind of hardware it
is running on.
---
 arch/mips/include/asm/mach-loongson/machine.h |   27 -----------
 arch/mips/loongson/common/machtype.c          |   63 +++++++++++++++++++++++--
 arch/mips/loongson/common/serial.c            |    1 -
 arch/mips/loongson/lemote-2f/Makefile         |    2 +-
 arch/mips/loongson/lemote-2f/irq.c            |    1 -
 arch/mips/loongson/lemote-2f/machtype.c       |   45 ------------------
 6 files changed, 60 insertions(+), 79 deletions(-)
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
index 2efd5d9..7b2413f 100644
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
@@ -13,10 +15,15 @@
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
-#include <machine.h>
 
 /* please ensure the length of the machtype string is less than 50 */
 #define MACHTYPE_LEN 50
+#ifdef ASM_FILE
+#define CPU_REGISTER_WRAP(x) x
+#else
+#define CPU_REGISTER_WRAP(x) #x
+#endif
+#define LOONGSON_COP0_PRID CPU_REGISTER_WRAP($15)
 
 static const char *system_types[] = {
 	[MACH_LOONGSON_UNKNOWN]         "unknown loongson machine",
@@ -35,8 +42,38 @@ const char *get_system_type(void)
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
@@ -44,11 +81,29 @@ void __init prom_init_machtype(void)
 	char *p, str[MACHTYPE_LEN + 1];
 	int machtype = MACH_LEMOTE_FL2E;
 
-	mips_machtype = LOONGSON_MACHTYPE;
+        /* We check first prid. If it is 2E, then use the function
+         * as it was provided by 2E up to now, i.e. just return.
+         * If not, it's 2F and use the functions of 2F subtree.
+         */
+
+        uint32_t prid;
+        asm volatile ("mfc0 %0, " LOONGSON_COP0_PRID : "=r" (prid));
+        switch (prid)
+            {
+              /* Loongson 2E.  */
+            case 0x6302:
+	        mips_machtype = MACH_LEMOTE_FL2E;
+                break;
+              /* Loongson 2F.  */
+            default:
+	        mips_machtype = MACH_LEMOTE_FL2F;
+                break;
+            }
 
 	p = strstr(arcs_cmdline, "machtype=");
 	if (!p) {
-		mach_prom_init_machtype();
+		if (mips_machtype == MACH_LEMOTE_FL2F)
+                        mach_prom_init_machtype();
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
