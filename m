Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2018 23:04:06 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994621AbeDEVD6w1ODL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Apr 2018 23:03:58 +0200
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B5084068024;
        Thu,  5 Apr 2018 21:03:52 +0000 (UTC)
Received: from redhat.com (ovpn-122-62.rdu2.redhat.com [10.10.122.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E4E9AB58A;
        Thu,  5 Apr 2018 21:03:51 +0000 (UTC)
Date:   Fri, 6 Apr 2018 00:03:50 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 3/3] mm/gup: document return value
Message-ID: <1522962072-182137-6-git-send-email-mst@redhat.com>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522962072-182137-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Apr 2018 21:03:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Apr 2018 21:03:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

__get_user_pages_fast handles errors differently from
get_user_pages_fast: the former always returns the number of pages
pinned, the later might return a negative error code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/mips/mm/gup.c  | 2 ++
 arch/s390/mm/gup.c  | 2 ++
 arch/sh/mm/gup.c    | 2 ++
 arch/sparc/mm/gup.c | 4 ++++
 mm/gup.c            | 4 +++-
 mm/util.c           | 6 ++++--
 6 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index 1e4658e..5a4875ca 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -178,6 +178,8 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 /*
  * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
  * back to the regular GUP.
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
  */
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
diff --git a/arch/s390/mm/gup.c b/arch/s390/mm/gup.c
index 05c8abd..2809d11 100644
--- a/arch/s390/mm/gup.c
+++ b/arch/s390/mm/gup.c
@@ -220,6 +220,8 @@ static inline int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 /*
  * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
  * back to the regular GUP.
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
  */
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
index 8045b5b..56c86ca 100644
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -160,6 +160,8 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 /*
  * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
  * back to the regular GUP.
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
  */
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index 5335ba3..ca3eb69 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -192,6 +192,10 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	return 1;
 }
 
+/*
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
+ */
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 8f3a064..5cb5bb1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1740,7 +1740,9 @@ bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
 
 /*
  * Like get_user_pages_fast() except it's IRQ-safe in that it won't fall back to
- * the regular GUP. It will only return non-negative values.
+ * the regular GUP.
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
  */
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
diff --git a/mm/util.c b/mm/util.c
index c125050..db2f005 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -297,8 +297,10 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 /*
  * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
  * back to the regular GUP.
- * If the architecture not support this function, simply return with no
- * page pinned
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
+ * If the architecture does not support this function, simply return with no
+ * pages pinned.
  */
 int __weak __get_user_pages_fast(unsigned long start,
 				 int nr_pages, int write, struct page **pages)
-- 
MST
