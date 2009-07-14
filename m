Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2009 15:37:26 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:54176 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492598AbZGNNhU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Jul 2009 15:37:20 +0200
Received: from localhost.localdomain (p8194-ipad209funabasi.chiba.ocn.ne.jp [58.88.119.194])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 283175E29; Tue, 14 Jul 2009 22:37:07 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix HPAGE_SIZE redifinition
Date:	Tue, 14 Jul 2009 22:37:09 +0900
Message-Id: <1247578629-23079-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch fixes warnings like this:
  CC      fs/proc/meminfo.o
In file included from /work/linux/include/linux/mmzone.h:20,
                 from /work/linux/include/linux/gfp.h:4,
                 from /work/linux/include/linux/mm.h:8,
                 from /work/linux/fs/proc/meminfo.c:5:
/work/linux/arch/mips/include/asm/page.h:36:1: warning: "HPAGE_SIZE" redefined
In file included from /work/linux/fs/proc/meminfo.c:2:
/work/linux/include/linux/hugetlb.h:107:1: warning: this is the location of the previous definition

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/page.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 96a14a4..4320239 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -32,10 +32,12 @@
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
 
+#ifdef CONFIG_HUGETLB_PAGE
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#endif /* CONFIG_HUGETLB_PAGE */
 
 #ifndef __ASSEMBLY__
 
-- 
1.5.6.5
