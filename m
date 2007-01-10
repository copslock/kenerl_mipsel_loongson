Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:07:54 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20040407AbXAJQHk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:07:40 +0000
Received: from nf-out-0910.google.com ([64.233.182.189]:5588 "EHLO
	nf-out-0910.google.com") by lappi.linux-mips.net with ESMTP
	id S136406AbXAJImD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 09:42:03 +0100
Received: by nf-out-0910.google.com with SMTP id l24so408127nfc
        for <linux-mips@linux-mips.org>; Wed, 10 Jan 2007 00:42:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=LEfihUVPMECUa/94YxTCUnVP+fd7StiiiLmSzol/pChA+qswMktD+Qa/GOaWPGasEYO8DhQTGK4gZGdlpJqrc11ArxruRkXamaxQBGZSvxtlgx2DHdZXK4QPP2pbRL0PB8jqiimN27uTb39/M1gHuAIK4w/N/8lIzjLZlzTCeOw=
Received: by 10.48.48.13 with SMTP id v13mr1004035nfv.1168418522582;
        Wed, 10 Jan 2007 00:42:02 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id x1sm3246051nfb.2007.01.10.00.41.59;
        Wed, 10 Jan 2007 00:42:01 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 07BFC23F759; Wed, 10 Jan 2007 09:44:06 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 1/2] Setup min_low_pfn/max_low_pfn correctly
Date:	Wed, 10 Jan 2007 09:44:04 +0100
Message-Id: <116841864571-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <116841864595-git-send-email-fbuihuu@gmail.com>
References: <116841864595-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch makes a better usage of these two globals.
'min_low_pfn' is now correctly setup for all configs, which
allow us to rely on it in boot memory code init.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   36 +++++++++++++++++++++++++++---------
 arch/mips/mm/init.c      |   23 +++++++++++------------
 include/asm-mips/dma.h   |    1 +
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 89440a0..f352cd9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -271,8 +271,7 @@ static void __init bootmem_init(void)
 static void __init bootmem_init(void)
 {
 	unsigned long reserved_end;
-	unsigned long highest = 0;
-	unsigned long mapstart = -1UL;
+	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
 	int i;
 
@@ -284,6 +283,13 @@ static void __init bootmem_init(void)
 	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
 
 	/*
+	 * max_low_pfn is not a number of pages. The number of pages
+	 * of the system is given by 'max_low_pfn - min_low_pfn'.
+	 */
+	min_low_pfn = ~0UL;
+	max_low_pfn = 0;
+
+	/*
 	 * Find the highest page frame number we have available.
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
@@ -296,8 +302,10 @@ static void __init bootmem_init(void)
 		end = PFN_DOWN(boot_mem_map.map[i].addr
 				+ boot_mem_map.map[i].size);
 
-		if (end > highest)
-			highest = end;
+		if (end > max_low_pfn)
+			max_low_pfn = end;
+		if (start < min_low_pfn)
+			min_low_pfn = start;
 		if (end <= reserved_end)
 			continue;
 		if (start >= mapstart)
@@ -305,22 +313,32 @@ static void __init bootmem_init(void)
 		mapstart = max(reserved_end, start);
 	}
 
+	if (min_low_pfn >= max_low_pfn)
+		panic("Incorrect memory mapping !!!");
+	if (min_low_pfn > 0) {
+		printk(KERN_INFO
+		       "Wasting %lu bytes for tracking %lu unused pages\n",
+		       min_low_pfn * sizeof(struct page),
+		       min_low_pfn);
+		min_low_pfn = 0;
+	}
+
 	/*
 	 * Determine low and high memory ranges
 	 */
-	if (highest > PFN_DOWN(HIGHMEM_START)) {
+	if (max_low_pfn > PFN_DOWN(HIGHMEM_START)) {
 #ifdef CONFIG_HIGHMEM
 		highstart_pfn = PFN_DOWN(HIGHMEM_START);
-		highend_pfn = highest;
+		highend_pfn = max_low_pfn;
 #endif
-		highest = PFN_DOWN(HIGHMEM_START);
+		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
 
 	/*
 	 * Initialize the boot-time allocator with low memory only.
 	 */
-	bootmap_size = init_bootmem(mapstart, highest);
-
+	bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
+					 min_low_pfn, max_low_pfn);
 	/*
 	 * Register fully available low RAM pages with the bootmem allocator.
 	 */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 30245c0..cd50b7a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -341,7 +341,6 @@ static int __init page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
-	unsigned long max_dma, low;
 #ifndef CONFIG_FLATMEM
 	unsigned long zholes_size[MAX_NR_ZONES] = { 0, };
 	unsigned long i, j, pfn;
@@ -354,19 +353,19 @@ void __init paging_init(void)
 #endif
 	kmap_coherent_init();
 
-	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	low = max_low_pfn;
-
 #ifdef CONFIG_ISA
-	if (low < max_dma)
-		zones_size[ZONE_DMA] = low;
-	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = low - max_dma;
-	}
-#else
-	zones_size[ZONE_DMA] = low;
+	if (max_low_pfn >= MAX_DMA_PFN)
+		if (min_low_pfn >= MAX_DMA_PFN) {
+			zones_size[ZONE_DMA] = 0;
+			zones_size[ZONE_NORMAL] = max_low_pfn - min_low_pfn;
+		} else {
+			zones_size[ZONE_DMA] = MAX_DMA_PFN - min_low_pfn;
+			zones_size[ZONE_NORMAL] = max_low_pfn - MAX_DMA_PFN;
+		}
+	else
 #endif
+	zones_size[ZONE_DMA] = max_low_pfn - min_low_pfn;
+
 #ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highend_pfn - highstart_pfn;
 
diff --git a/include/asm-mips/dma.h b/include/asm-mips/dma.h
index 23f789c..e06ef07 100644
--- a/include/asm-mips/dma.h
+++ b/include/asm-mips/dma.h
@@ -91,6 +91,7 @@
 #else
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
 #endif
+#define MAX_DMA_PFN		PFN_DOWN(virt_to_phys((void *)MAX_DMA_ADDRESS))
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
-- 
1.4.4.3.ge6d4
