Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:12:44 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:58734 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993129AbeABPJKIMqe9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:09:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 10/15] MIPS: ingenic: Add machine info for supported boards
Date:   Tue,  2 Jan 2018 16:08:43 +0100
Message-Id: <20180102150848.11314-10-paul@crapouillou.net>
In-Reply-To: <20180102150848.11314-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514905748; bh=tQLcnrSHhvGqldjy7VHEifk9sGQpqTBoQIV/bDbBvAQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KsAtFby75jXNKMqAg5LY/+ICqs+89T3iNMwaAQxJU7G2VY3IBzpo4wp4W6VVts/1O54NVCMyBAGMVazYi9KrXzIWGfZUUkTOB9UVceNYvTkP8GQIMH/YHjbo9t3Damc7tfK0ZHyD3CznQFaelgVW1gypAkBKwuXrGH+FiG5amzs=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This makes sure that 'mips_machtype' will be initialized to the SoC
version used on the board.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig         |  1 +
 arch/mips/jz4740/Makefile |  2 +-
 arch/mips/jz4740/boards.c | 12 ++++++++++++
 arch/mips/jz4740/setup.c  | 34 +++++++++++++++++++++++++++++-----
 4 files changed, 43 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/jz4740/boards.c

 v2: No change
 v3: No change
 v4: No change
 v5: Use SPDX license identifier

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..83243e427e36 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -376,6 +376,7 @@ config MACH_INGENIC
 	select BUILTIN_DTB
 	select USE_OF
 	select LIBFDT
+	select MIPS_MACHINE
 
 config LANTIQ
 	bool "Lantiq based platforms"
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 88d6aa7d000b..fc2d3b3c4a80 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -6,7 +6,7 @@
 # Object file lists.
 
 obj-y += prom.o time.o reset.o setup.o \
-	platform.o timer.o
+	platform.o timer.o boards.o
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
diff --git a/arch/mips/jz4740/boards.c b/arch/mips/jz4740/boards.c
new file mode 100644
index 000000000000..13b0bddd8cb7
--- /dev/null
+++ b/arch/mips/jz4740/boards.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic boards support
+ * Copyright 2017, Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <asm/bootinfo.h>
+#include <asm/mips_machine.h>
+
+MIPS_MACHINE(MACH_INGENIC_JZ4740, "qi,lb60", "Qi Hardware Ben Nanonote", NULL);
+MIPS_MACHINE(MACH_INGENIC_JZ4780, "img,ci20",
+			"Imagination Technologies CI20", NULL);
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 6d0152321819..afd84ee966e8 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -22,6 +22,7 @@
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
+#include <asm/mips_machine.h>
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
@@ -53,16 +54,34 @@ static void __init jz4740_detect_mem(void)
 	add_memory_region(0, size, BOOT_MEM_RAM);
 }
 
+static unsigned long __init get_board_mach_type(const void *fdt)
+{
+	const struct mips_machine *mach;
+
+	for (mach = (struct mips_machine *)&__mips_machines_start;
+			mach < (struct mips_machine *)&__mips_machines_end;
+			mach++) {
+		if (!fdt_node_check_compatible(fdt, 0, mach->mach_id))
+			return mach->mach_type;
+	}
+
+	return MACH_INGENIC_JZ4740;
+}
+
 void __init plat_mem_setup(void)
 {
 	int offset;
 
+	if (!early_init_dt_scan(__dtb_start))
+		return;
+
 	jz4740_reset_init();
-	__dt_setup_arch(__dtb_start);
 
 	offset = fdt_path_offset(__dtb_start, "/memory");
 	if (offset < 0)
 		jz4740_detect_mem();
+
+	mips_machtype = get_board_mach_type(__dtb_start);
 }
 
 void __init device_tree_init(void)
@@ -75,13 +94,18 @@ void __init device_tree_init(void)
 
 const char *get_system_type(void)
 {
-	if (IS_ENABLED(CONFIG_MACH_JZ4780))
-		return "JZ4780";
-
-	return "JZ4740";
+	return mips_get_machine_name();
 }
 
 void __init arch_init_irq(void)
 {
 	irqchip_init();
 }
+
+static int __init jz4740_machine_setup(void)
+{
+	mips_machine_setup();
+
+	return 0;
+}
+arch_initcall(jz4740_machine_setup);
-- 
2.11.0
