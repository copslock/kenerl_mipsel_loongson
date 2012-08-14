Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 20:08:43 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35072 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903852Ab2HNSIO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 20:08:14 +0200
Received: by yhjj52 with SMTP id j52so803200yhj.36
        for <multiple recipients>; Tue, 14 Aug 2012 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2fOmi24nSGVcCDhfONBrsKnEmY4SruT6KNM9CiFS2y8=;
        b=TKeb5NPREhTIlhczDBS6lD4M1NY2I9rWKQPipfI+z/PArSHQMKgyADyFl84fW9LTiR
         mTRU5NmF3nP1wzxePEfiYQF4LCLJGYz0AKjEHI/BiqCbm9KJIMYg8AxzqfrQPTeHhIPO
         yLOGJxTDNxS1JkLcMaKZiReRlRiTIwnZIh+3cN/uaexS6B0bfBY6A4feS+Zko686JKV4
         X2fj7hhPBaLkLhQJHwsfFXm91wkEhw3fySSa38gxmcCYr8BVPYaCgSMh8FJ6xizykIyO
         wcY/DJYvOOtxrAtzEl855lyspXn2RyzzvtWKMUW6fVarj41N3q/OKatMyyKq3lzjjXO5
         hbcw==
Received: by 10.50.161.234 with SMTP id xv10mr1516633igb.39.1344967688211;
        Tue, 14 Aug 2012 11:08:08 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id uq6sm12231028igb.14.2012.08.14.11.08.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 11:08:07 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q7EI857H013221;
        Tue, 14 Aug 2012 11:08:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q7EI859h013220;
        Tue, 14 Aug 2012 11:08:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] MIPS: Align swapper_pg_dir to 64K for better TLB Refill code.
Date:   Tue, 14 Aug 2012 11:08:01 -0700
Message-Id: <1344967681-13179-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
References: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

We can save an instruction in the TLB Refill path for kernel mappings
by aligning swapper_pg_dir on a 64K boundary.  The address of
swapper_pg_dir can be generated with a single LUI instead of
LUI/{D}ADDUI.

The alignment of __init_end is bumped up to 64K so there are no holes
between it and swapper_pg_dir, which is placed at the very beginning
of .bss.

The alignment of invalid_pmd_table and invalid_pte_table can be
relaxed to PAGE_SIZE.  We do this by using __page_aligned_bss, which
has the added benefit of eliminating alignment holes in .bss.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/vmlinux.lds.S |   21 +++++++++++++++++++--
 arch/mips/mm/init.c            |   17 +++++++++--------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index df243a6..007ccbe 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -1,6 +1,13 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
+
+/*
+ * Put .bss..swapper_pg_dir as the first thing in .bss. This will
+ * ensure that it has .bss alignment (64K).
+ */
+#define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
+
 #include <asm-generic/vmlinux.lds.h>
 
 #undef mips
@@ -119,11 +126,21 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
-	. = ALIGN(PAGE_SIZE);
+	/*
+	 * Align to 64K in attempt to eliminate holes before the
+	 * .bss..swapper_pg_dir section at the start of .bss.  This
+	 * also satisfies PAGE_SIZE alignment as the largest page size
+	 * allowed is 64K.
+	 */
+	. = ALIGN(0x10000);
 	__init_end = .;
 	/* freed after init ends here */
 
-	BSS_SECTION(0, 0, 0)
+	/*
+	 * Force .bss to 64K alignment so that .bss..swapper_pg_dir
+	 * gets that alignment.  .sbss should be empty, so there will be
+	 * no holes after __init_end. */
+	BSS_SECTION(0, 0x10000, 0)
 
 	_end = . ;
 
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 1a85ba9..be9acb2 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -469,19 +469,20 @@ void __init_refok free_initmem(void)
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 unsigned long pgd_current[NR_CPUS];
 #endif
-/*
- * On 64-bit we've got three-level pagetables with a slightly
- * different layout ...
- */
-#define __page_aligned(order) __attribute__((__aligned__(PAGE_SIZE<<order)))
 
 /*
  * gcc 3.3 and older have trouble determining that PTRS_PER_PGD and PGD_ORDER
  * are constants.  So we use the variants from asm-offset.h until that gcc
  * will officially be retired.
+ *
+ * Align swapper_pg_dir in to 64K, allows its address to be loaded
+ * with a single LUI instruction in the TLB handlers.  If we used
+ * __aligned(64K), its size would get rounded up to the alignment
+ * size, and waste space.  So we place it in its own section and align
+ * it in the linker script.
  */
-pgd_t swapper_pg_dir[_PTRS_PER_PGD] __page_aligned(_PGD_ORDER);
+pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 #ifndef __PAGETABLE_PMD_FOLDED
-pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned(PMD_ORDER);
+pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
 #endif
-pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
+pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
-- 
1.7.2.3
