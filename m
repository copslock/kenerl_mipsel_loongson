Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:16:27 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36777 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993111AbcLSCIWnIoMK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:22 +0100
Received: by mail-lf0-f68.google.com with SMTP id o20so6141697lfg.3;
        Sun, 18 Dec 2016 18:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=892PhMbteR2nYCFpAZqMnewyBv7lvHBMbOp0w1Tjtrk=;
        b=e3VtJBDCUB1b3XKuWqPSf3YNRWRhBTHcCxaUPwLAbIDZGiyloaFChQ5lklRac7HlD7
         W0y4tW+5r6Jbq4ZhkL0VAR4YR/ZUJB44f0DaPAVXIKPxyh21j6KXiWG+JdB9bmnRp8/p
         uGpdcLgv6yzJK6soUB0lRNmhKyoEuCjQAYaG1ZZ/OxonweCXyFmxAOIsZUDMl2/pO04D
         tONiTVgUqceyedpniYL8DuRwJiy2ityrCD/O5IVyygFoiDTBkP40CaNQcI9qs4NGA4ok
         aDC1s42Bj+BOiC1CgTDmDNXVjlQBz6ejHe3lavkcCP6iA0vFmI9K3dEnRV/uS39Z2shf
         7S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=892PhMbteR2nYCFpAZqMnewyBv7lvHBMbOp0w1Tjtrk=;
        b=f3rjhtqTLDRy+sL101UCwd12uGdLsqPVxf7qp8XHpYjcS0uPODREbdAzcllOqUg8Ry
         Kh/YCDhRBrwgabyLu9eptnSRQp2MorqJmuqtmcFRm3FQc3iy1+qu59iR0sdW3xWO4/3o
         H7vuPvucC6b5P8OuN0iOluNBUQPhviJaFtLsk1aZrIetn7aFFskbYYuqq5ID8RJhR8DH
         bmdt21qzF1OQhO1rE3jdlkrFLa9LNcXas9qgrv5Yb3Kc5lPzcicxnjRPrLlgc2xdp62z
         2fVVMEMaIKzH47YZigoo5KXxcrwX+FUNeSQBo+FFmtqDrakOS+nkUvHumf8fbYi5WR8f
         QRVw==
X-Gm-Message-State: AKaTC00caHLkzKnaSHy3AZFDJGXyT9jOHxMRlswGCrmq/mQeWH02dBRPetT2rsSVMkm4YQ==
X-Received: by 10.25.206.3 with SMTP id e3mr5013063lfg.42.1482113290465;
        Sun, 18 Dec 2016 18:08:10 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:10 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 16/21] MIPS memblock: Alter paging initialization method
Date:   Mon, 19 Dec 2016 05:07:41 +0300
Message-Id: <1482113266-13207-17-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56083
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

Apart from the actions it did before, it initializes sparsemem
if one activated. Memory zones size calculation is moved into an
individual method.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 79 +++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 49db909..6f186c7 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -58,6 +58,53 @@ EXPORT_SYMBOL_GPL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
 /*
+ * Initialize sparse memory sections setting node ids and indexes
+ */
+static void __init mips_memory_present(void)
+{
+#ifdef CONFIG_SPARSEMEM
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg)
+		memory_present(0, memblock_region_memory_base_pfn(reg),
+			memblock_region_memory_end_pfn(reg));
+#endif /* CONFIG_SPARSEMEM */
+}
+
+/*
+ * Setup nodes zone areas
+ */
+static void __init zone_sizes_init(void)
+{
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+
+	/* Clean zone boundaries array */
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+
+	/* Setup determined boundaries */
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
+#endif
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+#ifdef CONFIG_HIGHMEM
+	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
+
+	/* Make sure the processor supports highmem */
+	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
+		pr_warn("CPU doesn't support highmem. %ldk highmem ignored\n",
+			(highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
+		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
+	}
+#endif
+
+	/* Finally initialize nodes and page maps using memblock info */
+	free_area_init_nodes(max_zone_pfns);
+}
+
+/*
  * Not static inline because used by IP27 special magic initialization code
  */
 void setup_zero_pages(void)
@@ -386,36 +433,22 @@ int page_is_ram(unsigned long pagenr)
 
 void __init paging_init(void)
 {
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
-
+	/* Initialize page tables */
 	pagetable_init();
 
+	/* Initialize highmem mapping */
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
-#ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
-#endif
-#ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
-#endif
-	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-	lastpfn = max_low_pfn;
-#ifdef CONFIG_HIGHMEM
-	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
-	lastpfn = highend_pfn;
 
-	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
-		printk(KERN_WARNING "This processor doesn't support highmem."
-		       " %ldk highmem ignored\n",
-		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
-		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
-		lastpfn = max_low_pfn;
-	}
-#endif
+	/* Mark present RAM memory */
+	mips_memory_present();
 
-	free_area_init_nodes(max_zone_pfns);
+	/* Initialize memory maps within sparse memory sections */
+	sparse_init();
+
+	/* Initialize free areas of nodes */
+	zone_sizes_init();
 }
 
 #ifdef CONFIG_64BIT
-- 
2.6.6
