Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:28:44 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:33953
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994707AbeAQWXlO3hBK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:41 +0100
Received: by mail-lf0-x242.google.com with SMTP id k19so3754547lfj.1;
        Wed, 17 Jan 2018 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ALS7EM/i2r7JaIzzvHsmWtfz9QBCWCA+uD5osRYXYbA=;
        b=di4/eVOs5HDzKL/Gh7SrnhOtbVlojP6DfYB6UJ1YAdPjrhO+tfcHZm/Y1WDbyiFBKv
         pRTmA3ciggum7Z68Ov09FzbV0arm7vRqmPR1778EILCXAyELiSV6hQJB1PwQDEBztfHO
         f5qSxiwJ+jF5VAVDeq6wwmdS3XKctCsfLsUNB3HnQ6w7IgrawO9jBtu54HeWHuEJY4hc
         GziFc6H4GlqpYwkpxzXaDCeD84QqTt/bgMVDaHe58lQcZmDvtcbym0bcJNDlNa9Zd+t8
         3gyB3GkPL+aoA6NLn89XbAyavshTgwc/Q7cNCScFHHv2U7vk8liSiOg/3SjIgCAz4b2Y
         4EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ALS7EM/i2r7JaIzzvHsmWtfz9QBCWCA+uD5osRYXYbA=;
        b=gwqPWK488RPUCcC/ZncmH5jR3hgA7mPe7D2EloJglY5VMhMwxG1rO1LlNk5BrDGtEE
         KrxARX4B2LFnNmbwt5A8qqKzkny6BOe/R2vtmnf50Cm5YZmGtRnYbFmz4deI1i42Fr6r
         67wno3Nop4zGTiVjK+R4ABA2+XxSqCEXZbT1L3PCQ+HhoNn0S8Ws2jW6RrvoyOheQVKX
         6ZLu6E4hbe+dvnpalbiCAItoBw9eI0H0XOr2UAS8BJiHHGiaTl3n7/OM2aBQOxIeDcMZ
         POpn32mKBOXONJdzi6i4D+hlLCKwBzfyEUTmJI5YYGBtgVCgj/ooGvHj7FXGXsP15UB7
         C/Zw==
X-Gm-Message-State: AKGB3mKzbG2B50QYvzJ6C031RyJO81mTRMftQ9jCVZ/BPxzOQ7LrOq69
        4QblVP5IsNWMik5wgcirmMLkJqx2
X-Google-Smtp-Source: ACJfBotonIvzrY7JZS0zAvJcKfqm8JIEPZYSSaLV/fhITphrLeUnBa8JxcyYSzHrU51ZNDAhP1vQXg==
X-Received: by 10.46.84.9 with SMTP id i9mr25437922ljb.83.1516227815461;
        Wed, 17 Jan 2018 14:23:35 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:34 -0800 (PST)
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
Subject: [PATCH 12/14] MIPS: memblock: Discard bootmem from Loongson3 code
Date:   Thu, 18 Jan 2018 01:23:10 +0300
Message-Id: <20180117222312.14763-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62223
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
index 282c5a8c2..902843516 100644
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
