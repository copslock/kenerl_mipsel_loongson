Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:25:13 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:33951
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994692AbeAQWXaRpYoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:30 +0100
Received: by mail-lf0-x243.google.com with SMTP id k19so3754015lfj.1;
        Wed, 17 Jan 2018 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhvNyslbzo0NiHNxNVJa8V5HT4qnPRmHD2BJs0LxVL8=;
        b=vYsW771OWHxYRPeyAgX0jfOlsmPb4U5boHpLpKPheD1btVlCHuWzDIjCUQY7/US105
         IKuVHYN8ZkpxsWEH946kNOAjj6T7d4egeJJ/0/k92km020kiL+1dATwqyqh1Q8pVhHLn
         wEk7LziujwlpMGHQOepmx5hrqhPAtE7zLVTnK4TITlqgzCV7doac4NEnRYskHCUUnivk
         rjoHt+0tEmJ7vw5Z2DbsXoOSDDBOaf8eiIeZp9A2EmhoM7UvvdCSdn3Swx5EMmuGDPtK
         6HhF2wxil0PlO+tM58Cis8uc5p+9eJh55Qkt+Adt8hihZZeEpCig3HYcgls1lqPkVJ4y
         PtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fhvNyslbzo0NiHNxNVJa8V5HT4qnPRmHD2BJs0LxVL8=;
        b=M9ZKYrv9S1/qCHkgpBv08dzul3VVIvJSlSZ5kTm84I+80B+U6SjwOmqy6AjsPtOWVk
         mZV0GRmyEsT2A6ABQG4jjw0pcNEviQPFBZ0Cs6JLQDypCCCr3w+Oz/2PJpmI+GTdN6Pc
         KqLLKGVGzxiDusy7mNJDetwInsTMrZ4Oz3leQrQjQj66wKaKgScEB/0MmALvTGzD2i1a
         AV88Qt4dYRH7RC0oFFWxwe05TCX2Zv/96g2mkgKqWnKKCq0FKgLxsZ0UkO1KtlXaDEpb
         QYhC3Dh8CjyChCdJPsTl0fjyR+e4cUNChUnR8wBrhpTEz35l3pNRlVapgfDsBN+Ya/a/
         zlEQ==
X-Gm-Message-State: AKwxytfRC03VUq0Qhwq9+XMnZSU1HmmUpJGpHW6F8o/GlbRWa0+je5Z5
        h+VSd6glu8fLsRuiTTpMZBThSFXk
X-Google-Smtp-Source: ACJfBovwLnNU8SS+k34qe5M3a8rxHCeBQvr+Y0dEwJ81taZd5jrOeOO86F4sfY3wvt5T9CEAk51y+g==
X-Received: by 10.46.68.133 with SMTP id b5mr9607908ljf.62.1516227804407;
        Wed, 17 Jan 2018 14:23:24 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:23 -0800 (PST)
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
Subject: [PATCH 04/14] MIPS: memblock: Discard bootmem initialization
Date:   Thu, 18 Jan 2018 01:23:02 +0300
Message-Id: <20180117222312.14763-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62215
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

Since memblock is going to be used for the early memory allocation
lets discard the bootmem node setup and all the related free-space
search code. Low/high PFN extremums should be still calculated
since they are needed on the paging_init stage. Since the current
code is already doing memblock regions initialization the only thing
left is to set the upper allocation limit to be up to the max low
memory PFN, so the memblock API can be fully used from now.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 86 ++++--------------------------
 1 file changed, 11 insertions(+), 75 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1b8246e6c..0ffbc3bb5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -367,29 +367,15 @@ static void __init bootmem_init(void)
 
 #else  /* !CONFIG_SGI_IP27 */
 
-static unsigned long __init bootmap_bytes(unsigned long pages)
-{
-	unsigned long bytes = DIV_ROUND_UP(pages, 8);
-
-	return ALIGN(bytes, sizeof(long));
-}
-
 static void __init bootmem_init(void)
 {
-	unsigned long reserved_end;
-	unsigned long mapstart = ~0UL;
-	unsigned long bootmap_size;
-	bool bootmap_valid = false;
 	int i;
 
 	/*
-	 * Sanity check any INITRD first. We don't take it into account
-	 * for bootmem setup initially, rely on the end-of-kernel-code
-	 * as our memory range starting point. Once bootmem is inited we
+	 * Sanity check any INITRD first. Once memblock is inited we
 	 * will reserve the area used for the initrd.
 	 */
 	init_initrd();
-	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
@@ -428,16 +414,6 @@ static void __init bootmem_init(void)
 			max_low_pfn = end;
 		if (start < min_low_pfn)
 			min_low_pfn = start;
-		if (end <= reserved_end)
-			continue;
-#ifdef CONFIG_BLK_DEV_INITRD
-		/* Skip zones before initrd and initrd itself */
-		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
-			continue;
-#endif
-		if (start >= mapstart)
-			continue;
-		mapstart = max(reserved_end, start);
 	}
 
 	if (min_low_pfn >= max_low_pfn)
@@ -463,53 +439,19 @@ static void __init bootmem_init(void)
 #endif
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/*
-	 * mapstart should be after initrd_end
-	 */
-	if (initrd_end)
-		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+#ifdef CONFIG_HIGHMEM
+	pr_info("PFNs: low min %lu, low max %lu, high start %lu, high end %lu,"
+		"max %lu\n",
+		min_low_pfn, max_low_pfn, highstart_pfn, highend_pfn, max_pfn);
+#else
+	pr_info("PFNs: low min %lu, low max %lu, max %lu\n",
+		min_low_pfn, max_low_pfn, max_pfn);
 #endif
 
 	/*
-	 * check that mapstart doesn't overlap with any of
-	 * memory regions that have been reserved through eg. DTB
-	 */
-	bootmap_size = bootmap_bytes(max_low_pfn - min_low_pfn);
-
-	bootmap_valid = memory_region_available(PFN_PHYS(mapstart),
-						bootmap_size);
-	for (i = 0; i < boot_mem_map.nr_map && !bootmap_valid; i++) {
-		unsigned long mapstart_addr;
-
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RESERVED:
-			mapstart_addr = PFN_ALIGN(boot_mem_map.map[i].addr +
-						boot_mem_map.map[i].size);
-			if (PHYS_PFN(mapstart_addr) < mapstart)
-				break;
-
-			bootmap_valid = memory_region_available(mapstart_addr,
-								bootmap_size);
-			if (bootmap_valid)
-				mapstart = PHYS_PFN(mapstart_addr);
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!bootmap_valid)
-		panic("No memory area to place a bootmap bitmap");
-
-	/*
-	 * Initialize the boot-time allocator with low memory only.
+	 * Initialize the boot-time allocator with low/high memory, but
+	 * set the allocation limit to low memory only
 	 */
-	if (bootmap_size != init_bootmem_node(NODE_DATA(0), mapstart,
-					 min_low_pfn, max_low_pfn))
-		panic("Unexpected memory size required for bootmap");
-
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
@@ -535,6 +477,7 @@ static void __init bootmem_init(void)
 
 		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
 	}
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 
 	/*
 	 * Register fully available low RAM pages with the bootmem allocator.
@@ -570,8 +513,6 @@ static void __init bootmem_init(void)
 		 */
 		if (start >= max_low_pfn)
 			continue;
-		if (start < reserved_end)
-			start = reserved_end;
 		if (end > max_low_pfn)
 			end = max_low_pfn;
 
@@ -587,11 +528,6 @@ static void __init bootmem_init(void)
 		memory_present(0, start, end);
 	}
 
-	/*
-	 * Reserve the bootmap memory.
-	 */
-	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size, BOOTMEM_DEFAULT);
-
 #ifdef CONFIG_RELOCATABLE
 	/*
 	 * The kernel reserves all memory below its _end symbol as bootmem,
-- 
2.12.0
