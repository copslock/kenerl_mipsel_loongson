Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:52:44 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:41914 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994675AbeAPPsVyxnyE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:48:21 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 10/14] MIPS: ingenic: Detect machtype from SoC compatible string
Date:   Tue, 16 Jan 2018 16:48:00 +0100
Message-Id: <20180116154804.21150-11-paul@crapouillou.net>
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516117701; bh=IbPxky1FF9Xu0Bz/LYXQGVTyd+Uv/J7CQcJv6h5y0t8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ey3lqs7ypt8hAmysfEnvc+g+f/q/wLRoJYGiaLBAf9t7UjDDaQTVYPo4gX05gEZ0EI/MHjpLOYdbXHCissfcckxLxRKB5T//VQCF6oh8tTwDhpkLQlSdO804O+g/5TtTAXdTdHS7YyL7Pxlzm8ZBQiPYE+x+T+rT+uEKyIdC54Y=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62186
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

Previously, the mips_machtype variable was always initialized
to MACH_INGENIC_JZ4740 even if running on different SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/jz4740/prom.c  |  1 -
 arch/mips/jz4740/setup.c | 22 +++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

 v2: No change
 v3: No change
 v4: No change
 v5: Use SPDX license identifier
 v6: Init mips_machtype from DT compatible string instead of using
     MIPS_MACHINE
 v7: Fix system name not initialized

diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index a62dd8e6ecf9..eb9f2f97bedb 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -25,7 +25,6 @@
 
 void __init prom_init(void)
 {
-	mips_machtype = MACH_INGENIC_JZ4740;
 	fw_init_cmdline();
 }
 
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 6d0152321819..afb40f8bce96 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -53,6 +53,16 @@ static void __init jz4740_detect_mem(void)
 	add_memory_region(0, size, BOOT_MEM_RAM);
 }
 
+static unsigned long __init get_board_mach_type(const void *fdt)
+{
+	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4780"))
+		return MACH_INGENIC_JZ4780;
+	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4770"))
+		return MACH_INGENIC_JZ4770;
+
+	return MACH_INGENIC_JZ4740;
+}
+
 void __init plat_mem_setup(void)
 {
 	int offset;
@@ -63,6 +73,8 @@ void __init plat_mem_setup(void)
 	offset = fdt_path_offset(__dtb_start, "/memory");
 	if (offset < 0)
 		jz4740_detect_mem();
+
+	mips_machtype = get_board_mach_type(__dtb_start);
 }
 
 void __init device_tree_init(void)
@@ -75,10 +87,14 @@ void __init device_tree_init(void)
 
 const char *get_system_type(void)
 {
-	if (IS_ENABLED(CONFIG_MACH_JZ4780))
+	switch (mips_machtype) {
+	case MACH_INGENIC_JZ4780:
 		return "JZ4780";
-
-	return "JZ4740";
+	case MACH_INGENIC_JZ4770:
+		return "JZ4770";
+	default:
+		return "JZ4740";
+	}
 }
 
 void __init arch_init_irq(void)
-- 
2.11.0
