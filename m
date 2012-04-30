Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:51:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53150 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903709Ab2D3LuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:50:21 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 13/14] MIPS: lantiq: add xway soc ids
Date:   Mon, 30 Apr 2012 13:33:08 +0200
Message-Id: <1335785589-32532-13-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add the soc ids for additional xway socs. The patch also merges the amazon_se
code with the other socs.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   27 ++++-
 arch/mips/lantiq/prom.h                            |    5 +
 arch/mips/lantiq/xway/Makefile                     |    6 +-
 arch/mips/lantiq/xway/prom-ase.c                   |   39 -------
 arch/mips/lantiq/xway/prom-xway.c                  |   54 ---------
 arch/mips/lantiq/xway/prom.c                       |  115 ++++++++++++++++++++
 6 files changed, 144 insertions(+), 102 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/prom-ase.c
 delete mode 100644 arch/mips/lantiq/xway/prom-xway.c
 create mode 100644 arch/mips/lantiq/xway/prom.c

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 8bc9030..af6c0f0 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -17,17 +17,32 @@
 #define SOC_ID_DANUBE1		0x129
 #define SOC_ID_DANUBE2		0x12B
 #define SOC_ID_TWINPASS		0x12D
-#define SOC_ID_AMAZON_SE	0x152
+#define SOC_ID_AMAZON_SE_1	0x152 /* 50601 */
+#define SOC_ID_AMAZON_SE_2	0x153 /* 50600 */
 #define SOC_ID_ARX188		0x16C
-#define SOC_ID_ARX168		0x16D
+#define SOC_ID_ARX168_1		0x16D
+#define SOC_ID_ARX168_2		0x16E
 #define SOC_ID_ARX182		0x16F
-
-/* SoC Types */
+#define SOC_ID_GRX188		0x170
+#define SOC_ID_GRX168		0x171
+
+#define SOC_ID_VRX288		0x1C0 /* v1.1 */
+#define SOC_ID_VRX282		0x1C1 /* v1.1 */
+#define SOC_ID_VRX268		0x1C2 /* v1.1 */
+#define SOC_ID_GRX268		0x1C8 /* v1.1 */
+#define SOC_ID_GRX288		0x1C9 /* v1.1 */
+#define SOC_ID_VRX288_2		0x00B /* v1.2 */
+#define SOC_ID_VRX268_2		0x00C /* v1.2 */
+#define SOC_ID_GRX288_2		0x00D /* v1.2 */
+#define SOC_ID_GRX282_2		0x00E /* v1.2 */
+
+ /* SoC Types */
 #define SOC_TYPE_DANUBE		0x01
 #define SOC_TYPE_TWINPASS	0x02
 #define SOC_TYPE_AR9		0x03
-#define SOC_TYPE_VR9		0x04
-#define SOC_TYPE_AMAZON_SE	0x05
+#define SOC_TYPE_VR9		0x04 /* v1.1 */
+#define SOC_TYPE_VR9_2		0x05 /* v1.2 */
+#define SOC_TYPE_AMAZON_SE	0x06
 
 /* ASC0/1 - serial port */
 #define LTQ_ASC0_BASE_ADDR	0x1E100400
diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
index b4229d9..90070a5 100644
--- a/arch/mips/lantiq/prom.h
+++ b/arch/mips/lantiq/prom.h
@@ -10,16 +10,21 @@
 #define _LTQ_PROM_H__
 
 #define LTQ_SYS_TYPE_LEN	0x100
+#define LTQ_SYS_REV_LEN         0x10
 
 struct ltq_soc_info {
 	unsigned char *name;
 	unsigned int rev;
+	unsigned char rev_type[LTQ_SYS_REV_LEN];
+	unsigned int srev;
 	unsigned int partnum;
 	unsigned int type;
 	unsigned char sys_type[LTQ_SYS_TYPE_LEN];
+	unsigned char *compatible;
 };
 
 extern void ltq_soc_detect(struct ltq_soc_info *i);
 extern void ltq_soc_setup(void);
+extern void ltq_soc_init(void);
 
 #endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index c517f2e..42d5fda 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,7 +1,7 @@
-obj-y := pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
+obj-y := prom.o pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
 
-obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o setup-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o setup-ase.o
+obj-$(CONFIG_SOC_XWAY) += clk-xway.o setup-xway.o
+obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o setup-ase.o
 
 obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
 obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
diff --git a/arch/mips/lantiq/xway/prom-ase.c b/arch/mips/lantiq/xway/prom-ase.c
deleted file mode 100644
index ae4959a..0000000
--- a/arch/mips/lantiq/xway/prom-ase.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/export.h>
-#include <linux/clk.h>
-#include <asm/bootinfo.h>
-#include <asm/time.h>
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-
-#define SOC_AMAZON_SE	"Amazon_SE"
-
-#define PART_SHIFT	12
-#define PART_MASK	0x0FFFFFFF
-#define REV_SHIFT	28
-#define REV_MASK	0xF0000000
-
-void __init ltq_soc_detect(struct ltq_soc_info *i)
-{
-	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
-	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
-	switch (i->partnum) {
-	case SOC_ID_AMAZON_SE:
-		i->name = SOC_AMAZON_SE;
-		i->type = SOC_TYPE_AMAZON_SE;
-		break;
-
-	default:
-		unreachable();
-		break;
-	}
-}
diff --git a/arch/mips/lantiq/xway/prom-xway.c b/arch/mips/lantiq/xway/prom-xway.c
deleted file mode 100644
index 2228133..0000000
--- a/arch/mips/lantiq/xway/prom-xway.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/export.h>
-#include <linux/clk.h>
-#include <asm/bootinfo.h>
-#include <asm/time.h>
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-
-#define SOC_DANUBE	"Danube"
-#define SOC_TWINPASS	"Twinpass"
-#define SOC_AR9		"AR9"
-
-#define PART_SHIFT	12
-#define PART_MASK	0x0FFFFFFF
-#define REV_SHIFT	28
-#define REV_MASK	0xF0000000
-
-void __init ltq_soc_detect(struct ltq_soc_info *i)
-{
-	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
-	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
-	switch (i->partnum) {
-	case SOC_ID_DANUBE1:
-	case SOC_ID_DANUBE2:
-		i->name = SOC_DANUBE;
-		i->type = SOC_TYPE_DANUBE;
-		break;
-
-	case SOC_ID_TWINPASS:
-		i->name = SOC_TWINPASS;
-		i->type = SOC_TYPE_DANUBE;
-		break;
-
-	case SOC_ID_ARX188:
-	case SOC_ID_ARX168:
-	case SOC_ID_ARX182:
-		i->name = SOC_AR9;
-		i->type = SOC_TYPE_AR9;
-		break;
-
-	default:
-		unreachable();
-		break;
-	}
-}
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
new file mode 100644
index 0000000..248429a
--- /dev/null
+++ b/arch/mips/lantiq/xway/prom.c
@@ -0,0 +1,115 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/export.h>
+#include <linux/clk.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+
+#include <lantiq_soc.h>
+
+#include "../prom.h"
+
+#define SOC_DANUBE	"Danube"
+#define SOC_TWINPASS	"Twinpass"
+#define SOC_AMAZON_SE	"Amazon_SE"
+#define SOC_AR9		"AR9"
+#define SOC_GR9		"GR9"
+#define SOC_VR9		"VR9"
+
+#define COMP_DANUBE	"lantiq,danube"
+#define COMP_TWINPASS	"lantiq,twinpass"
+#define COMP_AMAZON_SE	"lantiq,ase"
+#define COMP_AR9	"lantiq,ar9"
+#define COMP_GR9	"lantiq,gr9"
+#define COMP_VR9	"lantiq,vr9"
+
+#define PART_SHIFT	12
+#define PART_MASK	0x0FFFFFFF
+#define REV_SHIFT	28
+#define REV_MASK	0xF0000000
+
+void __init ltq_soc_detect(struct ltq_soc_info *i)
+{
+	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
+	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
+	sprintf(i->rev_type, "1.%d", i->rev);
+	switch (i->partnum) {
+	case SOC_ID_DANUBE1:
+	case SOC_ID_DANUBE2:
+		i->name = SOC_DANUBE;
+		i->type = SOC_TYPE_DANUBE;
+		i->compatible = COMP_DANUBE;
+		break;
+
+	case SOC_ID_TWINPASS:
+		i->name = SOC_TWINPASS;
+		i->type = SOC_TYPE_DANUBE;
+		i->compatible = COMP_TWINPASS;
+		break;
+
+	case SOC_ID_ARX188:
+	case SOC_ID_ARX168_1:
+	case SOC_ID_ARX168_2:
+	case SOC_ID_ARX182:
+		i->name = SOC_AR9;
+		i->type = SOC_TYPE_AR9;
+		i->compatible = COMP_AR9;
+		break;
+
+	case SOC_ID_GRX188:
+	case SOC_ID_GRX168:
+		i->name = SOC_GR9;
+		i->type = SOC_TYPE_AR9;
+		i->compatible = COMP_GR9;
+		break;
+
+	case SOC_ID_AMAZON_SE_1:
+	case SOC_ID_AMAZON_SE_2:
+#ifdef CONFIG_PCI
+		panic("ase is only supported for non pci kernels");
+#endif
+		i->name = SOC_AMAZON_SE;
+		i->type = SOC_TYPE_AMAZON_SE;
+		i->compatible = COMP_AMAZON_SE;
+		break;
+
+	case SOC_ID_VRX282:
+	case SOC_ID_VRX268:
+	case SOC_ID_VRX288:
+		i->name = SOC_VR9;
+		i->type = SOC_TYPE_VR9;
+		i->compatible = COMP_VR9;
+		break;
+
+	case SOC_ID_GRX268:
+	case SOC_ID_GRX288:
+		i->name = SOC_GR9;
+		i->type = SOC_TYPE_VR9;
+		i->compatible = COMP_GR9;
+		break;
+
+	case SOC_ID_VRX268_2:
+	case SOC_ID_VRX288_2:
+		i->name = SOC_VR9;
+		i->type = SOC_TYPE_VR9_2;
+		i->compatible = COMP_VR9;
+		break;
+
+	case SOC_ID_GRX282_2:
+	case SOC_ID_GRX288_2:
+		i->name = SOC_GR9;
+		i->type = SOC_TYPE_VR9_2;
+		i->compatible = COMP_GR9;
+		break;
+
+	default:
+		unreachable();
+		break;
+	}
+}
-- 
1.7.9.1
