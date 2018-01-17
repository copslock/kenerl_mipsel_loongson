Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:25:44 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:41437
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994696AbeAQWXbgYo3P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:31 +0100
Received: by mail-lf0-x243.google.com with SMTP id f136so2530144lff.8;
        Wed, 17 Jan 2018 14:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8W9stpdMcoXrO3V8R8pqdc0h4lR6H/ZhlYBubZJFz4=;
        b=CWinwe6z24gZmjqnnHWSisqqrYqR/J4mt9UA7qfNbXUFtK3a0oigffN4XGtIzQLTYa
         xstgwyreRy3y3AV7qYahQJ3dJm+8KFpkY+Kqst05mIvZeKdUu7WOLJVihShejPpxmrIw
         bOF2ds93UVs4GCfT9m+ZS3nDAfsevP7AU5PAJjl02KKc+YnwoRsniY5tN+agCdL9rrl9
         2Oa+TrsZuOdXfodUehhG0NPFQoQzPbr8wUwSwUGqVW8OP1HIEo411+Fml2CZovMh9mzz
         H+iO5I4BqP13CHx+et3x3jAsY0hArad0Xpa3oVMOUNZJTUqaQSTLL7L/bmWNfAdvup0G
         uBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8W9stpdMcoXrO3V8R8pqdc0h4lR6H/ZhlYBubZJFz4=;
        b=cHdU6jl4eh4lyYBEpglanCdRVHcXt8xi6ubbz3sMdwE7BwHHs2akXrR2fvEhYsrOW1
         6/8ugTTKEnKuKJkHrHGNKNh1TRKrv3d4bGVZjxy6b44QmoSABToN2FKMA6aqkL5HGDQo
         s/jnRBVYxu+tC+ZFrHgaFFmxWoXhyP+iG3DVUQbWOjPivPX+RIENWvvOotye2mJkb7lM
         fN089Ba88DH3kxbz6UWfOQMuv6856uTi8n+vw+9tTUSB9e3LJVqjcN7eOV6Q2NISjs16
         xKd3BGzpKAyXED5RVf1NdGvxHMeRmL3pHToLb5wM8XwSwGwqE2gtu0+5+JalGhPGHUsQ
         EDUA==
X-Gm-Message-State: AKwxytfNc9kcnPr8Uy4asNJulLUiN4UAOny+xmXyUNcOgWlHATJfpEOs
        qNiL7v6r7CU1zEmxWQ7KzR4x4mRM
X-Google-Smtp-Source: ACJfBovTrwepX9RIBXYSMEDr+xZSLIwOqUajb1HQLg3FREcskPHRy5jGktPx1F8Rf2wqZ+ZpyNxxgg==
X-Received: by 10.46.101.19 with SMTP id z19mr1181364ljb.66.1516227805738;
        Wed, 17 Jan 2018 14:23:25 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:25 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 05/14] MIPS: memblock: Add reserved memory regions to memblock
Date:   Thu, 18 Jan 2018 01:23:03 +0300
Message-Id: <20180117222312.14763-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

The memory reservation has to be performed for all the crucial
objects like kernel itself, it data and fdt blob. FDT reserved-memory
nodes should also be scanned to declare or discard reserved memory
regions, but it has to be done after the memblock is fully initialized
with low/high RAM (see the function description/code).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 96 +++++++++++++++++-------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 0ffbc3bb5..9e14d9833 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -362,6 +362,10 @@ static unsigned long __init init_initrd(void)
 static void __init bootmem_init(void)
 {
 	init_initrd();
+}
+
+static void __init reservation_init(void)
+{
 	finalize_initrd();
 }
 
@@ -478,54 +482,58 @@ static void __init bootmem_init(void)
 		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
 	}
 	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+}
+
+static void __init reservation_init(void)
+{
+	phys_addr_t size;
+	int i;
 
 	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
+	 * Reserve memory occupied by the kernel and it data
 	 */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start, end, size;
+	size = __pa_symbol(&_end) - __pa_symbol(&_text);
+	memblock_reserve(__pa_symbol(&_text), size);
 
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end   = PFN_DOWN(boot_mem_map.map[i].addr
-				    + boot_mem_map.map[i].size);
+	/*
+	 * Handle FDT and it reserved-memory nodes now
+	 */
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
 
-		/*
-		 * Reserve usable memory.
-		 */
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RAM:
-			break;
-		case BOOT_MEM_INIT_RAM:
-			memory_present(0, start, end);
-			continue;
-		default:
-			/* Not usable memory */
-			if (start > min_low_pfn && end < max_low_pfn)
-				reserve_bootmem(boot_mem_map.map[i].addr,
-						boot_mem_map.map[i].size,
-						BOOTMEM_DEFAULT);
-			continue;
-		}
+	/*
+	 * Reserve requested memory ranges with the memblock allocator.
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		phys_addr_t start, end;
 
-		/*
-		 * We are rounding up the start address of usable memory
-		 * and at the end of the usable range downwards.
-		 */
-		if (start >= max_low_pfn)
+		if (boot_mem_map.map[i].type == BOOT_MEM_RAM)
 			continue;
-		if (end > max_low_pfn)
-			end = max_low_pfn;
+
+		start = boot_mem_map.map[i].addr;
+		end   = boot_mem_map.map[i].addr + boot_mem_map.map[i].size;
+		size  = boot_mem_map.map[i].size;
 
 		/*
-		 * ... finally, is the area going away?
+		 * Make sure the region isn't already reserved
 		 */
-		if (end <= start)
+		if (memblock_is_region_reserved(start, size)) {
+			pr_warn("Reserved region %08zx @ %pa already in-use\n",
+				(size_t)size, &start);
 			continue;
-		size = end - start;
+		}
 
-		/* Register lowmem ranges */
-		free_bootmem(PFN_PHYS(start), size << PAGE_SHIFT);
-		memory_present(0, start, end);
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_ROM_DATA:
+		case BOOT_MEM_RESERVED:
+		case BOOT_MEM_INIT_RAM:
+			memblock_reserve(start, size);
+			break;
+		case BOOT_MEM_RESERVED_NOMAP:
+		default:
+			memblock_remove(start, size);
+			break;
+		}
 	}
 
 #ifdef CONFIG_RELOCATABLE
@@ -555,6 +563,12 @@ static void __init bootmem_init(void)
 	 * Reserve initrd memory if needed.
 	 */
 	finalize_initrd();
+
+	/*
+	 * Reserve for hibernation
+	 */
+	size = __pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin);
+	memblock_reserve(__pa_symbol(&__nosave_begin), size);
 }
 
 #endif	/* CONFIG_SGI_IP27 */
@@ -569,6 +583,7 @@ static void __init bootmem_init(void)
  * kernel but generic memory management system is still entirely uninitialized.
  *
  *  o bootmem_init()
+ *  o reservation_init()
  *  o sparse_init()
  *  o paging_init()
  *  o dma_contiguous_reserve()
@@ -826,10 +841,10 @@ static void __init arch_mem_init(char **cmdline_p)
 		print_memory_map();
 	}
 
-	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
-
 	bootmem_init();
+
+	reservation_init();
+
 #ifdef CONFIG_PROC_VMCORE
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
 		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
@@ -855,9 +870,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	for_each_memblock(reserved, reg)
 		if (reg->size != 0)
 			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-
-	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
-			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
 }
 
 static void __init resource_init(void)
-- 
2.12.0
