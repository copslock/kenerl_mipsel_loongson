Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:50:57 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54992 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903765Ab2FZEtt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:49:49 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbR-0002zj-AS; Mon, 25 Jun 2012 23:42:13 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 18/33] MIPS: Loongson: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:33 -0500
Message-Id: <1340685708-14408-19-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33821
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

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |   51 ++++++++++++------------
 arch/mips/loongson/common/env.c                |    9 ++---
 arch/mips/loongson/common/init.c               |   10 ++---
 3 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index b19c5b4..332abd0 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -1,11 +1,10 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef __ASM_MACH_LOONGSON_LOONGSON_H
@@ -80,13 +79,13 @@ static inline void do_perfcnt_IRQ(void)
 
 #define LOONGSON_BOOT_BASE	0x1fc00000
 #define LOONGSON_BOOT_SIZE	0x00100000	/* 1M */
-#define LOONGSON_BOOT_TOP 	(LOONGSON_BOOT_BASE+LOONGSON_BOOT_SIZE-1)
-#define LOONGSON_REG_BASE 	0x1fe00000
-#define LOONGSON_REG_SIZE 	0x00100000	/* 256Bytes + 256Bytes + ??? */
+#define LOONGSON_BOOT_TOP	(LOONGSON_BOOT_BASE+LOONGSON_BOOT_SIZE-1)
+#define LOONGSON_REG_BASE	0x1fe00000
+#define LOONGSON_REG_SIZE	0x00100000	/* 256Bytes + 256Bytes + ??? */
 #define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
 
-#define LOONGSON_LIO1_BASE 	0x1ff00000
-#define LOONGSON_LIO1_SIZE 	0x00100000	/* 1M */
+#define LOONGSON_LIO1_BASE	0x1ff00000
+#define LOONGSON_LIO1_SIZE	0x00100000	/* 1M */
 #define LOONGSON_LIO1_TOP	(LOONGSON_LIO1_BASE+LOONGSON_LIO1_SIZE-1)
 
 #define LOONGSON_PCILO0_BASE	0x10000000
@@ -113,13 +112,13 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCI_REG(x)	LOONGSON_REG(LOONGSON_PCICONFIGBASE + (x))
 #define LOONGSON_PCIDID		LOONGSON_PCI_REG(0x00)
 #define LOONGSON_PCICMD		LOONGSON_PCI_REG(0x04)
-#define LOONGSON_PCICLASS 	LOONGSON_PCI_REG(0x08)
+#define LOONGSON_PCICLASS	LOONGSON_PCI_REG(0x08)
 #define LOONGSON_PCILTIMER	LOONGSON_PCI_REG(0x0c)
-#define LOONGSON_PCIBASE0 	LOONGSON_PCI_REG(0x10)
-#define LOONGSON_PCIBASE1 	LOONGSON_PCI_REG(0x14)
-#define LOONGSON_PCIBASE2 	LOONGSON_PCI_REG(0x18)
-#define LOONGSON_PCIBASE3 	LOONGSON_PCI_REG(0x1c)
-#define LOONGSON_PCIBASE4 	LOONGSON_PCI_REG(0x20)
+#define LOONGSON_PCIBASE0	LOONGSON_PCI_REG(0x10)
+#define LOONGSON_PCIBASE1	LOONGSON_PCI_REG(0x14)
+#define LOONGSON_PCIBASE2	LOONGSON_PCI_REG(0x18)
+#define LOONGSON_PCIBASE3	LOONGSON_PCI_REG(0x1c)
+#define LOONGSON_PCIBASE4	LOONGSON_PCI_REG(0x20)
 #define LOONGSON_PCIEXPRBASE	LOONGSON_PCI_REG(0x30)
 #define LOONGSON_PCIINT		LOONGSON_PCI_REG(0x3c)
 
@@ -130,7 +129,7 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCICMD_MABORT_CLR	0x20000000
 #define LOONGSON_PCICMD_MTABORT_CLR	0x10000000
 #define LOONGSON_PCICMD_TABORT_CLR	0x08000000
-#define LOONGSON_PCICMD_MPERR_CLR 	0x01000000
+#define LOONGSON_PCICMD_MPERR_CLR	0x01000000
 #define LOONGSON_PCICMD_PERRRESPEN	0x00000040
 #define LOONGSON_PCICMD_ASTEPEN		0x00000080
 #define LOONGSON_PCICMD_SERREN		0x00000100
@@ -171,25 +170,25 @@ static inline void do_perfcnt_IRQ(void)
 
 /* GPIO Regs - r/w */
 
-#define LOONGSON_GPIODATA 		LOONGSON_REG(LOONGSON_REGBASE + 0x1c)
+#define LOONGSON_GPIODATA		LOONGSON_REG(LOONGSON_REGBASE + 0x1c)
 #define LOONGSON_GPIOIE			LOONGSON_REG(LOONGSON_REGBASE + 0x20)
 
 /* ICU Configuration Regs - r/w */
 
 #define LOONGSON_INTEDGE		LOONGSON_REG(LOONGSON_REGBASE + 0x24)
-#define LOONGSON_INTSTEER 		LOONGSON_REG(LOONGSON_REGBASE + 0x28)
+#define LOONGSON_INTSTEER		LOONGSON_REG(LOONGSON_REGBASE + 0x28)
 #define LOONGSON_INTPOL			LOONGSON_REG(LOONGSON_REGBASE + 0x2c)
 
 /* ICU Enable Regs - IntEn & IntISR are r/o. */
 
-#define LOONGSON_INTENSET 		LOONGSON_REG(LOONGSON_REGBASE + 0x30)
-#define LOONGSON_INTENCLR 		LOONGSON_REG(LOONGSON_REGBASE + 0x34)
+#define LOONGSON_INTENSET		LOONGSON_REG(LOONGSON_REGBASE + 0x30)
+#define LOONGSON_INTENCLR		LOONGSON_REG(LOONGSON_REGBASE + 0x34)
 #define LOONGSON_INTEN			LOONGSON_REG(LOONGSON_REGBASE + 0x38)
 #define LOONGSON_INTISR			LOONGSON_REG(LOONGSON_REGBASE + 0x3c)
 
 /* ICU */
 #define LOONGSON_ICU_MBOXES		0x0000000f
-#define LOONGSON_ICU_MBOXES_SHIFT 	0
+#define LOONGSON_ICU_MBOXES_SHIFT	0
 #define LOONGSON_ICU_DMARDY		0x00000010
 #define LOONGSON_ICU_DMAEMPTY		0x00000020
 #define LOONGSON_ICU_COPYRDY		0x00000040
@@ -210,10 +209,10 @@ static inline void do_perfcnt_IRQ(void)
 
 /* PCI prefetch window base & mask */
 
-#define LOONGSON_MEM_WIN_BASE_L 	LOONGSON_REG(LOONGSON_REGBASE + 0x40)
-#define LOONGSON_MEM_WIN_BASE_H 	LOONGSON_REG(LOONGSON_REGBASE + 0x44)
-#define LOONGSON_MEM_WIN_MASK_L 	LOONGSON_REG(LOONGSON_REGBASE + 0x48)
-#define LOONGSON_MEM_WIN_MASK_H 	LOONGSON_REG(LOONGSON_REGBASE + 0x4c)
+#define LOONGSON_MEM_WIN_BASE_L		LOONGSON_REG(LOONGSON_REGBASE + 0x40)
+#define LOONGSON_MEM_WIN_BASE_H		LOONGSON_REG(LOONGSON_REGBASE + 0x44)
+#define LOONGSON_MEM_WIN_MASK_L		LOONGSON_REG(LOONGSON_REGBASE + 0x48)
+#define LOONGSON_MEM_WIN_MASK_H		LOONGSON_REG(LOONGSON_REGBASE + 0x4c)
 
 /* PCI_Hit*_Sel_* */
 
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index 681690a..8b6ccf8 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -1,4 +1,8 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Based on Ocelot Linux port, which is
  * Copyright 2001 MontaVista Software Inc.
  * Author: jsun@mvista.com or jsun@junsun.net
@@ -11,11 +15,6 @@
  *
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #include <linux/module.h>
 
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index a40ab27..ebfb1c3 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -1,13 +1,11 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
-
 #include <linux/bootmem.h>
 
 #include <asm/fw/fw.h>
-- 
1.7.10.3
