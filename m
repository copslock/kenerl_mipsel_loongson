Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 02:00:06 +0200 (CEST)
Received: from smtp03.mtu.ru ([62.5.255.50]:46074 "EHLO smtp03.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1103046AbYDAX7S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 01:59:18 +0200
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id F21891870854;
	Wed,  2 Apr 2008 03:58:46 +0400 (MSD)
Received: from localhost.localdomain (ppp91-76-28-42.pppoe.mtu-net.ru [91.76.28.42])
	by smtp03.mtu.ru (Postfix) with ESMTP id D53751870752;
	Wed,  2 Apr 2008 03:58:46 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] [MIPS] unexport copy_user_highpage()
Date:	Wed,  2 Apr 2008 03:58:34 +0400
Message-Id: <1207094318-21748-2-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

The copy_user_highpage() routine has no users outside of the
core kernel code, so exporting this symbol is pointless.
This patch removes EXPORT_SYMBOL(copy_user_highpage).

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mm/init.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index c7aed13..71e5962 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -229,8 +229,6 @@ void copy_user_highpage(struct page *to, struct page *from,
 	smp_wmb();
 }
 
-EXPORT_SYMBOL(copy_user_highpage);
-
 void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
-- 
1.5.3
