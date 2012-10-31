Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:24:47 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:46870 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPUoYUzXT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:20:44 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:20:37 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 13/20] MIPS: Export routines needed by the KVM module.
Date:   Wed, 31 Oct 2012 11:20:34 -0400
Message-Id: <805EC5AB-6FF6-4C0B-B337-74494F67D7FF@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34825
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/mm/c-r4k.c   | 6 ++++--
 arch/mips/mm/cache.c   | 1 +
 arch/mips/mm/tlb-r4k.c | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2b61462..1923063 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -136,7 +136,8 @@ static void __cpuinit r4k_blast_dcache_page_indexed_setup(void)
 		r4k_blast_dcache_page_indexed = blast_dcache64_page_indexed;
 }
 
-static void (* r4k_blast_dcache)(void);
+void (* r4k_blast_dcache)(void);
+EXPORT_SYMBOL(r4k_blast_dcache);
 
 static void __cpuinit r4k_blast_dcache_setup(void)
 {
@@ -264,7 +265,8 @@ static void __cpuinit r4k_blast_icache_page_indexed_setup(void)
 		r4k_blast_icache_page_indexed = blast_icache64_page_indexed;
 }
 
-static void (* r4k_blast_icache)(void);
+void (* r4k_blast_icache)(void);
+EXPORT_SYMBOL(r4k_blast_icache);
 
 static void __cpuinit r4k_blast_icache_setup(void)
 {
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 07cec44..5aeb3eb 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -48,6 +48,7 @@ void (*flush_icache_all)(void);
 
 EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
+EXPORT_SYMBOL(flush_icache_all);
 
 #ifdef CONFIG_DMA_NONCOHERENT
 
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 4b9b935..fd30887 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/module.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
@@ -94,6 +95,7 @@ void local_flush_tlb_all(void)
 	FLUSH_ITLB;
 	EXIT_CRITICAL(flags);
 }
+EXPORT_SYMBOL(local_flush_tlb_all);
 
 /* All entries common to a mm share an asid.  To effectively flush
    these entries, we just bump the asid. */
-- 
1.7.11.3
