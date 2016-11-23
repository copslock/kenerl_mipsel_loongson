Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:45:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993008AbcKWNoEzXwXG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:04 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9A55063810810;
        Wed, 23 Nov 2016 13:43:55 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:43:58 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 03/10] MIPS: init: ensure bootmem does not corrupt reserved memory
Date:   Wed, 23 Nov 2016 14:43:45 +0100
Message-ID: <1479908632-30392-4-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Current init code initialises bootmem allocator with all of the low
memory that it assumes is available, but does not check for reserved
memory block, which can lead to corruption of data that may be stored
there.
Move bootmem's allocation map to a location that does not cross any
reserved regions

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/setup.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8ebad24..64b38d4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -153,6 +153,35 @@ void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_add
 	add_memory_region(start, size, BOOT_MEM_RAM);
 }
 
+bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
+{
+	int i;
+	bool in_ram = false, free = true;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		phys_addr_t start_, end_;
+
+		start_ = boot_mem_map.map[i].addr;
+		end_ = boot_mem_map.map[i].addr + boot_mem_map.map[i].size;
+
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+			if (start >= start_ && start + size <= end_)
+				in_ram = true;
+			break;
+		case BOOT_MEM_RESERVED:
+			if ((start >= start_ && start < end_) ||
+			    (start < start_ && start + size >= start_))
+				free = false;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	return in_ram && free;
+}
+
 static void __init print_memory_map(void)
 {
 	int i;
@@ -332,11 +361,19 @@ static void __init bootmem_init(void)
 
 #else  /* !CONFIG_SGI_IP27 */
 
+static unsigned long __init bootmap_bytes(unsigned long pages)
+{
+	unsigned long bytes = DIV_ROUND_UP(pages, 8);
+
+	return ALIGN(bytes, sizeof(long));
+}
+
 static void __init bootmem_init(void)
 {
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	bool bootmap_valid = false;
 	int i;
 
 	/*
@@ -430,11 +467,42 @@ static void __init bootmem_init(void)
 #endif
 
 	/*
-	 * Initialize the boot-time allocator with low memory only.
+	 * check that mapstart doesn't overlap with any of
+	 * memory regions that have been reserved through eg. DTB
 	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
-					 min_low_pfn, max_low_pfn);
+	bootmap_size = bootmap_bytes(max_low_pfn - min_low_pfn);
+
+	bootmap_valid = memory_region_available(PFN_PHYS(mapstart),
+						bootmap_size);
+	for (i = 0; i < boot_mem_map.nr_map && !bootmap_valid; i++) {
+		unsigned long mapstart_addr;
+
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RESERVED:
+			mapstart_addr = PFN_ALIGN(boot_mem_map.map[i].addr +
+						boot_mem_map.map[i].size);
+			if (PHYS_PFN(mapstart_addr) < mapstart)
+				break;
+
+			bootmap_valid = memory_region_available(mapstart_addr,
+								bootmap_size);
+			if (bootmap_valid)
+				mapstart = PHYS_PFN(mapstart_addr);
+			break;
+		default:
+			break;
+		}
+	}
 
+	if (!bootmap_valid)
+		panic("No memory area to place a bootmap bitmap");
+
+	/*
+	 * Initialize the boot-time allocator with low memory only.
+	 */
+	if (bootmap_size != init_bootmem_node(NODE_DATA(0), mapstart,
+					 min_low_pfn, max_low_pfn))
+		panic("Unexpected memory size required for bootmap");
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
-- 
2.7.4
