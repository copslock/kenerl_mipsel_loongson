Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:16:26 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:59727 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdCXQNnvx5nA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iwCTDw1gKmaip942Vra7u7vH5dYa0pxQj9ZXMAP62io=; b=aCW+iwBWqWs7jo2FYtWqb4x8J
        yQLTZPTjK8V/Zs4qPXEZIgwj7Hocrp05wbd2v3Pg2fGwrPWr2fzg5ApbPiTMTD2AMQt72MGCE/Dcg
        gFMr9XluEYM3P9lwF+lm6k0kdEBVjFisF9hbXMsd+gGA8uiEpD8enqf8ftiwzUVw7WwZQ4XwdwGg6
        bBFQp12+0UcBkfWD0pLZAw4R2ajZiRz7cVw4GV/JeGwY1HEOM4BXuYi/lf0zo72goc40NgAuO+kA1
        Mm9zK/lCJDIMjErWTJcUamQSpppiIxT1rddyVABmPyuGXaidurHLVRch/tVfeQVkL82mVrNFKyXXe
        gpmnEtBEg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004v9-Ju; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 5/7] zram: Convert to using memset_l
Date:   Fri, 24 Mar 2017 09:13:16 -0700
Message-Id: <20170324161318.18718-6-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@infradead.org
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

From: Matthew Wilcox <mawilcox@microsoft.com>

zram was the motivation for creating memset_l().  Minchan Kim sees a 7%
performance improvement on x86 with 100MB of non-zero deduplicatable
data:

        perf stat -r 10 dd if=/dev/zram0 of=/dev/null

vanilla:        0.232050465 seconds time elapsed ( +-  0.51% )
memset_l:	0.217219387 seconds time elapsed ( +-  0.07% )

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Tested-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e27d89a36c34..25dcad309695 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -157,20 +157,11 @@ static inline void update_used_max(struct zram *zram,
 	} while (old_max != cur_max);
 }
 
-static inline void zram_fill_page(char *ptr, unsigned long len,
+static inline void zram_fill_page(void *ptr, unsigned long len,
 					unsigned long value)
 {
-	int i;
-	unsigned long *page = (unsigned long *)ptr;
-
 	WARN_ON_ONCE(!IS_ALIGNED(len, sizeof(unsigned long)));
-
-	if (likely(value == 0)) {
-		memset(ptr, 0, len);
-	} else {
-		for (i = 0; i < len / sizeof(*page); i++)
-			page[i] = value;
-	}
+	memset_l(ptr, value, len / sizeof(unsigned long));
 }
 
 static bool page_same_filled(void *ptr, unsigned long *element)
@@ -193,7 +184,7 @@ static bool page_same_filled(void *ptr, unsigned long *element)
 static void handle_same_page(struct bio_vec *bvec, unsigned long element)
 {
 	struct page *page = bvec->bv_page;
-	void *user_mem;
+	char *user_mem;
 
 	user_mem = kmap_atomic(page);
 	zram_fill_page(user_mem + bvec->bv_offset, bvec->bv_len, element);
-- 
2.11.0
