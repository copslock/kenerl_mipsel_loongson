Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 13:54:07 +0200 (CEST)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:57935 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012935AbbE1LxBwVFHh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 13:53:01 +0200
Received: from /spool/local
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dingel@linux.vnet.ibm.com>;
        Thu, 28 May 2015 12:52:59 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 28 May 2015 12:52:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C0D3219005C;
        Thu, 28 May 2015 12:52:35 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4SBqtZQ24182932;
        Thu, 28 May 2015 11:52:55 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4SBqle7008642;
        Thu, 28 May 2015 05:52:54 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t4SBqk8X008601;
        Thu, 28 May 2015 05:52:46 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 2944)
        id 3B4371224439; Thu, 28 May 2015 13:52:46 +0200 (CEST)
From:   Dominik Dingel <dingel@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Zhen <zhenzhang.zhang@huawei.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/5] mm/hugetlb: remove unused arch hook prepare/release_hugepage
Date:   Thu, 28 May 2015 13:52:34 +0200
Message-Id: <1432813957-46874-3-git-send-email-dingel@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15052811-0041-0000-0000-00000494C300
Return-Path: <dingel@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dingel@linux.vnet.ibm.com
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

With s390 dropping support for emulated hugepages, the last user of
arch_prepare_hugepage and arch_release_hugepage is gone.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 mm/hugetlb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 290984b..a97958e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -917,7 +917,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
-		arch_release_hugepage(page);
 		__free_pages(page, huge_page_order(h));
 	}
 }
@@ -1102,10 +1101,6 @@ static struct page *alloc_fresh_huge_page_node(struct hstate *h, int nid)
 						__GFP_REPEAT|__GFP_NOWARN,
 		huge_page_order(h));
 	if (page) {
-		if (arch_prepare_hugepage(page)) {
-			__free_pages(page, huge_page_order(h));
-			return NULL;
-		}
 		prep_new_huge_page(h, page, nid);
 	}
 
@@ -1257,11 +1252,6 @@ static struct page *alloc_buddy_huge_page(struct hstate *h, int nid)
 			htlb_alloc_mask(h)|__GFP_COMP|__GFP_THISNODE|
 			__GFP_REPEAT|__GFP_NOWARN, huge_page_order(h));
 
-	if (page && arch_prepare_hugepage(page)) {
-		__free_pages(page, huge_page_order(h));
-		page = NULL;
-	}
-
 	spin_lock(&hugetlb_lock);
 	if (page) {
 		INIT_LIST_HEAD(&page->lru);
-- 
2.3.7
