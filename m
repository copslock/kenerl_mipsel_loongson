Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2014 03:13:16 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:35718 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861007AbaHBBMOV9eYo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Aug 2014 03:12:14 +0200
Received: by mail-la0-f49.google.com with SMTP id hz20so3745925lab.22
        for <linux-mips@linux-mips.org>; Fri, 01 Aug 2014 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ks2clyQ3nuf3uCRFj1AXmfkm82Y/gZiBtgatl4XElc=;
        b=JWsHMxc6UTTB/6fEW57KKbB7fWYuDbT6+aKqboGeaPRzyGfxbn48g7NF/bLHDI4hUF
         Khr6oOgvTXLGWqtUzKZxeiJF+DzvZB7msIy7kbFzXtfs/109Xt+YddR7bbu475oow1V2
         MYiVxcHsVPs4fIWyhmBFQSxsXQktxy7nhSLDPu+sXkH7VwyszWpYHtZ6VQCxeoZtD6wp
         tpso8At3hDy/yP2bCrslcMTImW71WmTQrm3b7/8hIY0QA9Nu8h4qNFi8zGjxb14VyIEy
         TZ3jWrx1hfpJ9KsK/IlJZj3ToO40fQZI/1mMxPWvHrDT/YIFc6LmtG2Mpr3ROy8CrL/V
         Usyw==
X-Received: by 10.112.52.225 with SMTP id w1mr9529386lbo.44.1406941928871;
        Fri, 01 Aug 2014 18:12:08 -0700 (PDT)
Received: from octofox.metropolis ([5.18.160.3])
        by mx.google.com with ESMTPSA id u6sm5611953laj.7.2014.08.01.18.12.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Aug 2014 18:12:08 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 2/2] xtensa: support aliasing cache in kmap
Date:   Sat,  2 Aug 2014 05:11:39 +0400
Message-Id: <1406941899-19932-3-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Define ARCH_PKMAP_COLORING and provide corresponding macro definitions
on cores with aliasing data cache.

Instead of single last_pkmap_nr maintain an array last_pkmap_nr_arr of
pkmap counters for each page color. Make sure that kmap maps physical
page at virtual address with color matching its physical address.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
This patch is only a demonstration of new interface usage, it depends
on other patches from the xtensa tree. Please don't commit it.

Changes v3->v4:
- none.

Changes v2->v3:
- switch to new function names/prototypes;
- implement get_pkmap_wait_queue_head, add kmap_waitqueues_init.

Changes v1->v2:
- new file.

 arch/xtensa/include/asm/highmem.h | 40 +++++++++++++++++++++++++++++++++++++--
 arch/xtensa/mm/highmem.c          | 18 ++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 2653ef5..2c7901e 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -12,19 +12,55 @@
 #ifndef _XTENSA_HIGHMEM_H
 #define _XTENSA_HIGHMEM_H
 
+#include <linux/wait.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
-#define PKMAP_BASE		(FIXADDR_START - PMD_SIZE)
-#define LAST_PKMAP		PTRS_PER_PTE
+#define PKMAP_BASE		((FIXADDR_START - \
+				  (LAST_PKMAP + 1) * PAGE_SIZE) & PMD_MASK)
+#define LAST_PKMAP		(PTRS_PER_PTE * DCACHE_N_COLORS)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
 #define PKMAP_NR(virt)		(((virt) - PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
 #define kmap_prot		PAGE_KERNEL
 
+#if DCACHE_WAY_SIZE > PAGE_SIZE
+#define get_pkmap_color get_pkmap_color
+static inline int get_pkmap_color(struct page *page)
+{
+	return DCACHE_ALIAS(page_to_phys(page));
+}
+
+extern unsigned int last_pkmap_nr_arr[];
+
+static inline unsigned int get_next_pkmap_nr(unsigned int color)
+{
+	last_pkmap_nr_arr[color] =
+		(last_pkmap_nr_arr[color] + DCACHE_N_COLORS) & LAST_PKMAP_MASK;
+	return last_pkmap_nr_arr[color] + color;
+}
+
+static inline int no_more_pkmaps(unsigned int pkmap_nr, unsigned int color)
+{
+	return pkmap_nr < DCACHE_N_COLORS;
+}
+
+static inline int get_pkmap_entries_count(unsigned int color)
+{
+	return LAST_PKMAP / DCACHE_N_COLORS;
+}
+
+extern wait_queue_head_t pkmap_map_wait_arr[];
+
+static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
+{
+	return pkmap_map_wait_arr + color;
+}
+#endif
+
 extern pte_t *pkmap_page_table;
 
 void *kmap_high(struct page *page);
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 466abae..8cfb71e 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -14,6 +14,23 @@
 
 static pte_t *kmap_pte;
 
+#if DCACHE_WAY_SIZE > PAGE_SIZE
+unsigned int last_pkmap_nr_arr[DCACHE_N_COLORS];
+wait_queue_head_t pkmap_map_wait_arr[DCACHE_N_COLORS];
+
+static void __init kmap_waitqueues_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pkmap_map_wait_arr); ++i)
+		init_waitqueue_head(pkmap_map_wait_arr + i);
+}
+#else
+static inline void kmap_waitqueues_init(void)
+{
+}
+#endif
+
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 {
 	return (type + KM_TYPE_NR * smp_processor_id()) * DCACHE_N_COLORS +
@@ -72,4 +89,5 @@ void __init kmap_init(void)
 	/* cache the first kmap pte */
 	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
 	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
+	kmap_waitqueues_init();
 }
-- 
1.8.1.4
