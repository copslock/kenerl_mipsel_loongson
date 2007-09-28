Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 17:35:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34246 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029195AbXI1Qfr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 17:35:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8SGZk6W006191;
	Fri, 28 Sep 2007 17:35:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8SGZjfb006190;
	Fri, 28 Sep 2007 17:35:45 +0100
Date:	Fri, 28 Sep 2007 17:35:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] hugetlb: Fix clear_user_highpage arguments
Message-ID: <20070928163545.GA5933@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The virtual address space argument of clear_user_highpage is supposed to
be the virtual address where the page being cleared will eventually be
mapped. This allows architectures with virtually indexed caches a few
clever tricks.  That sort of trick falls over in painful ways if the
virtual address argument is wrong.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 84c795e..eab8c42 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -42,7 +42,7 @@ static void clear_huge_page(struct page *page, unsigned long addr)
 	might_sleep();
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); i++) {
 		cond_resched();
-		clear_user_highpage(page + i, addr);
+		clear_user_highpage(page + i, addr + i * PAGE_SIZE);
 	}
 }
 
