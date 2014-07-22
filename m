Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 21:05:14 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:41895 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863506AbaGVTBhFx4Mg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 21:01:37 +0200
Received: by mail-la0-f47.google.com with SMTP id mc6so72787lab.20
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xinrhNxko/5/UsqXF8JyBW8B/YSIfBkxPM8Ge3W57o=;
        b=sADHzCldSU2YE9gEGKeNVkz3R8MM4GKvOBAqRjlmLB+a3OjXwjuLOmPvCzqM/WOJgM
         leslAVpzn1aQdXNrOdqUf/dWfiO2TVGViQSAXaLZpV3vm2Mf5GCSJjcXAtJMu/W/0Ih5
         At4w25eWH8J3S/cbKOXkvrJMh8mf+/CEmJi9qfTQWO5vnz8KGiZNDED0ilbQ6M4FQVY5
         zM29u4LN+HVVVKLcuDs3I1KwhU6VIjBDjlHdpN7bGdgwoMXGmRwwtv1Q4+jCjd2mqhg+
         Noh99bQmjhwsoCQbzIfwqlxIL0tbVzB14p2NSdOybLAOlFbZYc3oAaTgYwfG7UnFsnPK
         TRDw==
X-Received: by 10.112.161.72 with SMTP id xq8mr34690408lbb.18.1406055691617;
        Tue, 22 Jul 2014 12:01:31 -0700 (PDT)
Received: from octofox.metropolis ([5.18.160.1])
        by mx.google.com with ESMTPSA id a7sm677355lae.37.2014.07.22.12.01.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jul 2014 12:01:30 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, David Rientjes <rientjes@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6/8] mm/highmem: make kmap cache coloring aware
Date:   Tue, 22 Jul 2014 23:01:11 +0400
Message-Id: <1406055673-10100-7-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1406055673-10100-1-git-send-email-jcmvbkbc@gmail.com>
References: <1406055673-10100-1-git-send-email-jcmvbkbc@gmail.com>
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41492
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

Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
[ Max: extract architecture-independent part of the original patch, clean
  up checkpatch and build warnings. ]
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes since the initial version:
- define set_pkmap_color(pg, cl) as do { } while (0) instead of /* */;
- rename is_no_more_pkmaps to no_more_pkmaps;
- change 'if (count > 0)' to 'if (count)' to better match the original
  code behavior;

 mm/highmem.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index b32b70c..88fb62e 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -44,6 +44,14 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
  */
 #ifdef CONFIG_HIGHMEM
 
+#ifndef ARCH_PKMAP_COLORING
+#define set_pkmap_color(pg, cl)		do { } while (0)
+#define get_last_pkmap_nr(p, cl)	(p)
+#define get_next_pkmap_nr(p, cl)	(((p) + 1) & LAST_PKMAP_MASK)
+#define no_more_pkmaps(p, cl)		(!(p))
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
+		if (no_more_pkmaps(last_pkmap_nr, color)) {
 			flush_all_zero_pkmaps();
 			count = LAST_PKMAP;
 		}
 		if (!pkmap_count[last_pkmap_nr])
 			break;	/* Found a usable entry */
-		if (--count)
+		count = get_next_pkmap_counter(count, color);
+		if (count)
 			continue;
 
 		/*
-- 
1.8.1.4
