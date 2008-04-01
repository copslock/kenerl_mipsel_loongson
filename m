Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 02:03:04 +0200 (CEST)
Received: from smtp03.mtu.ru ([62.5.255.50]:48378 "EHLO smtp03.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1103053AbYDAX7T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 01:59:19 +0200
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 463E31870882;
	Wed,  2 Apr 2008 03:58:47 +0400 (MSD)
Received: from localhost.localdomain (ppp91-76-28-42.pppoe.mtu-net.ru [91.76.28.42])
	by smtp03.mtu.ru (Postfix) with ESMTP id 2A72B1870878;
	Wed,  2 Apr 2008 03:58:47 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] [MIPS] unexport copy_from_user_page()
Date:	Wed,  2 Apr 2008 03:58:36 +0400
Message-Id: <1207094318-21748-4-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

No users for the copy_from_user_page() routine exist outside of the
core kernel code. Therefore, EXPORT_SYMBOL(copy_from_user_page) is
useless, and this patch removes it.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mm/init.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6b9d54b..ff61184 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -263,9 +263,6 @@ void copy_from_user_page(struct vm_area_struct *vma,
 	}
 }
 
-EXPORT_SYMBOL(copy_from_user_page);
-
-
 #ifdef CONFIG_HIGHMEM
 unsigned long highstart_pfn, highend_pfn;
 
-- 
1.5.3
