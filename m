Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 13:53:13 +0200 (CEST)
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:54026 "EHLO
        e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012437AbbE1Lwzp9WxN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 13:52:55 +0200
Received: from /spool/local
        by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dingel@linux.vnet.ibm.com>;
        Thu, 28 May 2015 12:52:53 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp16.uk.ibm.com (192.168.101.146) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 28 May 2015 12:52:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D9CA617D8079;
        Thu, 28 May 2015 12:53:44 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4SBqnTu24969440;
        Thu, 28 May 2015 11:52:49 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4SBqkPT025011;
        Thu, 28 May 2015 05:52:49 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t4SBqk88025001;
        Thu, 28 May 2015 05:52:46 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 2944)
        id 394701224081; Thu, 28 May 2015 13:52:46 +0200 (CEST)
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
Subject: [PATCH 1/5] s390/mm: make hugepages_supported a boot time decision
Date:   Thu, 28 May 2015 13:52:33 +0200
Message-Id: <1432813957-46874-2-git-send-email-dingel@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15052811-0025-0000-0000-00000559570B
Return-Path: <dingel@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47701
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

By dropping support for hugepages on machines which do not have
the hardware feature EDAT1, we fix a potential s390 KVM bug.

The bug would happen if a guest is backed by hugetlbfs (not supported currently),
but does not get pagetables with PGSTE.
This would lead to random memory overwrites.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 arch/s390/include/asm/page.h | 8 ++++----
 arch/s390/kernel/setup.c     | 2 ++
 arch/s390/mm/pgtable.c       | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 53eacbd..0844b78 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -17,7 +17,10 @@
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
-#define HPAGE_SHIFT	20
+#include <asm/setup.h>
+#ifndef __ASSEMBLY__
+
+extern unsigned int HPAGE_SHIFT;
 #define HPAGE_SIZE	(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
@@ -27,9 +30,6 @@
 #define ARCH_HAS_PREPARE_HUGEPAGE
 #define ARCH_HAS_HUGEPAGE_CLEAR_FLUSH
 
-#include <asm/setup.h>
-#ifndef __ASSEMBLY__
-
 static inline void storage_key_init_range(unsigned long start, unsigned long end)
 {
 #if PAGE_DEFAULT_KEY
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a5ea8bc..9ac282b 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -915,6 +915,8 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	setup_hwcaps();
 
+	HPAGE_SHIFT = MACHINE_HAS_HPAGE ? 20 : 0;
+
 	/*
 	 * Create kernel page tables and switch to virtual addressing.
 	 */
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index b2c1542..f76791e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -36,6 +36,8 @@
 #endif
 
 
+unsigned int HPAGE_SHIFT;
+
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
 	struct page *page = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
-- 
2.3.7
