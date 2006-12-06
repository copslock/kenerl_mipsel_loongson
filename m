Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 15:47:38 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.188]:60785 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038251AbWLFPrH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 15:47:07 +0000
Received: by nf-out-0910.google.com with SMTP id l24so555905nfc
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 07:47:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=VfS5aX0aaQoGY/hpVIE3oOE9AtbfHp7yWeK4tQ+/wDaT99i+b/x4SBcP6kwd2tvQZ4v8na5VwD2qfCyn7TZ2QY8a7ohcYvDeCNjrd51o253jnzcHYo5TGcCzQ9ShYzqwUPiAP6YD1yiFvfm5L19xdfjy0BNJLUMnzUFvaZWwU3Y=
Received: by 10.48.162.12 with SMTP id k12mr2382706nfe.1165420026965;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c10sm2295679nfb.2006.12.06.07.47.06;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id BE0A523F76A; Wed,  6 Dec 2006 16:48:30 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/3] Setup min_low_pfn/max_low_pfn correctly
Date:	Wed,  6 Dec 2006 16:48:29 +0100
Message-Id: <11654201103291-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165420110699-git-send-email-fbuihuu@gmail.com>
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

The old code was assuming that min_low_pfn was always 0. This
means that we can't handle platforms with a big hole at start
of memory since mem_map[] size would blew up.

This patch does not relax this constraint but it's a first
step to achieve that.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   27 +++++++++++++++++++--------
 arch/mips/mm/init.c      |   15 ++++++---------
 include/asm-mips/dma.h   |    1 +
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 89440a0..8e58d7f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -271,7 +271,6 @@ static void __init bootmem_init(void)
 static void __init bootmem_init(void)
 {
 	unsigned long reserved_end;
-	unsigned long highest = 0;
 	unsigned long mapstart = -1UL;
 	unsigned long bootmap_size;
 	int i;
@@ -284,6 +283,13 @@ static void __init bootmem_init(void)
 	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
 
 	/*
+	 * max_low_pfn is not a number of pages. The number of pages
+	 * of the system is given by 'max_low_pfn - min_low_pfn'.
+	 */
+	min_low_pfn = -1UL;
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
@@ -305,22 +313,25 @@ static void __init bootmem_init(void)
 		mapstart = max(reserved_end, start);
 	}
 
+	if (min_low_pfn >= max_low_pfn)
+		panic("Boggus memory mapping !!!");
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
index 30245c0..e78a1b1 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -341,7 +341,6 @@ static int __init page_is_ram(unsigned l
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
-	unsigned long max_dma, low;
 #ifndef CONFIG_FLATMEM
 	unsigned long zholes_size[MAX_NR_ZONES] = { 0, };
 	unsigned long i, j, pfn;
@@ -354,18 +353,16 @@ void __init paging_init(void)
 #endif
 	kmap_coherent_init();
 
-	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	low = max_low_pfn;
-
 #ifdef CONFIG_ISA
-	if (low < max_dma)
-		zones_size[ZONE_DMA] = low;
+	if (max_low_pfn < MAX_DMA_PFN)
+		zones_size[ZONE_DMA] = max_low_pfn;
 	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = low - max_dma;
+		unsigned long start_normal_zone = max(min_low_pfn, MAX_DMA_PFN);
+		zones_size[ZONE_DMA] = MAX_DMA_PFN;
+		zones_size[ZONE_NORMAL] = max_low_pfn - start_normal_zone;
 	}
 #else
-	zones_size[ZONE_DMA] = low;
+	zones_size[ZONE_DMA] = max_low_pfn - min_low_pfn;
 #endif
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
1.4.4.1
