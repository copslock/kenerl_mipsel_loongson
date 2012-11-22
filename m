Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:39:35 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:33834 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828084Ab2KVCfZi0q-A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:25 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:35:18 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id AA94B630281; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 12/18] MIPS: Export routines needed by the KVM module.
Date:   Wed, 21 Nov 2012 18:34:10 -0800
Message-Id: <1353551656-23579-13-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35090
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
