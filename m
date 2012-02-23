Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:20:03 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:57479 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903755Ab2BWQT6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:19:58 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 13/14] MIPS: lantiq: unify xway prom code
Date:   Thu, 23 Feb 2012 17:03:12 +0100
Message-Id: <1330012993-13510-13-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The xway prom-ase.c and prom-xway.c files are redundant. Unify the 2 files.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/Makefile    |    5 +--
 arch/mips/lantiq/xway/prom-ase.c  |   48 ----------------------
 arch/mips/lantiq/xway/prom-xway.c |   64 ------------------------------
 arch/mips/lantiq/xway/prom.c      |   79 +++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 116 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/prom-ase.c
 delete mode 100644 arch/mips/lantiq/xway/prom-xway.c
 create mode 100644 arch/mips/lantiq/xway/prom.c

diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 4dcb96f..89f0a11 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,7 +1,4 @@
-obj-y := sysctrl.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o clk.o
-
-obj-$(CONFIG_SOC_XWAY) += prom-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += prom-ase.o
+obj-y := prom.o sysctrl.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o clk.o
 
 obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
 obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
diff --git a/arch/mips/lantiq/xway/prom-ase.c b/arch/mips/lantiq/xway/prom-ase.c
deleted file mode 100644
index 3f86a3b..0000000
--- a/arch/mips/lantiq/xway/prom-ase.c
+++ /dev/null
@@ -1,48 +0,0 @@
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
-#include "devices.h"
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
-	sprintf(i->rev_type, "1.%d", i->rev);
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
-
-void __init ltq_soc_setup(void)
-{
-	ltq_register_ase_asc();
-	ltq_register_gpio();
-	ltq_register_wdt();
-}
diff --git a/arch/mips/lantiq/xway/prom-xway.c b/arch/mips/lantiq/xway/prom-xway.c
deleted file mode 100644
index d823a92..0000000
--- a/arch/mips/lantiq/xway/prom-xway.c
+++ /dev/null
@@ -1,64 +0,0 @@
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
-#include "devices.h"
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
-	sprintf(i->rev_type, "1.%d", i->rev);
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
-
-void __init ltq_soc_setup(void)
-{
-	ltq_register_asc(0);
-	ltq_register_asc(1);
-	ltq_register_gpio();
-	ltq_register_wdt();
-}
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
new file mode 100644
index 0000000..0929acb
--- /dev/null
+++ b/arch/mips/lantiq/xway/prom.c
@@ -0,0 +1,79 @@
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
+#include "devices.h"
+
+#define SOC_DANUBE	"Danube"
+#define SOC_TWINPASS	"Twinpass"
+#define SOC_AR9		"AR9"
+#define SOC_VR9		"VR9"
+
+#define PART_SHIFT	12
+#define PART_MASK	0x0FFFFFFF
+#define REV_SHIFT	28
+#define REV_MASK	0xF0000000
+
+#define SOC_AMAZON_SE	"Amazon_SE"
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
+		break;
+
+	case SOC_ID_TWINPASS:
+		i->name = SOC_TWINPASS;
+		i->type = SOC_TYPE_DANUBE;
+		break;
+
+	case SOC_ID_ARX188:
+	case SOC_ID_ARX168:
+	case SOC_ID_ARX182:
+		i->name = SOC_AR9;
+		i->type = SOC_TYPE_AR9;
+		break;
+
+	case SOC_ID_AMAZON_SE:
+		i->name = SOC_AMAZON_SE;
+		i->type = SOC_TYPE_AMAZON_SE;
+#ifdef CONFIG_PCI
+		panic("ase is only supported for non pci kernels");
+#endif
+		break;
+
+	default:
+		unreachable();
+		break;
+	}
+}
+
+void __init ltq_soc_setup(void)
+{
+	if (ltq_is_ase()) {
+		ltq_register_ase_asc();
+	} else {
+		ltq_register_asc(0);
+		ltq_register_asc(1);
+	}
+	ltq_register_gpio();
+	ltq_register_wdt();
+}
-- 
1.7.7.1
