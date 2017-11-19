Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 15:35:43 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:55170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbdKSOfJsJASi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 15:35:09 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D9B1516;
        Sun, 19 Nov 2017 14:35:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.4 48/59] MIPS: init: Ensure bootmem does not corrupt reserved memory
Date:   Sun, 19 Nov 2017 15:32:56 +0100
Message-Id: <20171119143153.084280405@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171119143150.964013720@linuxfoundation.org>
References: <20171119143150.964013720@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit d9b5b658210f28ed9f70c757d553e679d76e2986 ]

Current init code initialises bootmem allocator with all of the low
memory that it assumes is available, but does not check for reserved
memory block, which can lead to corruption of data that may be stored
there.
Move bootmem's allocation map to a location that does not cross any
reserved regions

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14609/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/setup.c |   74 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -152,6 +152,35 @@ void __init detect_memory_region(phys_ad
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
@@ -300,11 +329,19 @@ static void __init bootmem_init(void)
 
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
@@ -385,11 +422,42 @@ static void __init bootmem_init(void)
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
