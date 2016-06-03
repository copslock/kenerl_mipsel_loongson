Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:41:00 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40089 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042097AbcFCVi6EIu74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:38:58 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53LcgwP010891
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u53Lcgbr011564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:42 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u53LcfKA026108;
        Fri, 3 Jun 2016 21:38:41 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:38:40 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Lars Persson <lars.persson@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: Handle highmem pages in __update_cache
Date:   Fri,  3 Jun 2016 17:36:24 -0400
Message-Id: <1464989831-16666-89-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
References: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Paul Burton <paul.burton@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit f4281bba818105c7c91799abe40bc05c0dbdaa25 ]

The following patch will expose __update_cache to highmem pages. Handle
them by mapping them in for the duration of the cache maintenance, just
like in __flush_dcache_page. The code for that isn't shared because we
need the page address in __update_cache so sharing became messy. Given
that the entirity is an extra 5 lines, just duplicate it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable <stable@vger.kernel.org> # v4.1+
Patchwork: https://patchwork.linux-mips.org/patch/12721/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/mm/cache.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 77d96db..576169d 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -143,9 +143,17 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
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
2.5.0
