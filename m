Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 18:21:07 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:40931 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861337AbaGQQVFLn37h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 18:21:05 +0200
Received: by mail-la0-f43.google.com with SMTP id hr17so1914215lab.2
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H0q2hDYD3nx6dRF029umfEMQFErJ4hS3M4MMKf3WfoE=;
        b=GdMWbZzBkzwg0pffs210Ec7eTAc0b6Aq6dsJHOes9fFraWle6glmii8f6XMVCD024d
         9Pym0mkDQ/IBn65LRI7ZJznEN1mfdIfAQndu+0LTst7JYKoNY8CEeCX6eaxr8BDqt5ho
         vh27+H6/wGCcJxciZCeuMzZK8M9DswQ+L+LyeEnm1nUH9jn53eii3CAz6du/DqXX6tFy
         ml0qlCap1TtTEjnE3FwlI+P4aZE0cOz/yerf0dreHB5Bf0zHxK1tBXokwxtFPBSrXESM
         +pA4VVKpk0MeM6uRy/COOqv1YzwypIi2gmtAqOKXbUbhbpXpz2Dcqgs2L1G2hBP3OJ/g
         YY9g==
X-Received: by 10.152.26.231 with SMTP id o7mr35061211lag.41.1405614059626;
        Thu, 17 Jul 2014 09:20:59 -0700 (PDT)
Received: from octofox.metropolis ([188.134.19.124])
        by mx.google.com with ESMTPSA id uo5sm4186295lbb.6.2014.07.17.09.20.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 09:20:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] mm/highmem.c: make kmap cache coloring aware
Date:   Thu, 17 Jul 2014 20:20:35 +0400
Message-Id: <1405614035-11413-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41280
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
mapping address of high pages according to their color.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
[ Max: extract architecture-independent part of the original patch, clean
  up checkpatch and build warnings. ]
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
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
