Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 15:03:02 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:51878 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991100AbdL1N5DgFFq5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 14:57:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 13/15] MIPS: JZ4770: Workaround for corrupted DMA transfers
Date:   Thu, 28 Dec 2017 14:56:32 +0100
Message-Id: <20171228135634.30000-14-paul@crapouillou.net>
In-Reply-To: <20171228135634.30000-1-paul@crapouillou.net>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514469423; bh=Ik76rjLyD5r7pNHY15VVGxUbEJ1MiTSb1K28wuWOHeo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dpNvBCg91cxXKhDTRZZ83+FzV56yVbZ8yszdi01Gg4rIE5ltDiyQXxzXGw9ablYTy/U7k5guRz541zsRr1WjVCsOBTKxef6xuwH8BWCd8rnZbt2frspee9lLWCmKN0TdK+NrT0uYil0ZQJ0EHuFeJlQVoycOO/+WnQVO/WscX3E=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61659
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
