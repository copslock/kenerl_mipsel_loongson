Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 20:08:01 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1331 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492297Ab0CCTH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 20:07:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8eb3940000>; Wed, 03 Mar 2010 11:08:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 11:07:16 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 11:07:16 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o23J7BTU027745;
        Wed, 3 Mar 2010 11:07:11 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o23J799r027744;
        Wed, 3 Mar 2010 11:07:09 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
Date:   Wed,  3 Mar 2010 11:07:07 -0800
Message-Id: <1267643227-27710-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 03 Mar 2010 19:07:16.0061 (UTC) FILETIME=[BD1E18D0:01CABB04]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The config option CAVIUM_RESERVE32_USE_WIRED_TLB is not supported.
Remove the dead code controlled by it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c |   67 +--------------------------------------
 1 files changed, 1 insertions(+), 66 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index f58eed6..4ba3277 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -186,54 +186,6 @@ void octeon_check_cpu_bist(void)
 	write_octeon_c0_dcacheerr(0);
 }
 
-#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
-/**
- * Called on every core to setup the wired tlb entry needed
- * if CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB is set.
- *
- */
-static void octeon_hal_setup_per_cpu_reserved32(void *unused)
-{
-	/*
-	 * The config has selected to wire the reserve32 memory for all
-	 * userspace applications. We need to put a wired TLB entry in for each
-	 * 512MB of reserve32 memory. We only handle double 256MB pages here,
-	 * so reserve32 must be multiple of 512MB.
-	 */
-	uint32_t size = CONFIG_CAVIUM_RESERVE32;
-	uint32_t entrylo0 =
-		0x7 | ((octeon_reserve32_memory & ((1ul << 40) - 1)) >> 6);
-	uint32_t entrylo1 = entrylo0 + (256 << 14);
-	uint32_t entryhi = (0x80000000UL - (CONFIG_CAVIUM_RESERVE32 << 20));
-	while (size >= 512) {
-#if 0
-		pr_info("CPU%d: Adding double wired TLB entry for 0x%lx\n",
-			smp_processor_id(), entryhi);
-#endif
-		add_wired_entry(entrylo0, entrylo1, entryhi, PM_256M);
-		entrylo0 += 512 << 14;
-		entrylo1 += 512 << 14;
-		entryhi += 512 << 20;
-		size -= 512;
-	}
-}
-#endif /* CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB */
-
-/**
- * Called to release the named block which was used to made sure
- * that nobody used the memory for something else during
- * init. Now we'll free it so userspace apps can use this
- * memory region with bootmem_alloc.
- *
- * This function is called only once from prom_free_prom_memory().
- */
-void octeon_hal_setup_reserved32(void)
-{
-#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
-	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 0, 1);
-#endif
-}
-
 /**
  * Reboot Octeon
  *
@@ -502,25 +454,13 @@ void __init prom_init(void)
 	 * memory when it is getting memory from the
 	 * bootloader. Later, after the memory allocations are
 	 * complete, the reserve32 will be freed.
-	 */
-#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
-	if (CONFIG_CAVIUM_RESERVE32 & 0x1ff)
-		pr_err("CAVIUM_RESERVE32 isn't a multiple of 512MB. "
-		       "This is required if CAVIUM_RESERVE32_USE_WIRED_TLB "
-		       "is set\n");
-	else
-		addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
-							0, 0, 512 << 20,
-							"CAVIUM_RESERVE32", 0);
-#else
-	/*
+	 *
 	 * Allocate memory for RESERVED32 aligned on 2MB boundary. This
 	 * is in case we later use hugetlb entries with it.
 	 */
 	addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
 						0, 0, 2 << 20,
 						"CAVIUM_RESERVE32", 0);
-#endif
 	if (addr < 0)
 		pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
 	else
@@ -822,9 +762,4 @@ void prom_free_prom_memory(void)
 		panic("Unable to request_irq(OCTEON_IRQ_RML)\n");
 	}
 #endif
-
-	/* This call is here so that it is performed after any TLB
-	   initializations. It needs to be after these in case the
-	   CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB option is set */
-	octeon_hal_setup_reserved32();
 }
-- 
1.6.6.1
