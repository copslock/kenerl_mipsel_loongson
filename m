Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 15:55:09 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:23039 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226115AbVDKOyv>;
	Mon, 11 Apr 2005 15:54:51 +0100
Received: MO(mo01)id j3BEsjY9005909; Mon, 11 Apr 2005 23:54:45 +0900 (JST)
Received: MDO(mdo01) id j3BEsic8007943; Mon, 11 Apr 2005 23:54:45 +0900 (JST)
Received: 4UMRO01 id j3BEsird005894; Mon, 11 Apr 2005 23:54:44 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Mon, 11 Apr 2005 23:54:43 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: bcu update
Message-Id: <20050411235443.2f80fe64.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This patch had added EXPORT_SYMBOL() and had removed early_initcall().

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff c-orig/arch/mips/vr41xx/common/bcu.c c/arch/mips/vr41xx/common/bcu.c
--- c-orig/arch/mips/vr41xx/common/bcu.c	Thu Dec  2 13:56:02 2004
+++ c/arch/mips/vr41xx/common/bcu.c	Sat Apr  9 23:28:45 2005
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -28,20 +28,16 @@
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Added support for NEC VR4133.
  */
-#include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
 
-#define IO_MEM_RESOURCE_START	0UL
-#define IO_MEM_RESOURCE_END	0x1fffffffUL
-
-#define CLKSPEEDREG_TYPE1	KSEG1ADDR(0x0b000014)
-#define CLKSPEEDREG_TYPE2	KSEG1ADDR(0x0f000014)
+#define CLKSPEEDREG_TYPE1	(void __iomem *)KSEG1ADDR(0x0b000014)
+#define CLKSPEEDREG_TYPE2	(void __iomem *)KSEG1ADDR(0x0f000014)
  #define CLKSP(x)		((x) & 0x001f)
  #define CLKSP_VR4133(x)	((x) & 0x0007)
 
@@ -63,11 +59,15 @@
 	return vr41xx_vtclock;
 }
 
+EXPORT_SYMBOL_GPL(vr41xx_get_vtclock_frequency);
+
 unsigned long vr41xx_get_tclock_frequency(void)
 {
 	return vr41xx_tclock;
 }
 
+EXPORT_SYMBOL_GPL(vr41xx_get_tclock_frequency);
+
 static inline uint16_t read_clkspeed(void)
 {
 	switch (current_cpu_data.cputype) {
@@ -207,7 +207,7 @@
 	return tclock;
 }
 
-static int __init vr41xx_bcu_init(void)
+void vr41xx_calculate_clock_frequency(void)
 {
 	unsigned long pclock;
 	uint16_t clkspeed;
@@ -217,11 +217,6 @@
 	pclock = calculate_pclock(clkspeed);
 	vr41xx_vtclock = calculate_vtclock(clkspeed, pclock);
 	vr41xx_tclock = calculate_tclock(clkspeed, pclock, vr41xx_vtclock);
-
-	iomem_resource.start = IO_MEM_RESOURCE_START;
-	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-	return 0;
 }
 
-early_initcall(vr41xx_bcu_init);
+EXPORT_SYMBOL_GPL(vr41xx_calculate_clock_frequency);
diff -urN -X dontdiff c-orig/include/asm-mips/vr41xx/vr41xx.h c/include/asm-mips/vr41xx/vr41xx.h
--- c-orig/include/asm-mips/vr41xx/vr41xx.h	Tue Mar  8 08:11:27 2005
+++ c/include/asm-mips/vr41xx/vr41xx.h	Sat Apr  9 23:29:46 2005
@@ -45,6 +45,7 @@
 /*
  * Bus Control Uint
  */
+extern unsigned long vr41xx_calculate_clock_frequency(void);
 extern unsigned long vr41xx_get_vtclock_frequency(void);
 extern unsigned long vr41xx_get_tclock_frequency(void);
 
