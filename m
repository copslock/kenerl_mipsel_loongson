Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 15:15:57 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007221AbbE0NPUgBRD5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 15:15:20 +0200
Date:   Wed, 27 May 2015 14:15:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 3/3] MIPS: tlb-r3k: Optimise a TLBWI barrier in TLB
 invalidation
In-Reply-To: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505262328030.11225@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Replace an explicit barrier with a useful processor instruction in TLB 
invalidation, following several other such cases elsewhere in 
`tlb-r3k.c'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-tlb-r3k-flush-barrier.diff
Index: linux-20150524-3maxp/arch/mips/mm/tlb-r3k.c
===================================================================
--- linux-20150524-3maxp.orig/arch/mips/mm/tlb-r3k.c
+++ linux-20150524-3maxp/arch/mips/mm/tlb-r3k.c
@@ -45,10 +45,10 @@ static void local_flush_tlb_from(int ent
 
 	old_ctx = read_c0_entryhi() & ASID_MASK;
 	write_c0_entrylo0(0);
-	for (; entry < current_cpu_data.tlbsize; entry++) {
+	while (entry < current_cpu_data.tlbsize) {
 		write_c0_index(entry << 8);
 		write_c0_entryhi((entry | 0x80000) << 12);
-		BARRIER;
+		entry++;				/* BARRIER */
 		tlb_write_indexed();
 	}
 	write_c0_entryhi(old_ctx);
