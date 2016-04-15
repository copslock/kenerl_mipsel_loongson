Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:40:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36948 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026666AbcDOKj1lXoWe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:39:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 047A06DD93922;
        Fri, 15 Apr 2016 11:39:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:39:21 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:39:20 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Huacai Chen" <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 08/12] MIPS: mm: Don't clobber $1 on XPA TLB refill
Date:   Fri, 15 Apr 2016 11:36:56 +0100
Message-ID: <1460716620-13382-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.59]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53005
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

From: James Hogan <james.hogan@imgtec.com>

For XPA kernels build_update_entries() uses $1 (at) as a scratch
register, but doesn't arrange for it to be preserved, so it will always
be clobbered by the TLB refill exception. Although this register
normally has a very short lifetime that doesn't cross memory accesses,
TLB refills due to instruction fetches (either on a page boundary or
after preemption) could clobber live data, and its easy to reproduce
the clobber with a little bit of assembler code.

Note that the use of a hardware page table walker will partly mask the
problem, as the TLB refill handler will not always be invoked.

This is fixed by avoiding the use of the extra scratch register. The
pte_high parts (going into the lower half of the EntryLo registers) are
loaded and manipulated separately so as to keep the PTE pointer around
for the other halves (instead of storing in the scratch register), and
the pte_low parts (going into the high half of the EntryLo registers)
are masked with 0x00ffffff using an ext instruction (instead of loading
0x00ffffff into the scratch register and AND'ing).

[paul.burton@imgtec.com:
  - Rebase atop other TLB work.
  - Use ext instead of an sll, srl sequence.
  - Use cpu_has_xpa instead of #ifdefs.
  - Modify commit subject to include "mm".]

Fixes: c5b367835cfc ("MIPS: Add support for XPA.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/tlbex.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ceaee32..004cd9f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1006,26 +1006,22 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 	if (config_enabled(CONFIG_XPA)) {
 		int pte_off_even = sizeof(pte_t) / 2;
 		int pte_off_odd = pte_off_even + sizeof(pte_t);
-		const int scratch = 1; /* Our extra working register */
-
-		uasm_i_addu(p, scratch, 0, ptep);
 
 		uasm_i_lw(p, tmp, pte_off_even, ptep); /* even pte */
 		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
 
-		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* odd pte */
-		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
-		UASM_i_MTC0(p, ptep, C0_ENTRYLO1);
-
-		uasm_i_lw(p, tmp, 0, scratch);
-		uasm_i_lw(p, ptep, sizeof(pte_t), scratch);
-		uasm_i_lui(p, scratch, 0xff);
-		uasm_i_ori(p, scratch, scratch, 0xffff);
-		uasm_i_and(p, tmp, scratch, tmp);
-		uasm_i_and(p, ptep, scratch, ptep);
+		uasm_i_lw(p, tmp, 0, ptep);
+		uasm_i_ext(p, tmp, tmp, 0, 24);
 		uasm_i_mthc0(p, tmp, C0_ENTRYLO0);
-		uasm_i_mthc0(p, ptep, C0_ENTRYLO1);
+
+		uasm_i_lw(p, tmp, pte_off_odd, ptep); /* odd pte */
+		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO1);
+
+		uasm_i_lw(p, tmp, sizeof(pte_t), ptep);
+		uasm_i_ext(p, tmp, tmp, 0, 24);
+		uasm_i_mthc0(p, tmp, C0_ENTRYLO1);
 		return;
 	}
 
-- 
2.8.0
