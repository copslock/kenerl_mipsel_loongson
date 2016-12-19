Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:10:44 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36755 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992903AbcLSCIJywXsK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:09 +0100
Received: by mail-lf0-f67.google.com with SMTP id o20so6141509lfg.3;
        Sun, 18 Dec 2016 18:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/I7jwK1yt++9gIuaUufNufcWBatQLpu3MIg4mfYQrOQ=;
        b=heXP1YbRXsYp0e5w0JtiVsmExyWFuf905kMSD4B9P6EwIF/zBQHDWNfwR1cgDG0faJ
         7U9vHWrnR97WMgjzMG9eQ7V+NbEXpcmk8S/tlNxM4+mls+7+9Fgr3/lfFjGicv4a1pvX
         VlB245xOSvfjOIMiDunTkk483qTG6gnSIy5vF/opF3pFq0xwpk3rdAO/Ti87o70qqglW
         uk3Gs2tWMagP+QMSLQIc3vsideNkfIb8ss4o8KmKnlf8RWQ4JaPYAQzzylEHUp7QLAO1
         AL5AL2WMP2Dd58CLQXnJEAkJhKYiaA8ORtBOVBqc5OSG5SdV/x7yPVPzlIVYSHm6+fPL
         Bl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/I7jwK1yt++9gIuaUufNufcWBatQLpu3MIg4mfYQrOQ=;
        b=aHQPNh1bJjwAp7ZsxCG/15RELK/SJ5ztSeCtly/pVmG75n5VVnl2D165g7kj1+piO0
         b+xpn0ZBZBd6bPCAqrXggk7NEiVKWt9dNitTeEXXjQ+1eI3Lf8PxF2y/MVRD504qptEv
         QDC4W57fYlJM+3JH1L9cvSrv0v+g96G6uPQU4folsZXcay/X2pZ/i3XlnTDFvrhgu+90
         B4No24Df05PoGqnolanGCdfroht26hykyOP2YPOvE6MRiZntwkmYQYk7LhOOSyDsi/zd
         aCYoycFHvcZAHEMK0zH0iHo+HA4mkFtbAkFunzuNkS90iOMEaIn0kPql5f2KXVEjwerI
         0Dtw==
X-Gm-Message-State: AKaTC007Ss/EDpe7xc08f8HkynXSpFW/ylYDWiINOYp2iHgNr5wllgnXAOtDkGN4ioQKVw==
X-Received: by 10.46.8.17 with SMTP id 17mr6355583lji.72.1482113284368;
        Sun, 18 Dec 2016 18:08:04 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:03 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 10/21] MIPS memblock: Discard bootmem allocator initialization
Date:   Mon, 19 Dec 2016 05:07:35 +0300
Message-Id: <1482113266-13207-11-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56069
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

Bootmem allocator initialization needs to be discarded.
PFN limit constants are still in use by some subsystems, so they
need to be properly initialized. The initialization is moved into
a separate method and performed with help of commonly used
platform-specific constants. It might me too simplified, but most
of the kernel platforms do it the same way. Moreover it's much
easier to debug it, when it's not that complicated.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 193 ++++-------------------------
 1 file changed, 21 insertions(+), 172 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index e746793..6562f55 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -626,6 +626,25 @@ static void __init request_crashkernel(struct resource *res) { }
 #endif /* !CONFIG_KEXEC */
 
 /*
+ * Calcualte PFN limits with respect to the defined memory layout
+ */
+static void __init find_pfn_limits(void)
+{
+	phys_addr_t ram_end = memblock_end_of_DRAM();
+
+	min_low_pfn = ARCH_PFN_OFFSET;
+	max_low_pfn = PFN_UP(HIGHMEM_START);
+	max_pfn = PFN_UP(ram_end);
+#ifdef CONFIG_HIGHMEM
+	highstart_pfn = max_low_pfn;
+	highend_pfn = max_pfn <= highstart_pfn ? highstart_pfn : max_pfn;
+#endif
+	pr_info("PFNs: low min %lu, low max %lu, high start %lu, high end %lu,"
+		"max %lu\n",
+		min_low_pfn, max_low_pfn, highstart_pfn, highend_pfn, max_pfn);
+}
+
+/*
  * Initialize the bootmem allocator. It also setup initrd related data
  * if needed.
  */
@@ -641,11 +660,6 @@ static void __init bootmem_init(void)
 
 static void __init bootmem_init(void)
 {
-	unsigned long reserved_end;
-	unsigned long mapstart = ~0UL;
-	unsigned long bootmap_size;
-	int i;
-
 	/* Reserve kernel code/data memory */
 	mips_reserve_kernel_mem();
 
@@ -658,173 +672,8 @@ static void __init bootmem_init(void)
 	/* Parse crashkernel parameter */
 	mips_parse_crashkernel();
 
-	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
-
-	/*
-	 * max_low_pfn is not a number of pages. The number of pages
-	 * of the system is given by 'max_low_pfn - min_low_pfn'.
-	 */
-	min_low_pfn = ~0UL;
-	max_low_pfn = 0;
-
-	/*
-	 * Find the highest page frame number we have available.
-	 */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start, end;
-
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			continue;
-
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end = PFN_DOWN(boot_mem_map.map[i].addr
-				+ boot_mem_map.map[i].size);
-
-#ifndef CONFIG_HIGHMEM
-		/*
-		 * Skip highmem here so we get an accurate max_low_pfn if low
-		 * memory stops short of high memory.
-		 * If the region overlaps HIGHMEM_START, end is clipped so
-		 * max_pfn excludes the highmem portion.
-		 */
-		if (start >= PFN_DOWN(HIGHMEM_START))
-			continue;
-		if (end > PFN_DOWN(HIGHMEM_START))
-			end = PFN_DOWN(HIGHMEM_START);
-#endif
-
-		if (end > max_low_pfn)
-			max_low_pfn = end;
-		if (start < min_low_pfn)
-			min_low_pfn = start;
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
-	}
-
-	if (min_low_pfn >= max_low_pfn)
-		panic("Incorrect memory mapping !!!");
-	if (min_low_pfn > ARCH_PFN_OFFSET) {
-		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
-			(min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
-			min_low_pfn - ARCH_PFN_OFFSET);
-	} else if (min_low_pfn < ARCH_PFN_OFFSET) {
-		pr_info("%lu free pages won't be used\n",
-			ARCH_PFN_OFFSET - min_low_pfn);
-	}
-	min_low_pfn = ARCH_PFN_OFFSET;
-
-	/*
-	 * Determine low and high memory ranges
-	 */
-	max_pfn = max_low_pfn;
-	if (max_low_pfn > PFN_DOWN(HIGHMEM_START)) {
-#ifdef CONFIG_HIGHMEM
-		highstart_pfn = PFN_DOWN(HIGHMEM_START);
-		highend_pfn = max_low_pfn;
-#endif
-		max_low_pfn = PFN_DOWN(HIGHMEM_START);
-	}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/*
-	 * mapstart should be after initrd_end
-	 */
-	if (initrd_end)
-		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
-#endif
-
-	/*
-	 * Initialize the boot-time allocator with low memory only.
-	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
-					 min_low_pfn, max_low_pfn);
-
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start, end;
-
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end = PFN_DOWN(boot_mem_map.map[i].addr
-				+ boot_mem_map.map[i].size);
-
-		if (start <= min_low_pfn)
-			start = min_low_pfn;
-		if (start >= end)
-			continue;
-
-#ifndef CONFIG_HIGHMEM
-		if (end > max_low_pfn)
-			end = max_low_pfn;
-
-		/*
-		 * ... finally, is the area going away?
-		 */
-		if (end <= start)
-			continue;
-#endif
-
-		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
-	}
-
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start, end, size;
-
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end   = PFN_DOWN(boot_mem_map.map[i].addr
-				    + boot_mem_map.map[i].size);
-
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
-			continue;
-		}
-
-		/*
-		 * We are rounding up the start address of usable memory
-		 * and at the end of the usable range downwards.
-		 */
-		if (start >= max_low_pfn)
-			continue;
-		if (start < reserved_end)
-			start = reserved_end;
-		if (end > max_low_pfn)
-			end = max_low_pfn;
-
-		/*
-		 * ... finally, is the area going away?
-		 */
-		if (end <= start)
-			continue;
-		size = end - start;
-
-		/* Register lowmem ranges */
-		free_bootmem(PFN_PHYS(start), size << PAGE_SHIFT);
-		memory_present(0, start, end);
-	}
-
-	/*
-	 * Reserve the bootmap memory.
-	 */
-	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size, BOOTMEM_DEFAULT);
+	/* Find memory PFN limits */
+	find_pfn_limits();
 }
 
 #endif	/* CONFIG_SGI_IP27 */
-- 
2.6.6
