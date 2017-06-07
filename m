Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 22:08:29 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59894 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993932AbdFGUE7AbCOq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 22:04:59 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 10/15] MIPS: ingenic: Add machine info for supported boards
Date:   Wed,  7 Jun 2017 22:04:34 +0200
Message-Id: <20170607200439.24450-11-paul@crapouillou.net>
In-Reply-To: <20170607200439.24450-1-paul@crapouillou.net>
References: <20170607200439.24450-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58281
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
 arch/mips/jz4740/boards.c | 16 ++++++++++++++++
 arch/mips/jz4740/setup.c  | 34 +++++++++++++++++++++++++++++-----
 4 files changed, 47 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/jz4740/boards.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..f36ffb93efd9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -370,6 +370,7 @@ config MACH_INGENIC
 	select BUILTIN_DTB
 	select USE_OF
 	select LIBFDT
+	select MIPS_MACHINE
 
 config LANTIQ
 	bool "Lantiq based platforms"
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 39d70bde8cfe..87feb246fafe 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y += prom.o time.o reset.o setup.o \
-	platform.o timer.o
+	platform.o timer.o boards.o
 
 obj-$(CONFIG_MACH_JZ4740) += gpio.o
 
diff --git a/arch/mips/jz4740/boards.c b/arch/mips/jz4740/boards.c
new file mode 100644
index 000000000000..a3cf64cf004a
--- /dev/null
+++ b/arch/mips/jz4740/boards.c
@@ -0,0 +1,16 @@
+/*
+ * Ingenic boards support
+ *
+ * Copyright 2017, Paul Cercueil <paul@crapouillou.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or later
+ * as published by the Free Software Foundation.
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
