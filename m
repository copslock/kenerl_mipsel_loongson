Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 13:07:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25323 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994913AbdIELG7L2hgo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Sep 2017 13:06:59 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 76E85C213C93B;
        Tue,  5 Sep 2017 12:06:49 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 5 Sep 2017 12:06:52 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: fix incorrect mem=X@Y handling
Date:   Tue, 5 Sep 2017 13:06:48 +0200
Message-ID: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59933
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

Change 73fbc1eba7ff added a fix to ensure that the memory range between
PHYS_OFFSET and low memory address specified by mem= cmdline argument is
not later processed by free_all_bootmem.
This change was incorrect for systems where the commandline specifies
more than 1 mem argument, as it will cause all memory between
PHYS_OFFSET and each of the memory offsets to be marked as reserved,
which results in parts of the RAM marked as reserved (Creator CI20's
u-boot has a default commandline argument 'mem=256M@0x0
mem=768M@0x30000000').

Change the behaviour to ensure that only the range between PHYS_OFFSET
and the lowest start address of the memories is marked as protected.

This change also ensures that the range is marked protected even if it's
only defined through the devicetree and not only via commandline
arguments.

Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/setup.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fe39397..a1c39ec 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -374,6 +374,7 @@ static void __init bootmem_init(void)
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	phys_addr_t ramstart = ~0UL;
 	bool bootmap_valid = false;
 	int i;
 
@@ -394,6 +395,21 @@ static void __init bootmem_init(void)
 	max_low_pfn = 0;
 
 	/*
+	 * Reserve any memory between the start of RAM and PHYS_OFFSET
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		ramstart = min(ramstart, boot_mem_map.map[i].addr);
+	}
+
+	if (ramstart > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
+				  BOOT_MEM_RESERVED);
+
+
+	/*
 	 * Find the highest page frame number we have available.
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
@@ -663,9 +679,6 @@ static int __init early_parse_mem(char *p)
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
 
-	if (start && start > PHYS_OFFSET)
-		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
-				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);
-- 
2.7.4
