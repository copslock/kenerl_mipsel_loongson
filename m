Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 13:45:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36173 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823045Ab2JOLpFFHnP8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Oct 2012 13:45:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9FBixpI030885;
        Mon, 15 Oct 2012 13:44:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9FBiutp030883;
        Mon, 15 Oct 2012 13:44:56 +0200
Date:   Mon, 15 Oct 2012 13:44:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH] mm: huge_memory: Fix build error.
Message-ID: <20121015114456.GA30314@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Certain configurations won't implicitly pull in <linux/pagemap.h> resulting
in the following build error:

mm/huge_memory.c: In function 'release_pte_page':
mm/huge_memory.c:1697:2: error: implicit declaration of function 'unlock_page' [-Werror=implicit-function-declaration]
mm/huge_memory.c: In function '__collapse_huge_page_isolate':
mm/huge_memory.c:1757:3: error: implicit declaration of function 'trylock_page' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

Reported-by: David Daney <david.daney@cavium.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 mm/huge_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f0e5306..b5d4eb8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -17,6 +17,7 @@
 #include <linux/khugepaged.h>
 #include <linux/freezer.h>
 #include <linux/mman.h>
+#include <linux/pagemap.h>
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 #include "internal.h"
