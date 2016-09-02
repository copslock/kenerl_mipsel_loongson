Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 16:19:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28478 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992127AbcIBOTflBq04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 16:19:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1DA3D7594ED45;
        Fri,  2 Sep 2016 15:19:15 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 15:19:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: dec: Avoid la pseudo-instruction in delay slots
Date:   Fri, 2 Sep 2016 15:19:01 +0100
Message-ID: <20160902141902.2478-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55001
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

When expanding the la or dla pseudo-instruction in a delay slot the GNU
assembler will complain should the pseudo-instruction expand to multiple
actual instructions, since only the first of them will be in the delay
slot leading to the pseudo-instruction being only partially executed if
the branch is taken. Use of PTR_LA in the dec int-handler.S leads to
such warnings:

  arch/mips/dec/int-handler.S: Assembler messages:
  arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into multiple instructions in a branch delay slot
  arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into multiple instructions in a branch delay slot

Avoid this by placing nops in the delay slots of the affected branches,
leading to the PTR_LA macros being placed after the branches & their
delay slots. Although the nop isn't strictly needed, it's an
insignificant cost & satisfies the assembler easily with more
readable code than the possible alternative of manually expanding the
la/dla pseudo-instructions & placing the appropriate first instruction
into the delay slots.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/dec/int-handler.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index d7b9918..54ddca1 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -137,16 +137,16 @@
 		and	t0,t1			# isolate allowed ones
 
 		beqz	t0,spurious
-
 #ifdef CONFIG_32BIT
 		 and	t2,t0
 		bnez	t2,fpu			# handle FPU immediately
 #endif
+		 nop
 
 		/*
 		 * Find irq with highest priority
 		 */
-		 PTR_LA	t1,cpu_mask_nr_tbl
+		PTR_LA	t1,cpu_mask_nr_tbl
 1:		lw	t2,(t1)
 		nop
 		and	t2,t0
@@ -191,11 +191,12 @@
 1:		and	t0,t1			# mask out allowed ones
 
 		beqz	t0,spurious
+		 nop
 
 		/*
 		 * Find irq with highest priority
 		 */
-		 PTR_LA	t1,asic_mask_nr_tbl
+		PTR_LA	t1,asic_mask_nr_tbl
 2:		lw	t2,(t1)
 		nop
 		and	t2,t0
-- 
2.9.3
