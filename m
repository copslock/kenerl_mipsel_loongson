Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 19:03:35 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58825 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861337AbaGQRDba7-a7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 19:03:31 +0200
Received: by mail-lb0-f180.google.com with SMTP id v6so1648291lbi.25
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0UX74K8A/YN0mf7AwVNJZZ6ExgGQIX7q46/psoV2DGY=;
        b=K/2Ml0mr5Jk3sOaUuKgMXU3z4rHUn9zk/erMBC36PEYnSyFwEfERdoCUkCVXCOLVSN
         bMCvQjLK4sbZAKdOaiZw6qAVUqo3MKLUDrdy+E0oSM3xatVzS6YUUSgj0YRC8fBXdZNk
         FpQ/j/IcLaSXy3vzQK0aL+4JFxpQfOR3uQWh5svXrOhaLV4VrA+lJKI2WHaugYOxvFu9
         j5uXiRA593rXnbF39bRi/JO2On0FbZDXfxqUTKSREnrig0uRzk+xbtCliMTBWz6BK1oD
         2hsWmuuTp71Zo69eBM/q+kzSMxwKXoDuA+lT8p/dGd0850pjHmaLsL+Y9gFv0AdPi4/L
         M69A==
X-Received: by 10.152.5.105 with SMTP id r9mr34053716lar.37.1405616605457;
        Thu, 17 Jul 2014 10:03:25 -0700 (PDT)
Received: from octofox.metropolis ([188.134.19.124])
        by mx.google.com with ESMTPSA id x6sm2055003lae.12.2014.07.17.10.03.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 10:03:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] mm/highmem: make kmap cache coloring aware
Date:   Thu, 17 Jul 2014 21:03:18 +0400
Message-Id: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41282
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Provide hooks that allow architectures with aliasing cache to align
mapping address of high pages according to their color. Such architectures
may enforce similar coloring of low- and high-memory page mappings and
reuse existing cache management functions to support highmem.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
[ Max: extract architecture-independent part of the original patch, clean
  up checkpatch and build warnings. ]
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- fix description

 mm/highmem.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index b32b70c..6898a8b 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -44,6 +44,14 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
  */
 #ifdef CONFIG_HIGHMEM
 
+#ifndef ARCH_PKMAP_COLORING
+#define set_pkmap_color(pg, cl)		/* */
+#define get_last_pkmap_nr(p, cl)	(p)
+#define get_next_pkmap_nr(p, cl)	(((p) + 1) & LAST_PKMAP_MASK)
+#define is_no_more_pkmaps(p, cl)	(!(p))
+#define get_next_pkmap_counter(c, cl)	((c) - 1)
+#endif
+
 unsigned long totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(totalhigh_pages);
 
@@ -161,19 +169,24 @@ static inline unsigned long map_new_virtual(struct page *page)
 {
 	unsigned long vaddr;
 	int count;
+	int color __maybe_unused;
+
+	set_pkmap_color(page, color);
+	last_pkmap_nr = get_last_pkmap_nr(last_pkmap_nr, color);
 
 start:
 	count = LAST_PKMAP;
 	/* Find an empty entry */
 	for (;;) {
-		last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
-		if (!last_pkmap_nr) {
+		last_pkmap_nr = get_next_pkmap_nr(last_pkmap_nr, color);
+		if (is_no_more_pkmaps(last_pkmap_nr, color)) {
 			flush_all_zero_pkmaps();
 			count = LAST_PKMAP;
 		}
 		if (!pkmap_count[last_pkmap_nr])
 			break;	/* Found a usable entry */
-		if (--count)
+		count = get_next_pkmap_counter(count, color);
+		if (count > 0)
 			continue;
 
 		/*
-- 
1.8.1.4
