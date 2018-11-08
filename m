Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 15:46:06 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:58600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992066AbeKHOog026Av (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Nov 2018 15:44:36 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5844AEB2;
        Thu,  8 Nov 2018 14:44:35 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     rppt@linux.vnet.ibm.com
Subject: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3 NUMA
Date:   Thu,  8 Nov 2018 15:44:28 +0100
Message-Id: <20181108144428.28149-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
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

Commit bcec54bf3118 ("mips: switch to NO_BOOTMEM") broke SGI-IP27
and NUMA enabled loongson3 by doing memblock_set_current_limit()
before max_low_pfn has been evaluated. Both platforms need to do the
memblock_set_current_limit() in platform specific code. For
consistency the call to memblock_set_current_limit() is moved
to the common bootmem_init(), where max_low_pfn is calculated
for non NUMA enabled platforms.

Fixes: bcec54bf3118 ("mips: switch to NO_BOOTMEM")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/kernel/setup.c               | 18 +++++++++---------
 arch/mips/loongson64/loongson-3/numa.c |  1 +
 arch/mips/sgi-ip27/ip27-memory.c       |  1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ea09ed6a80a9..b5167b198231 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -576,6 +576,15 @@ static void __init bootmem_init(void)
 	 * Reserve initrd memory if needed.
 	 */
 	finalize_initrd();
+
+	/*
+	 * Prevent memblock from allocating high memory.
+	 * This cannot be done before max_low_pfn is detected, so up
+	 * to this point is possible to only reserve physical memory
+	 * with memblock_reserve; memblock_alloc* can be used
+	 * only after this point
+	 */
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 }
 
 #endif	/* CONFIG_SGI_IP27 */
@@ -854,15 +863,6 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	bootmem_init();
 
-	/*
-	 * Prevent memblock from allocating high memory.
-	 * This cannot be done before max_low_pfn is detected, so up
-	 * to this point is possible to only reserve physical memory
-	 * with memblock_reserve; memblock_alloc* can be used
-	 * only after this point
-	 */
-	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
-
 #ifdef CONFIG_PROC_VMCORE
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
 		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 622761878cd1..5593a8e3cd88 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -265,6 +265,7 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
 #endif
 	zones_size[ZONE_NORMAL] = max_low_pfn;
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 	free_area_init_nodes(zones_size);
 }
 
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index d8b8444d6795..0d0deeae1f47 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -468,6 +468,7 @@ void __init paging_init(void)
 			max_low_pfn = end_pfn;
 	}
 	zones_size[ZONE_NORMAL] = max_low_pfn;
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 	free_area_init_nodes(zones_size);
 }
 
-- 
2.13.7
