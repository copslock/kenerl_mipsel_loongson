Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 13:53:48 +0200 (CEST)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:52294 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007601AbbE1LxA21bUx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 13:53:00 +0200
Received: from /spool/local
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dingel@linux.vnet.ibm.com>;
        Thu, 28 May 2015 12:52:57 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 28 May 2015 12:52:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 11FE61B08061;
        Thu, 28 May 2015 12:53:46 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4SBqrgX17629218;
        Thu, 28 May 2015 11:52:53 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4SBqlpv002643;
        Thu, 28 May 2015 05:52:53 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t4SBqkMO002624;
        Thu, 28 May 2015 05:52:46 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 2944)
        id 44F7D1224458; Thu, 28 May 2015 13:52:46 +0200 (CEST)
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
Subject: [PATCH 5/5] s390/mm: forward check for huge pmds to pmd_large()
Date:   Thu, 28 May 2015 13:52:37 +0200
Message-Id: <1432813957-46874-6-git-send-email-dingel@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15052811-0021-0000-0000-00000412AE02
Return-Path: <dingel@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47703
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

We already do the check in pmd_large, so we can just forward the call.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 arch/s390/mm/hugetlbpage.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 999616b..a4b2f5e 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -135,10 +135,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 
 int pmd_huge(pmd_t pmd)
 {
-	if (!MACHINE_HAS_HPAGE)
-		return 0;
-
-	return !!(pmd_val(pmd) & _SEGMENT_ENTRY_LARGE);
+	return pmd_large(pmd);
 }
 
 int pud_huge(pud_t pud)
-- 
2.3.7
