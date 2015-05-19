Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 10:53:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55162 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013498AbbESIwRvMSJM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 10:52:17 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 04329173FB71A;
        Tue, 19 May 2015 09:52:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 19 May 2015 09:51:10 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 May 2015 09:51:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH v2 07/10] MIPS: dump_tlb: Take global bit into account
Date:   Tue, 19 May 2015 09:50:35 +0100
Message-ID: <1432025438-26431-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The TLB only matches the ASID when the global bit isn't set, so
dump_tlb() shouldn't really be skipping global entries just because the
ASID doesn't match. Fix the condition to read the TLB entry's global bit
from EntryLo0. Note that after a TLB read the global bits in both
EntryLo registers reflect the same global bit in the TLB entry.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v2:
- Check both global bits and add comment (Ralf).
- Fix typo s/absense/absence/ (Maciej).
- Use MIPS_ENTRYLO_G definition (Maciej).
- Update r3k_dump_tlb.c too (Maciej - please test).
---
 arch/mips/lib/dump_tlb.c     | 10 +++++++++-
 arch/mips/lib/r3k_dump_tlb.c |  5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index f02cc554d720..995c393e3342 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -73,7 +73,15 @@ static void dump_tlb(int first, int last)
 		 */
 		if ((entryhi & ~0x1ffffUL) == CKSEG0)
 			continue;
-		if ((entryhi & 0xff) != asid)
+		/*
+		 * ASID takes effect in absence of G (global) bit.
+		 * We check both G bits, even though architecturally they should
+		 * match one another, because some revisions of the SB1 core may
+		 * leave only a single G bit set after a machine check exception
+		 * due to duplicate TLB entry.
+		 */
+		if (!((entrylo0 | entrylo1) & MIPS_ENTRYLO_G) &&
+		    (entryhi & 0xff) != asid)
 			continue;
 
 		/*
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index e210f04b2bc3..1335e4394e33 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -35,8 +35,9 @@ static void dump_tlb(int first, int last)
 		entrylo0 = read_c0_entrylo0();
 
 		/* Unused entries have a virtual address of KSEG0.  */
-		if ((entryhi & PAGE_MASK) != KSEG0
-		    && (entryhi & ASID_MASK) == asid) {
+		if ((entryhi & PAGE_MASK) != KSEG0 &&
+		    (entrylo0 & R3K_ENTRYLO_G ||
+		     (entryhi & ASID_MASK) == asid)) {
 			/*
 			 * Only print entries in use
 			 */
-- 
2.3.6
