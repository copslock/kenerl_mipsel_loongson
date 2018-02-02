Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 05:00:56 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:41092
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994862AbeBBDz0RJxi0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:26 +0100
Received: by mail-lf0-x243.google.com with SMTP id f136so29434831lff.8;
        Thu, 01 Feb 2018 19:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fg4BuVQq5kDDzYpkoYvsMHx+BQH7P8vav3a6IimGF/s=;
        b=JHIWdNRO+nh93eKi3qFW8lPssnm2TZ67czNeHF1joLWyTYxYxVJ1Z/9EGhdwl43Wdf
         wmSAIIdrpfxLUZH3nRltnCR4JUwORKayfPjYw5Z2xeg9YDiUJ5RWQwR9n/h1vckL7YkH
         N+pd52T2AiNI1fbd5414gKIiNu1B++r3K3iI54ZhFCT3czsqZbi8wouCTLOHHvW9dtfx
         +fg3z/21d5eE52xi1os95rvyyNq4d4vTKcJvrbRvZd5J47yG/fD5gH8iVVYFLzE1hxGv
         JLgxaNvXPcyyTtZE/5HLeJLPRl1fIXXUr3gXRGEYLtj5kovFwGeWzhvTZBkqWaXQZbbc
         sIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fg4BuVQq5kDDzYpkoYvsMHx+BQH7P8vav3a6IimGF/s=;
        b=fgJUkPV4i35Bop7T6+1jxr4/vd9Fp2LQHwLuXCc9B9icuNT4AWx+b8AfDCC1lXYuzC
         Nu21itkrj7a+lu1YAW/kH69r/EoAiIsH/9mPQgt38KgpPm8kj0FgMgq1lnbkAZ1pJ1R5
         tlAnXFUojGF5VHW3nFCNmSQmvQOMvEWFmwX01AfztT+IQmMa9fSa7fflCKgfWKe2rI/Z
         99eNPcjp4N59G0uQy7bgnwej1iO3e5J9hy7fdjF2563eosQIw6opNGE0Ee510GEgS9Gs
         B8Qor3vF7OtwyXV5nCFOvvTzScVuzYvOT5yudpHTJMhTDbqi10bdh6MmOTwpgy0pstfX
         Of/A==
X-Gm-Message-State: AKwxytfDzUoi5fLtWjQyeahGSFdPxTe0rky4i8u9u1pPHoC3c8+FzYsf
        jXxlTPaSF5Hdk/fz1N7Smci3O3k5
X-Google-Smtp-Source: AH8x226DcLcoE+aoo9gVVTjgr0l9eNyw8NLSDhUyMxf4Ug2WJmDB27xCO/UnTp50Tu1o+hoQcLxYYg==
X-Received: by 10.46.68.221 with SMTP id b90mr20603842ljf.62.1517543720554;
        Thu, 01 Feb 2018 19:55:20 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:19 -0800 (PST)
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
Subject: [PATCH v2 13/15] MIPS: memblock: Discard bootmem from Loongson3 code
Date:   Fri,  2 Feb 2018 06:54:56 +0300
Message-Id: <20180202035458.30456-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62420
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

Loongson64/3 runs its own code to initialize memory allocator in
case of NUMA configuration is selected. So in order to move to the
pure memblock utilization we discard the bootmem allocator usage
and insert the memblock reservation method for kernel/addrspace_offset
memory regions.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/loongson64/loongson-3/numa.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index f17ef520799a..2f1ebf496c17 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -180,7 +180,6 @@ static void __init szmem(unsigned int node)
 
 static void __init node_mem_init(unsigned int node)
 {
-	unsigned long bootmap_size;
 	unsigned long node_addrspace_offset;
 	unsigned long start_pfn, end_pfn, freepfn;
 
@@ -197,26 +196,21 @@ static void __init node_mem_init(unsigned int node)
 
 	__node_data[node] = prealloc__node_data + node;
 
-	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
-	bootmap_size = init_bootmem_node(NODE_DATA(node), freepfn,
-					start_pfn, end_pfn);
 	free_bootmem_with_active_regions(node, end_pfn);
 	if (node == 0) /* used by finalize_initrd() */
 		max_low_pfn = end_pfn;
 
-	/* This is reserved for the kernel and bdata->node_bootmem_map */
-	reserve_bootmem_node(NODE_DATA(node), start_pfn << PAGE_SHIFT,
-		((freepfn - start_pfn) << PAGE_SHIFT) + bootmap_size,
-		BOOTMEM_DEFAULT);
+	/* This is reserved for the kernel only */
+	if (node == 0)
+		memblock_reserve(start_pfn << PAGE_SHIFT,
+			((freepfn - start_pfn) << PAGE_SHIFT));
 
 	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
 		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
-		reserve_bootmem_node(NODE_DATA(node),
-				(node_addrspace_offset | 0xfe000000),
-				32 << 20, BOOTMEM_DEFAULT);
+		memblock_reserve(node_addrspace_offset | 0xfe000000, 32 << 20);
 	}
 
 	sparse_memory_present_with_active_regions(node);
-- 
2.12.0
