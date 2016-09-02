Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 12:01:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65204 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991344AbcIBKA1r1SLz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 12:00:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BEE5BE16CF404;
        Fri,  2 Sep 2016 11:00:09 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 11:00:11 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <lisa.parratt@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Hugh Dickins <hughd@google.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/6] MIPS: tlb-r4k: If there are wired entries, don't use TLBINVF
Date:   Fri, 2 Sep 2016 10:59:51 +0100
Message-ID: <1472810395-21381-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When adding a wired entry to the TLB via add_wired_entry, the tlb is
flushed with local_flush_tlb_all, which on CPUs with TLBINV results in
the new wired entry being flushed again.

Behavior of the TLBINV instruction applies to all applicable TLB entries
and is unaffected by the setting of the Wired register. Therefore if
the TLB has any wired entries, fall back to iterating over the entries
rather than blasting them all using TLBINVF.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/mm/tlb-r4k.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index e8b335c16295..4953c1a8cdfd 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -67,8 +67,11 @@ void local_flush_tlb_all(void)
 
 	entry = read_c0_wired();
 
-	/* Blast 'em all away. */
-	if (cpu_has_tlbinv) {
+	/*
+	 * Blast 'em all away.
+	 * If there are any wired entries, fall back to iterating
+	 */
+	if (cpu_has_tlbinv && !entry) {
 		if (current_cpu_data.tlbsizevtlb) {
 			write_c0_index(0);
 			mtc0_tlbw_hazard();
-- 
2.7.4
