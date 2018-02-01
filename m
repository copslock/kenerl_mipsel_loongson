Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 12:39:59 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:41894 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994828AbeBALjuB6OFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2018 12:39:50 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 01 Feb 2018 11:39:43 +0000
Received: from WR-NOWAKOWSKI.mipstec.com (192.168.159.143) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 1 Feb 2018 03:37:48 -0800
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
To:     Mathieu Malaterre <malat@debian.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
Date:   Thu, 1 Feb 2018 12:37:21 +0100
Message-ID: <20180201113721.24776-1-marcin.nowakowski@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.143]
X-BESS-ID: 1517485181-637140-31752-183159-6
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189582
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") added a
fix to ensure that the memory range between PHYS_OFFSET and low memory
address specified by mem= cmdline argument is not later processed by
free_all_bootmem.  This change was incorrect for systems where the
commandline specifies more than 1 mem argument, as it will cause all
memory between PHYS_OFFSET and each of the memory offsets to be marked
as reserved, which results in parts of the RAM marked as reserved
(Creator CI20's u-boot has a default commandline argument 'mem=256M@0x0
mem=768M@0x30000000').

Change the behaviour to ensure that only the range between PHYS_OFFSET
and the lowest start address of the memories is marked as protected.

This change also ensures that the range is marked protected even if it's
only defined through the devicetree and not only via commandline
arguments.

Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
Cc: <stable@vger.kernel.org> # v4.11+
---
v3: Update stable version, code cleanup as suggested by James Hogan
v2: Use updated email adress, add tag for stable.
---
 arch/mips/kernel/setup.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678de116..e4a1581ce822 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -375,6 +375,7 @@ static void __init bootmem_init(void)
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	phys_addr_t ramstart = (phys_addr_t)ULLONG_MAX;
 	bool bootmap_valid = false;
 	int i;
 
@@ -395,7 +396,8 @@ static void __init bootmem_init(void)
 	max_low_pfn = 0;
 
 	/*
-	 * Find the highest page frame number we have available.
+	 * Find the highest page frame number we have available
+	 * and the lowest used RAM address
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
@@ -407,6 +409,8 @@ static void __init bootmem_init(void)
 		end = PFN_DOWN(boot_mem_map.map[i].addr
 				+ boot_mem_map.map[i].size);
 
+		ramstart = min(ramstart, boot_mem_map.map[i].addr);
+
 #ifndef CONFIG_HIGHMEM
 		/*
 		 * Skip highmem here so we get an accurate max_low_pfn if low
@@ -436,6 +440,13 @@ static void __init bootmem_init(void)
 		mapstart = max(reserved_end, start);
 	}
 
+	/*
+	 * Reserve any memory between the start of RAM and PHYS_OFFSET
+	 */
+	if (ramstart > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
+				  BOOT_MEM_RESERVED);
+
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
 	if (min_low_pfn > ARCH_PFN_OFFSET) {
@@ -664,9 +675,6 @@ static int __init early_parse_mem(char *p)
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
 
-	if (start && start > PHYS_OFFSET)
-		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
-				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);
-- 
2.14.1
