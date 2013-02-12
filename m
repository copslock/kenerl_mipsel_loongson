Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2013 21:43:04 +0100 (CET)
Received: from vms173013pub.verizon.net ([206.46.173.13]:57025 "EHLO
        vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827604Ab3BLUmdNmEPK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Feb 2013 21:42:33 +0100
Received: from wf-rch.minyard.home ([unknown] [173.74.121.95])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI40056XK5SS9D0@vms173013.mailsrvcs.net>; Tue,
 12 Feb 2013 14:41:57 -0600 (CST)
Received: from i.minyard.home (i2.minyard.home [192.168.27.116])
        by wf-rch.minyard.home (Postfix) with ESMTP id 2B7D71F95B; Tue,
 12 Feb 2013 14:41:51 -0600 (CST)
Received: by i.minyard.home (Postfix, from userid 1000) id 6BBCF8069A; Tue,
 12 Feb 2013 14:41:51 -0600 (CST)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/2] mips: Make sure kernel memory is in iomem
Date:   Tue, 12 Feb 2013 14:41:47 -0600
Message-id: <1360701708-21371-2-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.7.4.1
In-reply-to: <1360701708-21371-1-git-send-email-minyard@acm.org>
References: <1360701708-21371-1-git-send-email-minyard@acm.org>
X-archive-position: 35738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Corey Minyard <cminyard@mvista.com>

Kernel memory isn't necessarily added to the memory tables, so it
wouldn't show up in /proc/iomem.  This was breaking kdump, which
requires these memory addresses to work correctly.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: David Daney  <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/kernel/setup.c |   52 +++++++++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8c41187..5346250 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -480,34 +480,44 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
-static void __init arch_mem_init(char **cmdline_p)
+static void __init arch_mem_addpart(phys_t mem, phys_t end, int type)
 {
-	phys_t init_mem, init_end, init_size;
+	phys_t size;
+	int i;
+
+	size = end - mem;
+	if (!size)
+		return;
+
+	/* Make sure it is in the boot_mem_map */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (mem >= boot_mem_map.map[i].addr &&
+		    mem < (boot_mem_map.map[i].addr +
+			   boot_mem_map.map[i].size))
+			return;
+	}
+	add_memory_region(mem, size, type);
+}
 
+static void __init arch_mem_init(char **cmdline_p)
+{
 	extern void plat_mem_setup(void);
 
 	/* call board setup routine */
 	plat_mem_setup();
 
-	init_mem = PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT;
-	init_end = PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT;
-	init_size = init_end - init_mem;
-	if (init_size) {
-		/* Make sure it is in the boot_mem_map */
-		int i, found;
-		found = 0;
-		for (i = 0; i < boot_mem_map.nr_map; i++) {
-			if (init_mem >= boot_mem_map.map[i].addr &&
-			    init_mem < (boot_mem_map.map[i].addr +
-					boot_mem_map.map[i].size)) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found)
-			add_memory_region(init_mem, init_size,
-					  BOOT_MEM_INIT_RAM);
-	}
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
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
-- 
1.7.4.1
