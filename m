Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2015 15:11:08 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:50654 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011681AbbDONLHUUps8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Apr 2015 15:11:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 5B89A2E3F5;
        Wed, 15 Apr 2015 15:11:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id J-AvlaTpVZUZ; Wed, 15 Apr 2015 15:11:02 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 9CD8A2E131;
        Wed, 15 Apr 2015 15:11:02 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 73B66109C;
        Wed, 15 Apr 2015 15:11:02 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 66F57104E;
        Wed, 15 Apr 2015 15:11:02 +0200 (CEST)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 6325D34005;
        Wed, 15 Apr 2015 15:11:02 +0200 (CEST)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id 463B080170; Wed, 15 Apr 2015 15:11:02 +0200 (CEST)
From:   Lars Persson <lars.persson@axis.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Lars Persson <larper@axis.com>
Subject: [PATCH] MIPS: Fix highmem crash in __update_cache.
Date:   Wed, 15 Apr 2015 15:10:54 +0200
Message-Id: <1429103454-29102-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Due to a change in flush_dcache_page, highmem pages may have the
dcache dirty flag set. Until there is proper support for highmen in
cache.c we must filter out highmem pages to avoid NULL pointer
dereferences.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/mm/cache.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 77d96db..46136f6 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -142,6 +142,10 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	if (unlikely(!pfn_valid(pfn)))
 		return;
 	page = pfn_to_page(pfn);
+
+	if (PageHighMem(page))
+		return;
+
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
 		addr = (unsigned long) page_address(page);
 		if (exec || pages_do_alias(addr, address & PAGE_MASK))
-- 
1.7.10.4
