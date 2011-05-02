Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 May 2011 11:48:10 +0200 (CEST)
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4318 "EHLO
        smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491062Ab1EBJsE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 May 2011 11:48:04 +0200
Received: from starbug-2.trinair2002 (c74072.upc-c.chello.nl [212.187.74.72])
        (authenticated bits=0)
        by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id p429lnRx064895;
        Mon, 2 May 2011 11:47:53 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id 9853D44960;
        Mon,  2 May 2011 11:47:49 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] MIPS: JZ4740: setup: Autodetect physical memory.
Date:   Mon,  2 May 2011 11:47:00 +0200
Message-Id: <1304329620-17659-1-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 1.7.3.4
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips

Assume that the boot loader knows the physical memory of the system and
deduce that information from the contents of the SDRAM control register.
It is still possible to override with with the "mem=" parameter, but we
have a sensible default now.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/setup.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 6a9e14d..d97cfbf 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -1,5 +1,6 @@
 /*
  *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  Copyright (C) 2011, Maarten ter Huurne <maarten@treewalker.org>
  *  JZ4740 setup code
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -14,13 +15,44 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 
+#include <asm/bootinfo.h>
+
+#include <asm/mach-jz4740/base.h>
+
 #include "reset.h"
 
+
+#define JZ4740_EMC_SDRAM_CTRL 0x80
+
+
+static void __init jz4740_detect_mem(void)
+{
+	void __iomem *jz_emc_base;
+	u32 ctrl, bus, bank, rows, cols;
+	phys_t size;
+
+	jz_emc_base = ioremap(JZ4740_EMC_BASE_ADDR, 0x100);
+	ctrl = readl(jz_emc_base + JZ4740_EMC_SDRAM_CTRL);
+	bus = 2 - ((ctrl >> 31) & 1);
+	bank = 1 + ((ctrl >> 19) & 1);
+	cols = 8 + ((ctrl >> 26) & 7);
+	rows = 11 + ((ctrl >> 20) & 3);
+	printk(KERN_DEBUG
+		"SDRAM preconfigured: bus:%u bank:%u rows:%u cols:%u\n",
+		bus, bank, rows, cols);
+	iounmap(jz_emc_base);
+
+	size = 1 << (bus + bank + cols + rows);
+	add_memory_region(0, size, BOOT_MEM_RAM);
+}
+
 void __init plat_mem_setup(void)
 {
 	jz4740_reset_init();
+	jz4740_detect_mem();
 }
 
 const char *get_system_type(void)
-- 
1.7.3.4
