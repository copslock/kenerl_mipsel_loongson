Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 17:23:58 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36744 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdFTPTVJcWti (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 17:19:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 15/17] MIPS: JZ4770: Workaround for corrupted DMA transfers
Date:   Tue, 20 Jun 2017 17:18:53 +0200
Message-Id: <20170620151855.19399-15-paul@crapouillou.net>
In-Reply-To: <20170620151855.19399-1-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170620151855.19399-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58703
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

From: Maarten ter Huurne <maarten@treewalker.org>

We have seen MMC DMA transfers read corrupted data from SDRAM when
a burst interval ends at physical address 0x10000000. To avoid this
problem, we remove the final page of low memory from the memory map.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/jz4740/setup.c | 24 ++++++++++++++++++++++++
 arch/mips/kernel/setup.c |  8 ++++++++
 2 files changed, 32 insertions(+)

 v2: No change

diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index afd84ee966e8..6948b133a15d 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -23,6 +23,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/mips_machine.h>
+#include <asm/page.h>
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
@@ -102,6 +103,29 @@ void __init arch_init_irq(void)
 	irqchip_init();
 }
 
+/*
+ * We have seen MMC DMA transfers read corrupted data from SDRAM when a burst
+ * interval ends at physical address 0x10000000. To avoid this problem, we
+ * remove the final page of low memory from the memory map.
+ */
+void __init jz4770_reserve_unsafe_for_dma(void)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		struct boot_mem_map_entry *entry = boot_mem_map.map + i;
+
+		if (entry->type != BOOT_MEM_RAM)
+			continue;
+
+		if (entry->addr + entry->size != 0x10000000)
+			continue;
+
+		entry->size -= PAGE_SIZE;
+		break;
+	}
+}
+
 static int __init jz4740_machine_setup(void)
 {
 	mips_machine_setup();
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 89785600fde4..cccfd7ba89fe 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -838,6 +838,14 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	parse_early_param();
 
+#ifdef CONFIG_MACH_JZ4770
+	if (current_cpu_type() == CPU_JZRISC &&
+				mips_machtype == MACH_INGENIC_JZ4770) {
+		extern void __init jz4770_reserve_unsafe_for_dma(void);
+		jz4770_reserve_unsafe_for_dma();
+	}
+#endif
+
 	if (usermem) {
 		pr_info("User-defined physical RAM map:\n");
 		print_memory_map();
-- 
2.11.0
