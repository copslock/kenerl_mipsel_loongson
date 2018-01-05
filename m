Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:30:24 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:37042 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993599AbeAESZe0-bts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:25:34 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v6 13/15] MIPS: JZ4770: Workaround for corrupted DMA transfers
Date:   Fri,  5 Jan 2018 19:25:11 +0100
Message-Id: <20180105182513.16248-14-paul@crapouillou.net>
In-Reply-To: <20180105182513.16248-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515176733; bh=AriQ80RdmkCvXO3hOCrC3fZiNnhxYoaXChrKe9TnqcA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GalwpX7qxvP8g5CAD8DD10cJ+Zmev7Me7y8b1bUGk3fsxuv3JIvTL/WAyhuf4fMNFt5V4SWnFDBqv/CY+Zsdn7wtHZp4qGX8BthGQPQLAwS8a2fpPzjU6LorY6QrCX4A7r48FeAjHt9jGepa9RRc6vLz5naxXyTK2jYwGLrs3mA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61933
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
 v3: No change
 v4: No change
 v5: No change
 v6: No change

diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index cd89536fbba1..18c57c4bf47e 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -22,6 +22,7 @@
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
+#include <asm/page.h>
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
@@ -103,3 +104,26 @@ void __init arch_init_irq(void)
 {
 	irqchip_init();
 }
+
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
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 85bc601e9a0d..5a2c20145aee 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -879,6 +879,14 @@ static void __init arch_mem_init(char **cmdline_p)
 
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
