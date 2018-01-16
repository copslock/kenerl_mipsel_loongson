Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:51:31 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:41428 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994671AbeAPPsTtxQCE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:48:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v7 07/14] MIPS: Setup boot_command_line before plat_mem_setup
Date:   Tue, 16 Jan 2018 16:47:57 +0100
Message-Id: <20180116154804.21150-8-paul@crapouillou.net>
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516117698; bh=UpRZv4FUsEMXQWhdoMV8lwRqH7pvwtxITXSvdVKPsQI=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Wb67kp7M4duBYp6HMSJlcIHex53qVcGvJY4xA64AN7Jifn77bTKNbyN2kChPhX2bYgWm338RxjqMIOWqHQbNmLwpy16EzNG79KnEXcM8OdIoW2Y9A1NSK+0ScIqxLv3+R2GQ1x26Pn1/9JWXmq2igAvWPyDWNUoLuCRYb+dnCO8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62183
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

From: Paul Burton <paul.burton@mips.com>

Platforms using DT will typically call __dt_setup_arch from
plat_mem_setup. This in turn calls early_init_dt_scan. When
CONFIG_CMDLINE is set, this leads to its value being copied into
boot_command_line by early_init_dt_scan_chosen. If this happens before
the code setting up boot_command_line in arch_mem_init runs, that code
will go on to append CONFIG_CMDLINE (via builtin_cmdline) to
boot_command_line again, duplicating it. For some command line
parameters (eg. earlycon) this can be a problem. Set up
boot_command_line before early_init_dt_scan_chosen gets called such that
it will not write CONFIG_CMDLINE in this scenario & the arguments aren't
duplicated.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Acked-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/kernel/setup.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

 v2: New patch in this series
 v3: No change
 v4: No change
 v5: No change
 v6: Update Paul Burton's email address
 v7: No change

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678de116..85bc601e9a0d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -826,25 +826,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
-	/* call board setup routine */
-	plat_mem_setup();
-
-	/*
-	 * Make sure all kernel memory is in the maps.  The "UP" and
-	 * "DOWN" are opposite for initdata since if it crosses over
-	 * into another memory section you don't want that to be
-	 * freed when the initdata is freed.
-	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
-
-	pr_info("Determined physical RAM map:\n");
-	print_memory_map();
-
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
@@ -872,6 +853,26 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 #endif
 #endif
+
+	/* call board setup routine */
+	plat_mem_setup();
+
+	/*
+	 * Make sure all kernel memory is in the maps.  The "UP" and
+	 * "DOWN" are opposite for initdata since if it crosses over
+	 * into another memory section you don't want that to be
+	 * freed when the initdata is freed.
+	 */
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
+	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
+			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
+			 BOOT_MEM_INIT_RAM);
+
+	pr_info("Determined physical RAM map:\n");
+	print_memory_map();
+
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
-- 
2.11.0
