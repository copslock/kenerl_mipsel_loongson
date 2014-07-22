Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 21:07:14 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:41558 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863507AbaGVTBjB1mwt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 21:01:39 +0200
Received: by mail-la0-f41.google.com with SMTP id s18so77232lam.0
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5svbS5VOisP0kHce65VXS1gUtOL/eFk7EG3vo7g5Nbc=;
        b=I7Ope4oDoouKUdzSdgI47uED334H5vtlmPVIGmKoVFIg1c/chR+5OYcGXRls6oJCnL
         188CSIVwQti2kHkcqZCGZ67PbKXyIjTKuy/dZy2qIPEKW9nabtNS8T7QakOP6J8pm1vR
         4ybMzYVjXRrpM6SG9sYdkq4+ayey0Hz03KqTz0bNiZX17vMLIJKmnOnnSALg39hUE90d
         f5HvfRQV2s3x3X/e6J7VuoYDgYs/RVYIZPJVtaSzq8zDjZ/XjbPTRmv7bAPCVjwlHtIl
         L1jlfD4a4SseXWkVX3W+lwm1ef3tYIJt/J/gazL/cnnnf9hJ+2iZWtJPogUV/PWttcph
         uzSQ==
X-Received: by 10.152.5.167 with SMTP id t7mr29065769lat.54.1406055693239;
        Tue, 22 Jul 2014 12:01:33 -0700 (PDT)
Received: from octofox.metropolis ([5.18.160.1])
        by mx.google.com with ESMTPSA id a7sm677355lae.37.2014.07.22.12.01.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jul 2014 12:01:32 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, David Rientjes <rientjes@google.com>
Subject: [PATCH 7/8] xtensa: support aliasing cache in kmap
Date:   Tue, 22 Jul 2014 23:01:12 +0400
Message-Id: <1406055673-10100-8-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1406055673-10100-1-git-send-email-jcmvbkbc@gmail.com>
References: <1406055673-10100-1-git-send-email-jcmvbkbc@gmail.com>
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41493
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

Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/highmem.h | 18 ++++++++++++++++--
 arch/xtensa/mm/highmem.c          |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 2653ef5..a5c3380 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -17,14 +17,28 @@
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
+#define ARCH_PKMAP_COLORING
+#define set_pkmap_color(pg, cl)		((cl) = DCACHE_ALIAS(page_to_phys(pg)))
+#define get_last_pkmap_nr(p, cl)	(last_pkmap_nr_arr[cl] + (cl))
+#define get_next_pkmap_nr(p, cl)	\
+	((last_pkmap_nr_arr[cl] = ((last_pkmap_nr_arr[cl] + DCACHE_N_COLORS) & \
+				   LAST_PKMAP_MASK)) + (cl))
+#define no_more_pkmaps(p, cl)		((p) < DCACHE_N_COLORS)
+#define get_next_pkmap_counter(c, cl)	((c) - DCACHE_N_COLORS)
+
+extern unsigned int last_pkmap_nr_arr[];
+#endif
+
 extern pte_t *pkmap_page_table;
 
 void *kmap_high(struct page *page);
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 466abae..3742a37 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <asm/tlbflush.h>
 
+unsigned int last_pkmap_nr_arr[DCACHE_N_COLORS];
 static pte_t *kmap_pte;
 
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
-- 
1.8.1.4
