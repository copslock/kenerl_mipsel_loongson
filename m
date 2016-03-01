Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 03:39:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26229 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007156AbcCACjNAuG7- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 03:39:13 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7747CA1DAC059;
        Tue,  1 Mar 2016 02:39:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 02:39:07 +0000
Received: from localhost (10.100.200.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 1 Mar
 2016 02:39:06 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars Persson <lars.persson@axis.com>,
        "stable # v4 . 1+" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/4] MIPS: Handle highmem pages in __update_cache
Date:   Tue, 1 Mar 2016 02:37:58 +0000
Message-ID: <1456799879-14711-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The following patch will expose __update_cache to highmem pages. Handle
them by mapping them in for the duration of the cache maintenance, just
like in __flush_dcache_page. The code for that isn't shared because we
need the page address in __update_cache so sharing became messy. Given
that the entirity is an extra 5 lines, just duplicate it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: stable <stable@vger.kernel.org> # v4.1+
---

 arch/mips/mm/cache.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 5a67d8c..8befa55 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -149,9 +149,17 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 		return;
 	page = pfn_to_page(pfn);
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
-		addr = (unsigned long) page_address(page);
+		if (PageHighMem(page))
+			addr = (unsigned long)kmap_atomic(page);
+		else
+			addr = (unsigned long)page_address(page);
+
 		if (exec || pages_do_alias(addr, address & PAGE_MASK))
 			flush_data_cache_page(addr);
+
+		if (PageHighMem(page))
+			__kunmap_atomic((void *)addr);
+
 		ClearPageDcacheDirty(page);
 	}
 }
-- 
2.7.1
