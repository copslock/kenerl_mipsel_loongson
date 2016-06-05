Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:52:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042429AbcFEVw5Y0B8p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:52:57 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 293424D3;
        Sun,  5 Jun 2016 21:52:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Lars Persson <lars.persson@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.6 010/121] MIPS: Handle highmem pages in __update_cache
Date:   Sun,  5 Jun 2016 14:42:42 -0700
Message-Id: <20160605214418.022772366@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605214417.708509043@linuxfoundation.org>
References: <20160605214417.708509043@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit f4281bba818105c7c91799abe40bc05c0dbdaa25 upstream.

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
Patchwork: https://patchwork.linux-mips.org/patch/12721/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/cache.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -143,9 +143,17 @@ void __update_cache(struct vm_area_struc
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
