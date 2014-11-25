Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 13:42:04 +0100 (CET)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:48945 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014189AbaKYMixTWK8l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 13:38:53 +0100
Received: from /spool/local
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Nov 2014 12:38:47 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 25 Nov 2014 12:38:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6A9EF2190041
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:18 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPCcjYv16187816
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:45 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAPCce3F015209
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 05:38:45 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAPCcdke015181;
        Tue, 25 Nov 2014 05:38:39 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 7FEE21224459; Tue, 25 Nov 2014 13:38:39 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2 03/10] mm: replace ACCESS_ONCE with READ_ONCE
Date:   Tue, 25 Nov 2014 13:38:30 +0100
Message-Id: <1416919117-50652-4-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112512-0013-0000-0000-000001FADD4F
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Let's change the code to access the page table elements with
READ_ONCE that does implicit scalar accesses.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 mm/gup.c    | 2 +-
 mm/memory.c | 2 +-
 mm/rmap.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index cd62c8c..f2305de 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -917,7 +917,7 @@ static int gup_pud_range(pgd_t *pgdp, unsigned long addr, unsigned long end,
 
 	pudp = pud_offset(pgdp, addr);
 	do {
-		pud_t pud = ACCESS_ONCE(*pudp);
+		pud_t pud = READ_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
diff --git a/mm/memory.c b/mm/memory.c
index 3e50383..9e0c84e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3202,7 +3202,7 @@ static int handle_pte_fault(struct mm_struct *mm,
 	pte_t entry;
 	spinlock_t *ptl;
 
-	entry = ACCESS_ONCE(*pte);
+	entry = READ_ONCE(*pte);
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
 			if (vma->vm_ops) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 19886fb..3152a9c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -581,7 +581,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 	 * without holding anon_vma lock for write.  So when looking for a
 	 * genuine pmde (in which to find pte), test present and !THP together.
 	 */
-	pmde = ACCESS_ONCE(*pmd);
+	pmde = READ_ONCE(*pmd);
 	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
 		pmd = NULL;
 out:
-- 
1.9.3
